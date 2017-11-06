<?php
namespace Ntkp\Model;

/**
 * Member class. Defines the member of collaboration.
 * @author Sinisa Ristic
 * @date 02.11.2017.
 *
 */
class Member
{
    public $id;
    public $name;
    public $description;
    public $member_type_id;
    public $member_role_id;
    public $property_type_id;
    public $request_domain_id;
    public $activities;
    public $email;
    public $url;
    public $member_status_id;
    
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->name = isset($data['name']) ? $data['name'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;
        $this->member_type_id = isset($data['member_type_id']) ? $data['member_type_id'] : null;
        $this->member_role_id = isset($data['member_role_id']) ? $data['member_role_id'] : null;
        $this->property_type_id = isset($data['property_type_id']) ? $data['property_type_id'] : null;
        $this->request_domain_id = isset($data['request_domain_id']) ? $data['request_domain_id'] : null;
        $this->activities = isset($data['activities']) ? $data['activities'] : null;
        $this->email = isset($data['email']) ? $data['email'] : null;
        $this->url = isset($data['url']) ? $data['url'] : null;
        $this->member_status_id = isset($data['member_status_id']) ? $data['member_status_id'] : null;
    }
    
    public function getArrayCopy() 
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'member_type_id' => $this->member_type_id,
            'member_role_id' => $this->member_role_id,
            'property_type_id' => $this->property_type_id,
            'request_domain_id' => $this->request_domain_id,
            'activities' => $this->activities,
            'email' => $this->email,
            'url' => $this->url,
            'member_status_id' => $this->member_status_id,
        ];
    }
}

