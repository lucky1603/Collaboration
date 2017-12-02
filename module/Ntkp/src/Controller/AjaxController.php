<?php
namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Mvc\MvcEvent;
use Zend\Authentication\Storage\Session;
use Zend\ServiceManager\ServiceManager;
use Ntkp\Model\MemberModel;
use Ntkp\Model\ActivityTable;
use Zend\Session\Container;
use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;

class AjaxController extends AbstractActionController
{
    private $serviceManager;
    private $viewModel;
    
    public function __construct(ServiceManager $serviceManager)
    {
        $this->serviceManager = $serviceManager;
    }
    
    public function onDispatch(MvcEvent $mvcEvent)
    {
        $this->viewModel = new ViewModel; // Don't use $mvcEvent->getViewModel()!
        $this->viewModel->setTemplate('/ntkp/ajax/response');
        $this->viewModel->setTerminal(true); // Layout won't be rendered
        
        return parent::onDispatch($mvcEvent);
    }
    
    public function someAction()
    {
        return $this->viewModel->setVariable('response', json_encode("Hej!!!"));
    }
    
    /**
     * Saves member model to the post session.
     * @return \Zend\View\Model\ViewModel
     */
    public function rememberMemberModelAction()
    {        
        $post = $this->request->getPost();               
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);
        if(isset($session->memberModelData))
        {
            $memberModel->exchangeArray($session->memberModelData);
        }
        
        $memberModel->member->exchangeArray($post);
        $session->memberModelData = $memberModel->getArrayCopy();
                
        $this->viewModel->setVariable('response', json_encode($session->memberModelData));
        return $this->viewModel;
    }
    
    
    /**
     * Gets the list of the available activity sections.
     * @return \Zend\View\Model\ViewModel
     */
    public function getActivitySectionsAction()
    {
        $adapter = $this->serviceManager->get(Adapter::class);
        $tableGateway = new TableGateway('activity_section', $adapter);
        $rows = $tableGateway->select()->toArray();
        $this->viewModel->setVariable('response', json_encode($rows));
        return $this->viewModel;
    }
    
    /**
     * Get all activities for the given section. If no section is defined, it returns all activities.
     * @return \Zend\View\Model\ViewModel
     */
    public function getActivitiesAction()
    {
        $section = $this->request->getPost('section');
        $adapter = $this->serviceManager->get(Adapter::class);
        $tableGateway = new TableGateway('activity', $adapter);
        if($section)
        {
            $rows = $tableGateway->select(['section' => $section])->toArray();
        } else {
            $rows = $tableGateway->select()->toArray();
        }
        
        $this->viewModel->setVariable('response', json_encode($rows));
        return $this->viewModel;
    }
    
    /**
     * Add a reference to an activity to a member.
     * @return \Zend\View\Model\ViewModel
     */
    public function addMemberActivityAction()
    {
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->exchangeArray($session->memberModelData);
        
        $activity_id = $this->request->getPost('activity_id');
        $activityTable = $this->serviceManager->get(ActivityTable::class);
        $activity = $activityTable->getActivity($activity_id);
        if($activity)
        {
            $memberModel->addActivity($activity);
            $session->memberModelData = $memberModel->getArrayCopy();
            $this->viewModel->setVariable('response', json_encode($activity));
            return $this->viewModel;
        }
        
        $this->viewModel->setVariable('response', json_encode('FAIL'));
        return $this->viewModel;
    }
    
    /**
     * Deletes the reference to an activity from a member.
     * @return \Zend\View\Model\ViewModel
     */
    public function deleteMemberActivityAction()
    {
        $id = (int) $this->params()->fromRoute('id', 0);
        if(0 == $id)
        {
            $this->viewModel->setVariable('response', json_encode('id is 0'));
            return $this->viewModel;
        }
        
        $session = new Container('models');
        $memberModel = $this->serviceManager->get(MemberModel::class);
        $memberModel->exchangeArray($session->memberModelData);
        
        $memberModel->deleteActivity($id);
        $session->memberModelData = $memberModel->getArrayCopy();
        $this->viewModel->setVariable('response', json_encode('success'));
        return $this->viewModel;
    }
}

