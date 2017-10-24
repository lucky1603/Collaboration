<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp;

use Ntkp\Controller\UserController;
use Ntkp\Model\Role;
use Zend\ServiceManager\Factory\InvokableFactory;
use Zend\Router\Http\Segment;
use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;


return [
    'controllers' => [
        'factories' => [
            /* add some factories here */
        ]
    ],
    'router' => [
        'routes' => [
            'ntkp' => [
                'type' => Segment::class,
                'options' => [
                    'route' => '/user[/:action[/:id]]',
                    'constraints' => [
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id' => '[0-9]',
                    ],
                    'defaults' => [
                        'controller' => UserController::class,
                        'action' => 'index',
                    ]
                ]
            ]
        ]
    ],
    'service_manager' => [
        'factories' => [
            'RoleModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new Role());
                $tableGateway = new TableGateway('role', $dbAdapter, null, $resultSetPrototype);
                return new Model\RoleModel($tableGateway);
            }
        ]
    ],
    'view_manager' => [
        'template_path_stack' => [
            'ntkp' => __DIR__ . '/../view',
        ]
    ]
];