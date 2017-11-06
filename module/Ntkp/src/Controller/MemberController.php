<?php
namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\ServiceManager\ServiceManager;
use Ntkp\Model\MemberTable;
use Ntkp\Model\MemberView;
use Ntkp\Form\MemberForm;
use Ntkp\Model\Member;
use Zend\View\Model\ViewModel;

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
     * Deletes the member.
     * @param unknown $id - Identification code of the member
     */
    public function deleteAction($id)
    {
        $id = (int)$this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            return $this->redirect()->toRoute('member');
        }
        
        $table = $this->serviceManager->get(MemberTable::class);
        $table->deleteUser($id);
        
        return $this->redirect()->toRoute('member');
    }
}

