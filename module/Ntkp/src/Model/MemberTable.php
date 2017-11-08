<?php
namespace Ntkp\Model;

use Zend\Db\TableGateway\TableGatewayInterface;
use Zend\Db\Adapter\Exception\RuntimeException;
use Ntkp\Model\Member;

class MemberTable
{
    private $tableGateway;
    
    public function __construct(TableGatewayInterface $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }
    
    public function fetchAll()
    {
        return $this->tableGateway->select();
    }
    
    public function getMember($id)
    {
        $id = (int)$id;
        $rowset = $this->tableGateway->select(['id' => $id]);
        $row = $rowset->current();
        if(! $row) {
            throw new \RuntimeException(sprintf(
                    'Could not find row with identifier $d',
                    $id
                ));
        }
        
        return $row;
    }
    
    public function saveMember(Member $member)
    {
        $data = [
            'name' => $member->name,
            'description' => $member->description,
            'member_type_id' => $member->member_type_id,
            'member_role_id' => $member->member_role_id,
            'property_type_id' => $member->property_type_id,
            'request_domain_id' => $member->request_domain_id,
            'activities' => $member->activities,
            'email' => $member->email,
            'url' => $member->url,
            'member_status_id' => $member->member_status_id,
        ];
        
        $id = (int) $member->id;
        if($id == 0)
        {
            $this->tableGateway->insert($data);
            $rows = $this->tableGateway->getAdapter()->query('SELECT max(id) FROM public.member')->execute();
            return $rows->current()["max"];
        } 
        
        if(! $this->getMember($id)) {
            throw new RuntimeException(sprintf(
                    'Cannot update album with identifier %d; does not exist',
                    $id
                ));
        }
        
        $this->tableGateway->update($data, ['id' => $id]);
        return $id;
    }
    
    public function deleteMember($id)
    {
        return $this->tableGateway->delete(['id' => $id]);
    }
}

