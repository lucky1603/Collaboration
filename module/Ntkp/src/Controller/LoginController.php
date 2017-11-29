<?php
namespace Ntkp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\ServiceManager\ServiceManager;
use Zend\Db\TableGateway\TableGateway;
use Ntkp\Form\LoginForm;
use Zend\Db\Adapter\Adapter;

class LoginController extends AbstractActionController
{
    private $authService;
    private $serviceManager;
    private $adapter;
    
    public function __construct(ServiceManager $sm)
    {
        $this->serviceManager = $sm;
        $adapter = $this->serviceManager->get(Adapter::class);
        
    }
    
    public function indexAction()
    {
        $form = $this->serviceManager->get(LoginForm::class);
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form];
        }
        
        $email = $this->request->getPost('email');
        if(! $this->isMail($email)) {
            $userTable = new TableGateway('user', $this->adapter);
            $rows = $userTable->select(['username' => $user_data]);
            $row = $rows->current();
            $email = $row['email'];
        } 
                
        
        if(isset($email)) {
            $authService = $this->getAuthService();
            $adapter = $authService->getAdapter();
            $adapter->setIdentity($email);
            $adapter->setCredential($this->request->getPost('password'));
            $result = $authService->authenticate();
            \Zend\Debug\Debug::dump($result);
            
            if($result->isValid()) {
                $authService->getStorage()->write($email);
                return $this->redirect()->toRoute('dashboard');
            }
            
            $form->setData(['email' => $email]);
            return ['form' => $form];
        }
        
        return ['form' => $form];
    }
    
    public function logoutAction()
    {
        $authService = $this->serviceManager->get('AuthenticationService');
        $authService->getStorage()->write(NULL);
        return $this->redirect()->toRoute(NULL);
    }
    
    public function getAuthService()
    {
        if(! $this->authService)
        {
            $this->authService = $this->serviceManager->get('AuthenticationService');
        }
        
        return $this->authService;
    }
    
    /**
     * Checks if the user 
     * @param unknown $user
     * @return boolean
     */
    private function isMail($user)
    {
        if(strpos($user, '@') != false)
        {
            return true;
        }
        
        return false;
    }
}

