<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

/**
 * Description of User
 *
 * @author Sinisa Ristic
 */
class User {
    public $id;
    public $name;
    public $email;
    public $role_id;
    public $username;
    public $password;
    public $description;
    
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->name = isset($data['name']) ? $data['name'] : null;
        $this->email = isset($data['email']) ? $data['email'] : null;
        $this->role_id = isset($data['role_id']) ? $data['role_id'] : null;
        $this->username = isset($data['username']) ? $data['username'] : null;
        $this->password = isset($data['password']) ? $data['password'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;        
    }
}
