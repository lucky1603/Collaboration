<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Form;

use Zend\Form\Form;

/**
 * Description of UserForm
 *
 * @author Sinisa Ristic
 */
class UserForm extends Form {
    public function __construct($name = null) {
        parent::__construct('user');
        
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
        
        $this->add([
            'name' => 'password',
            'type' => 'hidden', 
            'options' => [
                'label' => "Lozinka"
            ],
        ]);
        
        
    }
}
