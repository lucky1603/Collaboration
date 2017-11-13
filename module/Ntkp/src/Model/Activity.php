<?php
/**
 * Activity.php
 * Mapping class of the 'activity' table.
 * @author Sinisa 
 * @created 13.11.2017.
 * @modified 13.11.2017.
 */
namespace Ntkp\Model;

class Activity
{
    public $id;
    public $section;
    public $class;
    public $description;
        
    public function exchangeArray($data)
    {
        $this->id = isset($data['id']) ? $data['id'] : null;
        $this->section = isset($data['section']) ? $data['section'] : null;
        $this->class = isset($data['class']) ? $data['class'] : null;
        $this->description = isset($data['description']) ? $data['description'] : null;        
    }
    
    public function getArrayCopy()
    {
        return [
            'id' => $this->id,
            'section' => $this->section,
            'class' => $this->class,
            'description' => $this->description,
        ];
    }
}

