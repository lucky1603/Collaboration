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
                UserTable::class => function($container) {
                    $tableGateway = $container->get(Model\AlbumTableGateway::class);
                    return new UserTable($tableGateway);
                },
                Model\AlbumTableGateway::class => function($sm) {
                    $dbAdapter = $sm->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayobjectPrototype(new User());
                    return new TableGateway('user', $dbAdapter, null, $resultSetPrototype);
                },
                UserForm::class => function($sm) {
                    return new UserForm('user', [ 'service_manager' => $sm]);
                }
            ]
        ];
    }
    
    public function getControllerConfig() 
    {
        return [
            'factories' => [
                UserController::class => function($container) {
                    return new UserController($container);
                }
            ]
        ];        
    }

}
