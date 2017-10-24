<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

/**
 * Description of RoleModel
 *
 * @author Sinisa Ristic
 */
class RoleModel {
    private $tableGateway;
    
    public function __construct(\Zend\Db\TableGateway\TableGateway $tableGateway) {
        $this->tableGateway = $tableGateway;
    }
    
    public function getRole($id)
    {
        $rowset = $this->tableGateway->select(['id' => (int) $id]);
        $row = $rowset->current();
        return $row->name;
    }
}
