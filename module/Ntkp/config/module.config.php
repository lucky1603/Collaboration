<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp;

use Zend\ServiceManager\Factory\InvokableFactory;
use Zend\Router\Http\Segment;
use Ntkp\Controller\UserController;

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
    'view_manager' => [
        'template_path_stack' => [
            'ntkp' => __DIR__ . '/../view',
        ]
    ]
];