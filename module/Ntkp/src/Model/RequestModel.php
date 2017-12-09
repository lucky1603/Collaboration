<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\Sql\Sql;
use Zend\Db\TableGateway\TableGateway;
use Zend\ServiceManager\ServiceManager;

/**
 * Description of RequestModel
 *
 * @author Sinisa
 */
class RequestModel {
    public $request;
    public $documents;
    
    private $serviceManager;
    private $adapter;
    
    public function __construct(ServiceManager $sm) {
        $this->serviceManager = $sm;
        $this->adapter = $this->serviceManager->get(AdapterInterface::class);
        $this->documents = [];
    }
    
    /**
     * Interface service method. Initializing object from an array.
     * @param type $data
     */
    public function exchangeArray($data)
    {
        $this->request->exchangeArray($data);
        if(isset($data['documents']) && count($data['documents']) > 0)
        {
            foreach($data['documents'] as $key => $value)
            {
                $this->documents[$key] = $value;
            }
        }
    }
    
    /**
     * Interface service method. Retrieving the object data as array.
     * @return type
     */
    public function getArrayCopy()
    {
        $data = $this->request->getArrayCopy();
        if(isset($this->documents) && count($this->documents) > 0) {
            $data['documents'] = [];
            foreach($this->documents as $key => $value)
            {
                $data['documents'][$key] = $value;
            }
        }
        
        return $data;
    }
    
    /**
     * Fetch all requests.
     * @return type
     */
    public function fetchAll()
    {
        $sql = new Sql($this->adapter);
        $select = $sql->select();
        $select->from('request')
                ->join('member', 'init_member_id = member.id', ['MemberName' => 'name'])
                ->join('request_type', 'request_type_id = request_type.id', ['RequestType' => 'name'])
                ->join('status', 'status_id = status.id', ['StatusText' => 'tekst'])
                ->join('request_domain', 'request_domain_id = request_domain.id', ['Saradnja' => 'name']);
        $statement = $sql->prepareStatementForSqlObject($select);
        $rows = $statement->execute();
        
        return $rows;
    }
    
    public function setId($id)
    {
        $id = (int) $id;
        if($id == 0) {
            return;
        }
        
        $tableGateway = new TableGateway('request', $this->adapter);
        
        $row = $rows->current();        
        $this->request->exchangeArray($row);
        
        $tableGateway = new TableGateway('request_document', $this->adapter);
        $rows = $tableGateway->select(['id' => $id]);
        if($rows->count() > 0)
        {
            
        }
        
        
        
    }
    
}
