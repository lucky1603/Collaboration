<?php

namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Ntkp\Model\UserTable;
use Zend\ServiceManager\ServiceManager;
use Ntkp\Form\UserForm;
use Ntkp\Model\User;
use Zend\Session\Container;
use Ntkp\Model\MemberModel;
use Zend\Escaper\Escaper;
use Zend\Debug\Debug;

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
            $user->company = $table->getUserCompany($user->id);
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
        $ret = $userTable->saveUser($user);
        
        return $this->redirect()->toRoute('user', ['action' => 'index']);
    }
    
    public function addUserMemberAction()
    {
        // Create form.
        $form = $this->serviceManager->get(UserForm::class);
        $form->get('submit')->setValue('Dodaj korisnika');
        
        // Initialize member model.
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->exchangeArray($session->memberModelData);
                       
        $request = $this->getRequest();        
        if(! $request->isPost()) {
            return ['form' => $form, 'model' => $memberModel];
        }
        
        $user = new User();
        $form->bind($user);
        $form->setInputFilter($user->getInputFilter());
        $form->setData($request->getPost());
        
        if(! $form->isValid())
        {
            return ['form' => $form, 'model' => $memberModel];
        }
        
        $memberModel->addUser($user);
        $session->memberModelData = $memberModel->getArrayCopy();
        
        if(! isset($memberModel->member->id) || $memberModel->member->id == 0)
        {
            return $this->redirect()->toRoute('member', ['action' => 'addWithModel']);
        }
        
        return $this->redirect()->toUrl('/member/editWithModel/'.$memberModel->member->id.'#tab2');
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
        
//        Debug::dump($user->password);
        
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
        
//        Debug::dump($user->password);
//        die();
        $table->saveUser($user);
        
        return $this->redirect()->toRoute('user', ['action' => 'index']);
    }
    
    public function editUserMemberAction(){
        // Create form.
        $form = $this->serviceManager->get(UserForm::class);
        $form->get('submit')->setValue('Potvrdi');
        
        $id = (int) $this->params()->fromRoute('id', -1);
        if(-1 == $id)
        {
            return $this->redirect()->toRoute('user', ['action' => 'addUserMember']);
        }
                       
        // Initialize member model.
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->exchangeArray($session->memberModelData);
        $user = $memberModel->users[$id];       
        $form->bind($user);        
        //Debug::dump($user->password);
   
        $request = $this->getRequest();                
        $viewData = ['id' => $id, 'form' => $form, 'model' => $memberModel];
        $viewModel = new ViewModel($viewData);
        $viewModel->setTemplate('/ntkp/user/add-user-member');
        if(! $request->isPost()) {
            return $viewModel;
        }
        
        $data = $request->getPost();
        
//        if(! isset($data['password']))
//        {
//            $data['password'] = $user->password;
//        }
        
        $form->setInputFilter($user->getInputFilter());
        $form->setData($request->getPost());        

        if(! $form->isValid())
        {
            return $viewModel;
        }
        
        //Debug::dump($user->password);    
        //die();
        $memberModel->users[$id] = $user;
        $session->memberModelData = $memberModel->getArrayCopy();
        
        if(! isset($memberModel->member->id) || $memberModel->member->id == 0)
        {
            return $this->redirect()->toRoute('member', ['action' => 'addWithModel']);
        }
        
        return $this->redirect()->toUrl('/member/editWithModel/'.$memberModel->member->id.'#tab2');
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
    
    /**
     * Deletes the user from the member.
     * @return \Zend\Http\Response
     */
    public function deleteMemberUserAction()
    {
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $session = new Container('models');
        $memberModel->exchangeArray($session->memberModelData);
        
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toUrl('/member/editWithModel/'.$memberModel->member->id.'#tab2');
        }
        
        $memberModel->deleteUser($id);
        $session->memberModelData = $memberModel->getArrayCopy();
        
        return $this->redirect()->toUrl('/member/editWithModel/'.$memberModel->member->id.'#tab2');
    }
    
    
    public function testAction()
    {
        return $this->redirect()->toUrl('/member/editWithModel/3#tab2');
    }
}
