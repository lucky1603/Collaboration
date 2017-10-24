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
use Zend\ServiceManager\ServiceManager;

/**
 * Description of UserController
 *
 * @author Sinisa Ristic
 */
class UserController extends AbstractActionController {
    private $serviceManager;
    
    public function __construct(ServiceManager $manager) {
        $this->serviceManager = $manager;
    }
    
    public function indexAction() {
        $table = $this->serviceManager->get(UserTable::class);
        $users = $table->fetchAll();
        $userData = [];
        foreach($users as $user)
        {
            $id = $user->role_id;
            $roleName = $this->serviceManager->get('RoleModel')->getRole($id);
            $user->role_id = $roleName;
            $statusValue = $this->serviceManager->get('UserStatusModel')->getUserStatusValue($user->user_status_id);
            $user->user_status_id = $statusValue;
            
            $userData[] = $user;
        }
        
        return new ViewModel([
            'users' => $userData,
        ]);
    }
}
