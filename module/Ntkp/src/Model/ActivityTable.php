<?php
namespace Ntkp\Model;

use Zend\Db\TableGateway\TableGatewayInterface;

class ActivityTable
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
    
    public function getActivity($id)
    {
        $rows = $this->tableGateway->select(['id' => $id]);
        $row = $rows->current();
        return $row;
    }
    
    public function saveActivity(Activity $activity)
    {
        $data = $activity->getArrayCopy();
        unset($data['id']);
        
        $id = (int) $activity->id;
        if(0 == $id)
        {            
            $this->tableGateway->insert($data);
        } else {
            $this->tableGateway->update($data, ['id' => $id]);
        }
    }
    
    public function deleteActivity($id)
    {
        return $this->tableGateway->delete(['id' => $id]);
    }
}

