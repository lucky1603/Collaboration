<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Model;

/**
 * Collaboration request mapping object.
 *
 * @author Sinisa
 */
class Request {
    public $id;
    public $name;
    public $description;
    public $request_type_id;
    public $init_member_id;
    public $status_id;
    public $request_domain_id;
    public $submission_date;
    
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->name = isset($data['name']) ? $data['name'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;
        $this->request_type_id = isset($data['request_type_id']) ? $data['request_type_id'] : null;
        $this->init_member_id = isset($data['init_member_id']) ? $data['init_member_id'] : null;
        $this->status_id = isset($data['status_id']) ? $data['status_id'] : null;
        $this->request_domain_id = isset($data['request_domain_id']) ? $data['request_domain_id'] : null;
        $this->submission_date = isset($data['submission_date']) ? $data['submission_date'] : null;
    }
    
    public function getArrayCopy()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'request_type_id' => $this->request_type_id,
            'init_member_id' => $this->init_member_id,
            'status_id' => $this->status_id,
            'request_domain_id' => $this->request_domain_id,
            'submission_date' => $this->submission_date,
        ];
    }
    
}
