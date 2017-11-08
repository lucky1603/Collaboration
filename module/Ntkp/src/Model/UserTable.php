<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

use Zend\Db\TableGateway\TableGatewayInterface;
use Zend\Db\Adapter\Exception\RuntimeException;
use Ntkp\Model\User;
use Zend\Db\Sql\Sql;

/**
 * Description of UserTable
 *
 * @author Sinisa Ristic
 */
class UserTable {
    
    private $tableGateway;
    
    public function __construct(TableGatewayInterface $tableGateway) {
        $this->tableGateway = $tableGateway;
    }
    
    public function fetchAll()
    {
        return $this->tableGateway->select();
    }
    
    public function getUser($id)
    {
        $id = (int) $id;
        $rowset = $this->tableGateway->select(['id' => $id]);
        $row = $rowset->current();
        if(! $row) {
            throw new RuntimeException(sprintf(
                'Could not find row with identifier $d',
                $id
            ));
        }
        
        return $row;
    }
    
    public function saveUser(User $user)
    {
        $data = [
            'name' => $user->name,
            'email' => $user->email,
            'role_id' => $user->role_id,
            'username' => $user->username,
            'password' => $user->password,
            'description' => $user->description,     
            'user_status_id' => $user->user_status_id,            
        ];
        
        $id = (int) $user->id;
        if($id == 0)
        {
            $this->tableGateway->insert($data);
            $rows = $this->tableGateway->getAdapter()->query('SELECT max(id) FROM public.user')->execute();            
            return $rows->current()["max"];                              
        }
        
        if(! $this->getUser($id)) {
            throw new RuntimeException(sprintf(
                'Cannot update album with identifier %d; does not exist',
                $id
            ));
        }
        
        $this->tableGateway->update($data, ['id' => $id]);
        
        return $id;
    }
    
    public function deleteUser($id)
    {
        
        $this->tableGateway->delete(['id' => (int) $id]);
    }
}
