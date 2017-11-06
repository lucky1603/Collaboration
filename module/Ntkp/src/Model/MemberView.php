<?php
namespace Ntkp\Model;

use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;


class MemberView
{
    private $adapter;
    private $sql;
    
    public function __construct(Adapter $adapter, $id = NULL)
    {
        $this->adapter = $adapter;
        $this->sql = new Sql($this->adapter);
        if($id != NULL)
        {
            $this->setId($id);    
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
        
    }
}

