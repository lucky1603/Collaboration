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
use Zend\Db\TableGateway\TableGateway;

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
    
    public function getUserbyEmail($email)
    {
        $rowset = $this->tableGateway->select(['email' => $email]);
        if($rowset->count() == 0)
        {
            return null;
        }
        
        $user = $rowset->current();
        if(! $user) {
            throw new RuntimeException(sprintf(
                'Could not find user with identifier $d',
                $id
            ));
        }
        
        return $user;
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
            $sql = new \Zend\Db\Sql\Sql($this->tableGateway->getAdapter());
            $select = $sql->select();
         
            $select->from('user')
                   ->order('id DESC')
                   ->limit(1);
            $statement = $sql->prepareStatementForSqlObject($select);
            $rows = $statement->execute();

            return $rows->current()["id"];                           
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
    
    public function getUserCompany($user_id)
    {
        $sql = new Sql($this->tableGateway->getAdapter());
        $select = $sql->select();
        $select->from('user_member')
                ->join(['m' => 'member'], 'member_id = m.id', ['MemberName' => 'name'])
                ->where(['user_id' => $user_id]);
        $statement = $sql->prepareStatementForSqlObject($select);
        $rows = $statement->execute();
        if($rows->count() > 0)
        {
            $row = $rows->current();
            return $row['MemberName'];
        }
        
        return "none";
    }
}
