<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

use Zend\InputFilter\InputFilterAwareInterface;
use Zend\InputFilter\InputFilter;
use Zend\InputFilter\Input;
use Zend\Filter\ToInt;
use Zend\Filter\StripTags;
use Zend\Filter\StringTrim;
use Zend\Validator;
use Zend\Validator\StringLength;

/**
 * Description of User
 *
 * @author Sinisa Ristic
 */
class User implements InputFilterAwareInterface {
    public $id;
    public $name;
    public $email;
    public $role_id;
    public $username;
    public $password;
    public $description;
    public $user_status_id;
    
    private $inputFilter;
    
    public function setPassword($clearPassword)
    {
        $this->password = md5($clearPassword);
    }
    
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->name = isset($data['name']) ? $data['name'] : null;
        $this->email = isset($data['email']) ? $data['email'] : null;
        $this->role_id = isset($data['role_id']) ? $data['role_id'] : null;
        $this->username = isset($data['username']) ? $data['username'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;
        $this->user_status_id = isset($data['user_status_id']) ? $data['user_status_id'] : null;
                
        if(isset($data['password']))
        {
            $this->setPassword($data['password']);
        }     
                  
    }
    
    public function getArrayCopy()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'role_id' => $this->role_id,
            'username' => $this->username,
            'password' => $this->password,
            'description' => $this->description,
            'user_status_id' => $this->user_status_id,
        ];
    }
    /**
     * {@inheritDoc}
     * @see \Zend\InputFilter\InputFilterAwareInterface::setInputFilter()
     */
    public function setInputFilter(\Zend\InputFilter\InputFilterInterface $inputFilter)
    {
        throw new \DomainException(sprintf('%s does not allow injection of alternate input filter', __CLASS__));        
    }

    /**
     * {@inheritDoc}
     * @see \Zend\InputFilter\InputFilterAwareInterface::getInputFilter()
     */
    public function getInputFilter()
    {
        // TODO Auto-generated method stub
        if($this->inputFilter) {
            return $this->inputFilter;
        }
        
        $inputFilter = new InputFilter();
        
        $inputFilter->add([
            'name' => 'id',
            'required' => true,
            'filters' => [
                ['name' => ToInt::class]
            ],
        ]);
        
        $inputFilter->add([
            'name' => 'name', 
            'required' => true,
            'filters' => [
                ['name' => StripTags::class],
                ['name' => StringTrim::class],
            ],
            'validators' => [
                [
                    'name' => StringLength::class,
                    'options' => [
                        'encoding' => 'UTF-8',
                        'min' => 1,
                        'max' => 100,
                    ],
                ],
            ],
        ]);
        
        $inputFilter->add([
            'name' => 'username',
            'required' => true,
            'filters' => [
                ['name' => StripTags::class],
                ['name' => StringTrim::class],
            ],
            'validators' => [
                [
                    'name' => StringLength::class,
                    'options' => [
                        'encoding' => 'UTF-8',
                        'min' => 1,
                        'max' => 100,
                    ],
                ],
            ],
        ]);
        
        $email = new Input('email');
        $email->getValidatorChain()->attach(new Validator\EmailAddress());
        $inputFilter->add($email);
        
        $password = new Input('password');
        $password->getValidatorChain()->attach(new Validator\StringLength(8));
        $inputFilter->add($password);
        
        $this->inputFilter = $inputFilter;
        
        return $this->inputFilter;
        
    }

}
