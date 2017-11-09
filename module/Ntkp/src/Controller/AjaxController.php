<?php
namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Mvc\MvcEvent;
use Zend\Authentication\Storage\Session;
use Zend\ServiceManager\ServiceManager;
use Ntkp\Model\MemberModel;
use Zend\Session\Container;

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
}

