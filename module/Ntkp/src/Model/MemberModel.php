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
    
    private $serviceManager;
    private $dbAdapter;
    private $sql;
    
    public function __construct(ServiceManager $serviceManager, $id = null)
    {
        $this->serviceManager = $serviceManager;
        $this->dbAdapter = $this->serviceManager->get(Adapter::class);
        $this->sql = new Sql($this->dbAdapter);
        $this->users = array();
        
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
        
        return $data;
    }
    
    public function save()
    {
        // Get members table.
        $memberTable = $this->serviceManager->get(MemberTable::class);
        // is it update or insert
        if(isset($this->member->id) && (int)$this->member->id != 0)
        {
            echo "has id and it is ".$this->member->id.'<br />';
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
            
            if(isset($this->users) && count($this->users) > 0)
            {
                $userMemberGateway = new TableGateway('user_member', $this->dbAdapter);
                
                $userTable = $this->serviceManager->get(UserTable::class);
                foreach($this->users as $user)
                {
                    if(isset($user->id))
                    {
                        $userTable->saveUser($user);
                    } else {
                        $id = $userTable->saveUser($user);
                        $userMemberGateway->insert(['user_id' => $id, 'member_id' => $member_id]);
                    }
                }
            }
        }
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
    
    
    
}

