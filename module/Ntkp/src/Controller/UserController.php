<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Ntkp\Model\UserTable;

/**
 * Description of UserController
 *
 * @author Sinisa Ristic
 */
class UserController extends AbstractActionController {
    private $table;
    
    public function __construct(UserTable $table) {
        $this->table = $table;
    }
    
    public function indexAction() {
        return new ViewModel([
            'users' => $this->table->fetchAll()
        ]);
    }
}
