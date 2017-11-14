<?php
namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\ServiceManager\ServiceManager;
use Ntkp\Model\MemberTable;
use Ntkp\Model\MemberView;
use Ntkp\Form\MemberForm;
use Ntkp\Model\Member;
use Zend\View\Model\ViewModel;
use Ntkp\Model\MemberModel;
use Zend\Debug\Debug;
use Zend\Authentication\Storage\Session;
use Zend\Session\Container;
use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Ntkp\Model\ActivityTable;

/**
 * MemberController class. It handles the collaboration members.
 * @author Sinisa Ristic
 * @date 02.11.2017.
 * @version 1.0
 */
class MemberController extends AbstractActionController
{
    private $serviceManager; 
    
    /**
     * Constructor.
     * @param ServiceManager $serviceManager
     */
    public function __construct(ServiceManager $serviceManager) 
    {
        $this->serviceManager = $serviceManager;
    }
    
    /**
     * Index action. Lists all members.
     * {@inheritDoc}
     * @see \Zend\Mvc\Controller\AbstractActionController::indexAction()
     */
    public function indexAction()
    {
        // Clear models.
        $session = new Container('models');
        if(isset($session->memberModelData))
        {
            unset($session->memberModelData);
        }
        
        // Get records.
        $table = $this->serviceManager->get(MemberTable::class);
        $view = $this->serviceManager->get(MemberView::class);
        $members = $view->fetchAll();
        return ['members' => $members];
    }
    
    /**
     * Adds the new member.
     * @return mixed[]|object[]|\Zend\Http\Response
     */
    public function addAction()
    {
        $form = $this->serviceManager->get(MemberForm::class);
        $form->get('submit')->setValue('Dodaj člana');
        
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form];
        }
        
        $member = new Member();
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            return ['form' => $form];
        }
        
        $member->exchangeArray($form->getData());
        $memberTable = $this->serviceManager->get(MemberTable::class);
        $memberTable->saveMember($member);
        
        return $this->redirect()->toRoute('member', ['action' => 'index']);
    }
    
    public function addWithModelAction()
    {
        $form = $this->serviceManager->get(MemberForm::class);
        $form->get('submit')->setValue('Dodaj člana');
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);

        if(isset($session->memberModelData))
        {
            $memberModel->exchangeArray($session->memberModelData);
            $form->bind($memberModel->member);
        } else {
            $session->memberModelData = $memberModel->getArrayCopy();
        }
                    
        
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form, 'model' => $memberModel];
        }
        
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            return ['form' => $form, 'model' => $memberModel];
        }
                
        $retVal = $memberModel->save();

        return $this->redirect()->toRoute('member', ['action' => 'index']);
    }
            
    /**
     * Changes the member details.
     * @return \Zend\Http\Response
     */
    public function editAction()
    {
        $table = $this->serviceManager->get(MemberTable::class);
        $form = $this->serviceManager->get(MemberForm::class);
        
        $id = (int) $this->params()->fromRoute('id', 0);
        
        
        if(0 == $id)
        {
            return $this->redirect()->toRoute('member', ['action' => 'add']);
        }
        
        try {
            $member = $table->getMember($id);
        } catch (\Exception $e) {
            return $this->redirect()->toRoute('member', ['action' => 'index']);
        }
        
        $form->bind($member);
        $form->get('submit')->setAttribute('value', 'Promeni podatke');
        
        $request = $this->getRequest();
        $viewData = ['id' => $id, 'form' => $form];
        $viewModel = new ViewModel($viewData);
        $viewModel->setTemplate('/ntkp/member/add');
        if(! $request->isPost())
        {
            return $viewModel;
        }
                
        // todo input filter
        $form->setData($request->getPost());
        if(! $form->isValid()) {            
           return $viewModel;
        }
        
        $table->saveMember($member);
        
        return $this->redirect()->toRoute('member', ['action' => 'index']);        
    }
    
    /**
     * Edit action using MemberModel class.
     * @return \Zend\Http\Response
     */
    public function editWithModelAction()
    {
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toRoute('member', ['action' => 'add']);
        }
        
        $memberModel = $this->serviceManager->get(MemberModel::class);
        
        $session = new Container('models');
        if(! isset($session->memberModelData))
        {
            $memberModel->setId($id);
        } else {
            $memberModel->exchangeArray($session->memberModelData);
            if($memberModel->member->id != $id)
            {
                $memberModel->setId($id);
            }
        }
        
        $form = $this->serviceManager->get(MemberForm::class);
        $form->bind($memberModel->member);
        $form->get('submit')->setAttribute('value', 'Promeni podatke');
        
        $request = $this->getRequest();
        $dbAdapter = $this->serviceManager->get(Adapter::class);
        
        $table = new TableGateway('role', $dbAdapter);
        $results = $table->select()->toArray();
        foreach($results as $result)
        {
            $roles[$result['id']] = $result['name'];
        }
        
        
        $table = new TableGateway('user_status', $dbAdapter);
        $results = $table->select();
        foreach($results as $result)
        {
            $statuses[$result['id']] = $result['value'];
        }
        
        $viewData = ['id' => $id, 'form' => $form, 'model' => $memberModel, 'roles' => $roles, 'statuses' => $statuses];
        $viewModel = new ViewModel($viewData);
        
        if(! $request->isPost())
        {
            $session->memberModelData = $memberModel->getArrayCopy();
            return $viewModel;
        }
        
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            // If you want to know, what is goint on, uncomment the line below.
            //echo $form->getMessages();
            $session->memberModelData = $memberModel->getArrayCopy();
            return $viewModel;
        }
        
        $memberModel->save();
        unset($session->memberModelData);
        
        return $this->redirect()->toRoute('member');
    }
    
    /**
     * Deletes the member.
     * @param unknown $id - Identification code of the member
     */
    public function deleteAction()
    {
        $id = (int)$this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toRoute('member');
        }
        
        $table = $this->serviceManager->get(MemberTable::class);
        $table->deleteMember($id);
        
        return $this->redirect()->toRoute('member');
    }
    
    /**
     * Delete using member model.
     * @return \Zend\Http\Response
     */
    public function deleteWithModelAction()
    {
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toRoute('member');
        }
        
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->setId($id);
        $memberModel->delete();
        
        return $this->redirect()->toRoute('member');
    }
    
    public function testAction()
    {
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->setId(1);
        Debug::dump($memberModel->getArrayCopy());
        die();
        
    }
}

