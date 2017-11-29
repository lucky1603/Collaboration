<?php
namespace Ntkp\Controller;

use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\Db\TableGateway\TableGateway;
use Zend\ServiceManager\ServiceManager;
use Zend\View\Model\ViewModel;
use Zend\Debug\Debug;


class IndexController extends AbstractActionController
{
    private $serviceManager;
    private $adapter;
    
    public function __construct(ServiceManager $serviceManager) {
        $this->serviceManager = $serviceManager;
        $this->adapter = $this->serviceManager->get(Adapter::class);
    }
    
    public function indexAction()
    {
        $user = $this->checkUser();
        if(! isset($user))
        {
            return $this->redirect()->toRoute('login');
        }
        
        $memberUserTable = new TableGateway('user_member', $this->adapter);
        
        switch($user->role_id)
        {
            case 1:                
                $viewModel = new ViewModel();
                $viewModel->setTemplate('/ntkp/index/sadmin.phtml');
                break;
            case 2:
                $memberUsers = $memberUserTable->select(['user_id' => $user->id]);
                if(count($memberUsers) == 0)
                {
                    return $this->redirect()->toRoute('login');
                }
                
                $member_id = $memberUsers->current()['member_id'];                
                $memberModel = $this->serviceManager->get(\Ntkp\Model\MemberModel::class);
                $memberModel->setId($member_id);
                $viewData = ['user' => $user, 'memberModel' => $memberModel];
                
                $viewModel = new ViewModel($viewData);
                $viewModel->setTemplate('/ntkp/index/admin.phtml');                
                break;
            case 3:
                $memberUsers = $memberUserTable->select(['user_id' => $user->id]);
                if(count($memberUsers) == 0)
                {
                    return $this->redirect()->toRoute('login');
                }
                
                $member_id = $memberUsers->current()['member_id'];
                $memberModel = $this->serviceManager->get(\Ntkp\Model\MemberModel::class);
                $memberModel->setId($member_id);
                $viewData = ['user' => $user, 'memberModel' => $memberModel];
                
                $viewModel = new ViewModel($viewData);
                $viewModel->setTemplate('/ntkp/index/user.phtml');                
                break;
            default:
                break;
        }
       
       return $viewModel;
    }
    
    private function checkUser()
    {
        $authService = $this->serviceManager->get("AuthenticationService");
        $mail = $authService->getStorage()->read();
        if(isset($mail))
        {
            $table = $this->serviceManager->get(\Ntkp\Model\UserTable::class);
            $user = $table->getUserByEmail($mail);
            if(isset($user))
            {
                return $user;
            }                
            
        }
        
        return null;
    }
}

