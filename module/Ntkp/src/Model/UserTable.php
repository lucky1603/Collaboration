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
use Zend\Db\Sql\Where;

/**
 * Description of UserTable
 *
 * @author Sinisa Ristic
 */
class UserTable {
    
    private $tableGateway;
    
    /**
     * Konstruktor.
     * @param TableGatewayInterface $tableGateway
     */
    public function __construct(TableGatewayInterface $tableGateway) {
        $this->tableGateway = $tableGateway;
    }
    
    /**
     * Dostavlja sve.
     * @return unknown
     */
    public function fetchAll()
    {
        return $this->tableGateway->select();
    }
    
    /**
     * Dostavlja korisnika iz baze.
     * @param unknown $id
     * @throws RuntimeException
     * @return mixed
     */
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
    
    /**
     * Čuva korisnika u bazi.
     * @param User $user
     * @throws RuntimeException
     * @return mixed|number
     */
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
    
    /**
     * Briše korisnika sa datim id-om.
     * @param unknown $id
     */
    public function deleteUser($id)
    {        
        $this->tableGateway->delete(['id' => (int) $id]);
    }
    
    /**
     * Briše sve korisnike sa id-ovima koji su u array-u.
     * @param unknown $ids
     */
    public function deleteUsers($ids)
    {
        $where = new Where();
        $where->in('id', $ids);
        $this->tableGateway->delete($where);
    }
}
