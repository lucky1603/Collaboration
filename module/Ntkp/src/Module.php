<?php
/*
 * Module manager file.
 */
namespace Ntkp;
use Ntkp\Controller\AjaxController;
use Ntkp\Controller\IndexController;
use Ntkp\Controller\LoginController;
use Ntkp\Controller\MemberController;
use Ntkp\Controller\UserController;
use Ntkp\Form\LoginForm;
use Ntkp\Form\MemberForm;
use Ntkp\Form\UserForm;
use Ntkp\Model\Activity;
use Ntkp\Model\Member;
use Ntkp\Model\MemberModel;
use Ntkp\Model\MemberTable;
use Ntkp\Model\MemberView;
use Ntkp\Model\User;
use Ntkp\Model\UserTable;
use Zend\Db\Adapter\Adapter;
use Zend\Authentication\Adapter\DbTable\CredentialTreatmentAdapter;
use Zend\Authentication\AuthenticationService;
use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\Feature\ConfigProviderInterface;

/**
 * Description of Module
 *
 * @author Sinisa Ristic
 */
class Module implements ConfigProviderInterface {
    
    public function getConfig() {
        return include __DIR__ . '/../config/module.config.php';
    }
    
    public function getServiceConfig()
    {
        return [
            'factories' => [
                /* Tables */
                UserTable::class => function($container) {
                    $tableGateway = $container->get(Model\UserTableGateway::class);
                    return new UserTable($tableGateway);
                },   
                MemberTable::class => function($container) {
                    $tableGateway = $container->get(Model\MemberTableGateway::class);
                    return new MemberTable($tableGateway);
                },
                MemberView::class => function($container) {
                    $dbAdapter = $container->get(\Zend\Db\Adapter\Adapter::class);
                    $memberView = new MemberView($dbAdapter);
                    return $memberView;
                },
                MemberModel::class => function($container) {
                    $memberModel = new MemberModel($container);
                    return $memberModel;
                },
                ActivityTable::class => function($container) {
                    $tableGateway = $container->get(Model\ActivityTableGateway::class);
                    return new ActivityTable($tableGateway);
                },
                /* Gateways */
                Model\UserTableGateway::class => function($sm) {
                    $dbAdapter = $sm->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayobjectPrototype(new User());
                    return new TableGateway('user', $dbAdapter, null, $resultSetPrototype);
                },                
                Model\MemberTableGateway::class => function($sm) {
                    $dbAdapter = $sm->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Member());
                    return new TableGateway('member', $dbAdapter, null, $resultSetPrototype);
                },
                Model\ActivityTableGateway::class => function($sm) {
                    $dbAdapter = $sm->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Activity());
                    return new TableGateway('activity', $dbAdapter, null, $resultSetPrototype);
                },
                /* Forms */
                UserForm::class => function($sm) {
                    return new UserForm('UserForm', [ 'service_manager' => $sm]);
                },
                MemberForm::class => function($sm) {
                    return new MemberForm('MemberForm', ['service_manager' => $sm]);
                },      
                LoginForm::class => function($sm) {
                    return new LoginForm('LoginForm');  
                },
                // Authentication Services
                'AuthenticationService' => function($sm) {
                    $dbAdapter = $sm->get(Adapter::class);
                    $dbTableAuthAdapter = new CredentialTreatmentAdapter($dbAdapter, 'user', 'email', 'password', 'md5(?)');                    
                    $authservice = new AuthenticationService();
                    $authservice->setAdapter($dbTableAuthAdapter);
                    return $authservice;
                },                
            ]
        ];
    }
    
    public function getControllerConfig() 
    {
        return [
            'factories' => [
                UserController::class => function($container) {
                    return new UserController($container);
                },
                MemberController::class => function($container) {
                    return new MemberController($container);
                }, 
                AjaxController::class => function($container) {
                    return new AjaxController($container);
                }, 
                LoginController::class => function($container) {
                    return new LoginController($container);
                },
                IndexController::class => function($container) {
                    return new IndexController($container);
                }
            ],
        ];        
    }

}
