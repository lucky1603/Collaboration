<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Form;

use Zend\Form\Form;
use Zend\Form\Element;

/**
 * Description of UserForm
 *
 * @author Sinisa Ristic
 */
class UserForm extends Form {
    public function __construct($name = null, $options=array()) {
        parent::__construct('user');
        $this->setAttribute('method', 'post');
        $this->setAttribute('enctype', 'multipart/form-data');
        $this->setAttribute('class', 'form-horizontal');
        $this->setAttribute('role', 'form');
        
        $sm = $options['service_manager'];
        $rm = $sm->get('RoleModel');
        $usm = $sm->get('UserStatusModel');
        
        $this->add([
            'name' => 'id', 
            'type' => 'hidden'
        ]);
        
        $this->add([
            'name' => 'name',
            'type' => 'text',
            'options' => [
                'label' => 'Ime'
            ],
        ]);
        
        $this->add([
            'name' => 'username',
            'type' => 'text', 
            'options' => [
                'label' => "Korisnicko ime"
            ],
        ]);
                
        $password = new Element\Password("password");
        $password->setLabel("Lozinka");
        $this->add($password);
        
        $email = new Element\Email('email');
        $email->setLabel('e-mail');
        $this->add($email);
        
        // User-role select element.         
        $rows = $rm->fetchAll();
        $options = [];
        foreach ($rows as $row)
        {
            $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'role_id',
            'options' => [
                'label' => 'Korisnicka rola?',
                'value_options' => $options,
            ],
        ]);
        
        // User-status select element.
        $rows = $usm->fetchAll();
        $options = [];
        foreach ($rows as $row)
        {
            $options[$row->id] = $row->value;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'user_status_id',
            'options' => [
                'label' => 'Status korisnika?',
                'value_options' => $options,
            ],
        ]);
        
        $this->add([
            'name' => 'description',
            'attributes' => [
                'type' => 'textarea',
                'COLS' => 40,
                'ROWS' => 4,
                'class' => 'form-control',
            ],
            'options' => [
                'label' => 'Opis',
                'label_attributes' => [
                    'class' => 'control-label col-sm-2'
                ]
            ]
        ]);
        
        $this->add([
            'name' => 'submit',
            'attributes' => [
                'type' => 'submit',
                'value' => 'Sacuvaj promene',
                'id' => 'submitbutton',
                'class' => 'form-control',
            ],
        ]);
        
    }
}
