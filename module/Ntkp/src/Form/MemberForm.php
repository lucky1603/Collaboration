<?php
/**
 * Member form class. This is helper class which provides the form controls for the viewer.
 * @author Sinisa <sinisa.ristic@gmail.com>
 * @date 11.2.2017.
 * 
 */
namespace Ntkp\Form;

use Zend\Form\Form;
use Zend\Form\Element;

/**
 * MemberForm.php - User form class.
 * @author Sinisa Ristic
 * @date 02.11.2017.
 * 
 */
class MemberForm extends Form
{
    
    /**
     * Constructor.
     * @param unknown $name
     * @param array $options
     */
    public function __construct($name = null, $options = array())
    {
        parent::__construct('MemberForm');
        
        $this->setAttribute('method', 'post');
        $this->setAttribute('enctype', 'multipart/form-data');
        $this->setAttribute('class', 'form-horizontal');
        $this->setAttribute('role', 'form');
        
        $sm = $options['service_manager'];
        
        // Id. 
        $this->add([
            'name' => 'id',
            'type' => 'hidden'
        ]);
                        
        // Name of the subject/member.
        $this->add([
            'name' => 'name',
            'type' => 'text',
            'required' => 'required',
            'class' => 'form-control',
            'options' => [
                'label' => 'Ime', 
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ]
        ]);
        
        // Description of member.
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
        
        // Web addres of the subject/member.
        $this->add([
            'name' => 'url',
            'type' => 'text',
            'required' => 'required',
            'class' => 'form-control',
            'options' => [
                'label' => 'Web adresa prezentacije',
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ]
        ]);
        
        // E-mail address of the subject/member
        $email = new Element\Email('email');
        $email->setLabel('E-Mail');
        $email->setLabelAttributes([
            'class' => 'control-label col-xs-2',
        ]);
        $this->add($email);

        
        // Member role types.
        $memberRoleModel = $sm->get('MemberRoleModel');
        $rows = $memberRoleModel->fetchAll();
        $options = array();
        foreach($rows as $row)
        {
           $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'member_role_id',
            'options' => [
                'label' => 'Uloga',
                'value_options' => $options,
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ],
        ]);
        
        // Property types.
        $propertyTypeModel = $sm->get('PropertyTypeModel');
        $rows = $propertyTypeModel->fetchAll();
        $options = array();
        foreach($rows as $row)
        {
            $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'property_type_id',
            'options' => [
                'label' => 'Tip svojine',
                'value_options' => $options,
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ],
        ]);
        
        // Member types.
        $memberTypeModel = $sm->get('MemberTypeModel');
        $rows = $memberTypeModel->fetchAll();
        $options = array();
        foreach($rows as $row)
        {
            $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'member_type_id',
            'options' => [
                'label' => 'Vrsta članstva',
                'value_options' => $options,
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ],
        ]);
        
        // Request domains.
        $requestDomainModel = $sm->get('RequestDomainModel');
        $rows = $requestDomainModel->fetchAll();
        $options = array();
        foreach($rows as $row)
        {
            $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'request_domain_id',
            'options' => [
                'label' => 'Teritorijalno',
                'value_options' => $options,
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ],
        ]);
        
        // Member status.
        $memberStatusModel = $sm->get('MemberStatusModel');
        $rows = $memberStatusModel->fetchAll();
        $options = array();
        foreach($rows as $row)
        {
            $options[$row->id] = $row->name;
        }
        
        $this->add([
            'type' => Element\Select::class,
            'name' => 'member_status_id',
            'options' => [
                'label' => 'Status člana',
                'value_options' => $options,
                'label_attributes' => [
                    'class' => 'control-label col-xs-2',
                ]
            ],
        ]);
        
        $this->add([
            'name' => 'submit',
            'attributes' => [
                'type' => 'submit',
                'value' => 'Sačuvaj promene',
                'id' => 'submitbutton',
                'class' => 'form-control',
            ],
        ]);
                
    }
}

