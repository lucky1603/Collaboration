<?php
namespace Ntkp\Form;

use Zend\Form\Form;
use Zend\Form\Fieldset;
use Zend\Form\Element\Select;
use Zend\Form\Element\Submit;

class MemberActivityForm extends Form
{    
    public function __construct($name=null, $options = array())
    {
        parent::__construct('MemberActivityForm');
        
        $this->setAttribute('method', 'post');
        $this->setAttribute('enctype', 'multipart/form-data');
        $this->setAttribute('class', 'form-horizontal');
        $this->setAttribute('role', 'form');
        
        $this->add([
            'name' => 'member_id', 
            'type' => 'hidden'
        ]);
        
        $activities = new Select('activity_id');
        $activities->setLabel("Aktivnosti");
        $activities->setAttribute('class', 'form-control');
        $activities->setLabelAttributes(['class' => 'control-label']);
        $this->add($activities);
        
        $submit = new Submit('submit');
        $submit->setValue('Dodaj aktivnost');
    }
}

