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
use Ntkp\Form\UserForm;
use Ntkp\Model\User;

/**
 * Description of UserController
 *
 * @author Sinisa Ristic
 */
class UserController extends AbstractActionController {
    private $serviceManager;
    
    /**
     * Constructor.
     * @param ServiceManager $manager
     */
    public function __construct(ServiceManager $manager) {
        $this->serviceManager = $manager;
    }
    
    /**
     * Lists all users.
     * {@inheritDoc}
     * @see \Zend\Mvc\Controller\AbstractActionController::indexAction()
     */
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
    
    /**
     * Adds the new user to the system.
     * @return mixed[]|object[]|\Zend\Http\Response
     */
    public function addAction()
    {
        $form = $this->serviceManager->get(UserForm::class);
        $form->get('submit')->setValue('Dodaj korisnika');
        
        $request = $this->getRequest();
        
        if(! $request->isPost()) {
            return ['form' => $form];
        }
        
        $user = new User();
        $form->setInputFilter($user->getInputFilter());
        $form->setData($request->getPost());
        
        if(! $form->isValid())
        {
            return ['form' => $form];
        }
        
        $user->exchangeArray($form->getData());
        $userTable = $this->serviceManager->get(UserTable::class);
        $userTable->saveUser($user);
        
        return $this->redirect()->toRoute('user', ['action' => 'index']);
    }
    
    /**
     * Edits the selected user data.
     * @return \Zend\Http\Response|\Zend\View\Model\ViewModel
     */
    public function editAction()
    {
        $table = $this->serviceManager->get(UserTable::class);
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id) 
        {
            return $this->redirect()->toRoute('user', ['action' => 'add']);
        }
        
        try {
            $user = $table->getUser($id);
        } catch (\Exception $e) {
            return $this->redirect()->toRoute('user', ['action' => 'index']);
        }
        
        $form = $this->serviceManager->get(UserForm::class);
        $form->bind($user);
        $form->get('submit')->setAttribute('value', 'Promeni podatke');
        
        $request = $this->getRequest();
        $viewData = ['id' => $id, 'form' => $form];
        $viewModel = new ViewModel($viewData);
        $viewModel->setTemplate('/ntkp/user/add');
        
        if(! $request->isPost()) {
            return $viewModel;
        }
        
        $form->setInputFilter($user->getInputFilter());
        $form->setData($request->getPost());
        
        if(! $form->isValid()) {
            return $viewModel;
        }
        
        $table->saveUser($user);
        
        return $this->redirect()->toRoute('user', ['action' => 'index']);
    }
    
    /**
     * Delete current user.
     * @return \Zend\Http\Response
     */
    public function deleteAction() 
    {
        $table = $this->serviceManager->get(UserTable::class);
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toRoute('user', ['action' => 'index']);
        }
        
        $table->deleteUser($id);
        return $this->redirect()->toRoute('user', ['action' => 'index']);
    }
}
