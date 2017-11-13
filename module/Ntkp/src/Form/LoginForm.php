<?php
namespace Ntkp\Form;

use Zend\Form\Form;
use Zend\Form\Element\Password;
use Zend\Form\Element\Submit;
use Zend\Form\Element\Email;

class LoginForm extends Form
{
    public function __construct($name = null, $options = array())
    {
        parent::__construct('LoginForm');
        
        $this->setAttribute('method', 'post');
        $this->setAttribute('enctype', 'multipart/form-data');
        $this->setAttribute('class', 'form-horizontal');
        $this->setAttribute('role', 'form');
        
        $email = new Email('email');
        $email->setAttribute('class', 'form-control');
        $email->setLabel('E-Mail');

        $this->add($email);
       
        $password = new Password('password');
        $password->setLabel('Lozinka');
        $password->setAttribute('class', 'form-control');
        $this->add($password);
       
        $submit = new Submit('submit');
        $submit->setAttribute('class', 'btn btn-primary');
        $submit->setAttribute('value', 'Login');
        $this->add($submit);
    }
    
}

