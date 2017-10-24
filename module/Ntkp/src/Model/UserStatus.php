<?php
namespace Ntkp\Model;

class UserStatus
{
    public $id;
    public $value;
    public $description;
    
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->value = isset($data['value']) ? $data['value'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;
    }
}

