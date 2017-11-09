<?php
/*
 * Module manager file.
 */
namespace Ntkp;

use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\Feature\ConfigProviderInterface;
use Ntkp\Model\UserTable;
use Ntkp\Model\User;
use Ntkp\Controller\UserController;
use Ntkp\Form\UserForm;
use Ntkp\Model\Member;
use Ntkp\Model\MemberTable;
use Ntkp\Controller\MemberController;
use Ntkp\Model\MemberView;
use Ntkp\Form\MemberForm;
use Ntkp\Model\MemberModel;
use Ntkp\Controller\AjaxController;


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
                /* Forms */
                UserForm::class => function($sm) {
                    return new UserForm('UserForm', [ 'service_manager' => $sm]);
                },
                MemberForm::class => function($sm) {
                    return new MemberForm('MemberFor', ['service_manager' => $sm]);
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
                }
            ],
        ];        
    }

}
