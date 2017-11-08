<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp;

use Ntkp\Controller\UserController;
use Ntkp\Model\Role;
use Ntkp\Model\RoleModel;
use Ntkp\Model\UserStatus;
use Ntkp\Model\UserStatusModel;
use Ntkp\Model\SimpleOption;
use Ntkp\Model\SimpleOptionModel;
use Zend\Router\Http\Segment;
use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Ntkp\Controller\MemberController;


return [
    'controllers' => [
        'factories' => [
            /* add some factories here */
        ]
    ],
    'router' => [
        'routes' => [
            'user' => [
                'type' => Segment::class,
                'options' => [
                    'route' => '/user[/:action[/:id]]',
                    'constraints' => [
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id' => '[0-9]*',
                    ],
                    'defaults' => [
                        'controller' => UserController::class,
                        'action' => 'index',
                    ]
                ]
            ], 
            'member' => [
                'type' => Segment::class,
                'options' => [
                    'route' => '/member[/:action[/:id]]',
                    'constraints' => [
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        
                    ],
                    'defaults' => [
                        'controller' => MemberController::class,
                        'action' => 'index',
                    ]
                ],
            ],
        ]
    ],
    'service_manager' => [
        'factories' => [
            'RoleModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new Role());
                $tableGateway = new TableGateway('role', $dbAdapter, null, $resultSetPrototype);
                return new RoleModel($tableGateway);
            },
            'UserStatusModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new UserStatus());
                $tableGateway = new TableGateway('user_status', $dbAdapter, null, $resultSetPrototype);
                return new UserStatusModel($tableGateway);
            }, 
            'MemberRoleModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new SimpleOption());
                $tableGateway = new TableGateway('member_role', $dbAdapter, null, $resultSetPrototype);
                return new SimpleOptionModel($tableGateway);
            }, 
            'PropertyTypeModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new SimpleOption());
                $tableGateway = new TableGateway('property_type', $dbAdapter, null, $resultSetPrototype);
                return new SimpleOptionModel($tableGateway);
            }, 
            'MemberTypeModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new SimpleOption());
                $tableGateway = new TableGateway('member_type', $dbAdapter, null, $resultSetPrototype);
                return new SimpleOptionModel($tableGateway);
            },
            'RequestDomainModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new SimpleOption());
                $tableGateway = new TableGateway('request_domain', $dbAdapter, null, $resultSetPrototype);
                return new SimpleOptionModel($tableGateway);
            },
            'MemberStatusModel' => function($sm) {
                $dbAdapter = $sm->get(AdapterInterface::class);
                $resultSetPrototype = new ResultSet();
                $resultSetPrototype->setArrayObjectPrototype(new SimpleOption());
                $tableGateway = new TableGateway('member_status', $dbAdapter, null, $resultSetPrototype);
                return new SimpleOptionModel($tableGateway);
            },
        ]
    ],
    'view_manager' => [
        'template_path_stack' => [
            'ntkp' => __DIR__ . '/../view',
        ]
    ]
];