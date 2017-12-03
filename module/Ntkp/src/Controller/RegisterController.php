<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Ntkp\Controller;

use Ntkp\Model\Member;
use Ntkp\Model\ActivityTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\ServiceManager\ServiceManager;

use Zend\Mail\Transport\Smtp as SmtpTransport;
use Zend\Mail\Transport\SmtpOptions;


/**
 * Description of RegisterController
 *
 * @author Sinisa
 */
class RegisterController extends AbstractActionController {
    private $serviceManager; 
    
    /**
     * Constructor.
     * @param ServiceManager $serviceManager
     */
    public function __construct(ServiceManager $serviceManager) {
        $this->serviceManager = $serviceManager;
    }
    
    /**
     * Index action.
     * @return type
     */
    public function indexAction() {
        $form = $this->serviceManager->get(\Ntkp\Form\MemberForm::class);
        
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form];
        }
        
        $member = new Member();
        $form->bind($member);
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            \Zend\Debug\Debug::dump($form->getMessages());
            return ['form' => $form];
        }
        
        $memberTable = $this->serviceManager->get(\Ntkp\Model\MemberTable::class);
        $memberTable->saveMember($member);
        
        $viewModel = new ViewModel();
        $viewModel->setTemplate('/ntkp/register/confirm');
        return $viewModel;
    }
    
    public function index1Action()
    {
        $memberModel = $this->serviceManager->get(\Ntkp\Model\MemberModel::class);
        $session = new \Zend\Session\Container('models');
        if(isset($session->memberModelData))
        {
            $memberModel->exchangeArray($session->memberModelData);
        }
        
        $form = $this->serviceManager->get(\Ntkp\Form\MemberForm::class);
        $member = $memberModel->member;
        $form->bind($member);
        
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form, 'model' => $memberModel];
        }
                
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            $session->memberModelData = $memberModel->getArrayCopy();
            return ['form' => $form, 'model' => $memberModel];
        }

        
        $memberModel->save();      

        $this->sendMail($memberModel->member->email, $memberModel->member->name);
        
        $viewModel = new ViewModel();
        $viewModel->setTemplate('/ntkp/register/confirm');
        return $viewModel;
    }
    
    private function sendMail($email, $name)
    {
        $message = new \Zend\Mail\Message();
        $message->setBody('Upravo ste se registrovali na NTKP portalu. Vaša molba će biti razmotrena u najskorije vreme i dobićete potvrdni email.\n Hvala i srdačan pozdrav,\n NTKP tim.');
        $message->setFrom('sinisa.ristic@prosmart.rs', 'Sinisa Ristic');
        $message->addTo($email, $name);
        $message->setSubject("NTKP - Potvrda registracije");
        
        // Setup SMTP transport using LOGIN authentication
        $transport = new SmtpTransport();
        $options   = new SmtpOptions([
            'name'              => 'example.com',
            'host'              => 'smtp.gmail.com',
            'port'              => 587,
            // Notice port change for TLS is 587
            'connection_class'  => 'plain',
            'connection_config' => [
                'username' => 'sinisa.ristic@gmail.com',
                'password' => 'SinisaBarbara1602',
                'ssl'      => 'tls',
            ],
        ]);
        $transport->setOptions($options);
        
        //$transport = new \Zend\Mail\Transport\Sendmail();
        $transport->send($message);        
    }
    
}
