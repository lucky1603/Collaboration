<?php
namespace Ntkp\Model;

use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\ServiceManager\ServiceManager;
use Zend\Db\TableGateway\TableGateway;
use Zend\Debug\Debug;

class MemberModel
{
    public $member;
    public $users;
    public $activities;
    
    
    private $serviceManager;
    private $dbAdapter;
    private $sql;
    private $deletedUsers;
    private $deletedActivities;
    
    public function __construct(ServiceManager $serviceManager, $id = null)
    {
        $this->serviceManager = $serviceManager;
        $this->dbAdapter = $this->serviceManager->get(Adapter::class);
        $this->sql = new Sql($this->dbAdapter);
        $this->users = array();
        $this->activities = array();
        $this->deletedUsers = array();
        $this->deletedActivities = array();
        
        if($id != null)
        {
            $this->setId($id);
        } else {
            $this->member = new Member();
        }
    }
    
    public function fetchAll()
    {
        $select = $this->sql->select();
        $select->from('member')
        ->columns(['id', 'name', 'email', 'url'])
        ->join(['pt' => 'property_type'], 'property_type_id = pt.id', ['property' => 'name'])
        ->join(['mt' => 'member_type'], 'member_type_id = mt.id', ['member_type' => 'name'])
        ->join(['mr' => 'member_role'], 'member_role_id = mr.id', ['member_role' => 'name'])
        ->join(['rd' => 'request_domain'], 'request_domain_id = rd.id', ['request_domain' => 'name'])
        ->join(['ms' => 'member_status'], 'member_status_id = ms.id', ['member_status' => 'name']);
        
        $statement = $this->sql->prepareStatementForSqlObject($select);
        $results = $statement->execute();
        return $results;
    }
    
    public function setId($id)
    {
        if(!isset($id))
        {
            return;
        }
        
        $id = (int) $id;
        
        // Get member.
        $memberTable = $this->serviceManager->get(MemberTable::class);
        $this->member = $memberTable->getMember($id);
        
        // Get users.
        $this->users = [];
        $select = $this->sql->select();
        $select->from(['mu' => 'user_member'])
                ->join(['u' => 'user'], 'mu.user_id = u.id')
                ->where(['mu.member_id' => $id]);
        
        $statement = $this->sql->prepareStatementForSqlObject($select);
        $results = $statement->execute();
                
        if($results->count() > 0)
        {            
            do {
                $row = $results->current();
                $user = new User();
                $user->exchangeArray($row);                
                $this->users[] = $user;
            } while ($results->next());
        }
        
        // Get activities.
        $this->activities = [];
        $select = $this->sql->select();
        $select->from(['ma' => 'member_activity'])
                ->join(['a' => 'activity'], 'ma.activity_id = a.id')
                ->where(['ma.member_id' => $id]);
        $statement = $this->sql->prepareStatementForSqlObject($select);
        $results = $statement->execute();
        
        if($results->count() > 0)
        {
            do {
                $row = $results->current();               
                $activity = new \Ntkp\Model\Activity();
                $data = [
                    'id' => $row['activity_id'],
                    'section' => $row['section'],
                    'class' => $row['class'],
                    'description' => $row['description'],
                ];
                
                $activity->exchangeArray($data);
                $this->activities[] = $activity;
            } while ($results->next());
        }
        
        $this->deletedActivities = array();
        $this->deletedUsers = array();
    }
    
    public function exchangeArray($data)
    {
        $this->member->exchangeArray($data);
        if(isset($data['users']) && count($data['users']) > 0)
        {
            $this->users = array();
            foreach($data['users'] as $userData)
            {
                $user = new User();
                $user->exchangeArray($userData);
                $this->users[] = $user;
            }
        }
        
        if(isset($data['activities']) && count($data['activities']) > 0)
        {
            $this->activities = array();
            foreach($data['activities'] as $activityData)
            {
                $activity = new Activity();
                $activity->exchangeArray($activityData);
                $this->activities[] = $activity;
            }
        }
    }
    
    public function getArrayCopy()
    {
        $data = $this->member->getArrayCopy();
        if(isset($this->users) && count($this->users) > 0)
        {
            $data['users'] = array();
            foreach($this->users as $user)
            {
                $userData = $user->getArrayCopy();
                $data['users'][] = $userData;            
            }
                       
        }
        
        if(isset($this->activities) && count($this->activities) > 0)
        {
            $data['activities'] = array();
            foreach($this->activities as $activity)
            {
                $activityData = $activity->getArrayCopy();
                $data['activities'][] = $activityData;
            }
        }
        
        return $data;
    }
    
    public function save()
    {
        // Get members table.
        $memberTable = $this->serviceManager->get(MemberTable::class);
        // is it update or insert
        if(isset($this->member->id) && (int)$this->member->id != 0)
        {
            // update
            $memberTable->saveMember($this->member);
            
            if(isset($this->users) && count($this->users) > 0)
            {
                $userMemberGateway = new TableGateway('user_member', $this->dbAdapter);
                $userTable = $this->serviceManager->get(UserTable::class);
                foreach($this->users as $user)
                {
                    if(isset($user->id) && $user->id != 0)
                    {
                        $userTable->saveUser($user);
                    } else {
                        $id = $userTable->saveUser($user);
                        $userMemberGateway->insert(['user_id' => $id, 'member_id' => $this->member->id]);
                    }
                }
            }
            
        } else {
            // insert
            $member_id = $memberTable->saveMember($this->member);
            $retUsers = array();
            if(isset($this->users) && count($this->users) > 0)
            {
                $userMemberGateway = new TableGateway('user_member', $this->dbAdapter);
                
                $userTable = $this->serviceManager->get(UserTable::class);
                foreach($this->users as $user)
                {
                    if(isset($user->id) && $user->id != 0)
                    {
                        $userTable->saveUser($user);
                    } else {
                        $id = $userTable->saveUser($user);
                        $userMemberGateway->insert(['user_id' => $id, 'member_id' => $member_id]);
                        $retUsers[] = ['member_id' => $member_id, 'user_id' => $id];
                    }
                }
            }
            
            return $retUsers;
        }
        
        return "none";
    }
    
    /**
     * Delete member data.
     */
    public function delete()
    {
        // Uzmi tablu članova.
        $memberTable = $this->serviceManager->get(MemberTable::class);
        
        // Proveri da li je prethodno podešen id.
        if(isset($this->member->id) && (int)$this->member->id != 0)
        {            
            // Prvo proveri user-e, da li ih ima priključenih.
            if(isset($this->users) && count($this->users) > 0)
            {
                // Ako ima, pokupi
                $userMemberGateway = new TableGateway('user_member', $this->dbAdapter);
                $rows = $userMemberGateway->select(['member_id' => $this->member->id])->toArray();
                $userIds = array();
                foreach($rows as $row)
                {
                    $userIds[] = $row['user_id'];
                }

                // I obrisi.
                $userTable = $this->serviceManager->get(UserTable::class);
                //$userTable->delete()->where->in('id', $userIds);
                $userTable->deleteUsers($userIds);
            }
            
            // A sada obriši i člana.
            $memberTable->deleteMember($this->member->id);
        }
            
        // A sada obriši i interne podatke.
        unset($this->member);
        unset($this->users);
        
        $this->member = new Member();
        $this->users = array();            
    }
    
    /**
     * Helper function which gets the user role list.
     * @return $roles Array of user roles
     */
    public function getUserRoles()
    {
        $table = new TableGateway('role', $this->dbAdapter);
        $results = $table->select()->toArray();
        $roles = array();
        foreach($results as $result)
        {
            $roles[$result['id']] = $result['name'];
        }
        
        return $roles;
    }
    
    /**
     * Helper function which gets the user statuses.
     * @return $statuses Array of user statuses.
     */
    public function getUserStatuses()
    {
        $table = new TableGateway('user_status', $this->dbAdapter);
        $results = $table->select()->toArray();
        $statuses = array();
        foreach($results as $result)
        {
            $statuses[$result['id']] = $result['value'];
        }
        
        return $statuses;
    }
    
    public function deleteUser($id)
    {
        $this->deletedUsers[] = $this->users[$id];
        unset($this->users[$id]);        
    }
    
    public function deleteActivity($id)
    {
        $this->deletedActivities[] = $this->activities[$id];
        unset($this->activities[$id]);
    }
    
}

