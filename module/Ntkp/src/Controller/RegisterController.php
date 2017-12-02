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
        $request = $this->getRequest();
        if(! $request->isPost())
        {
            return ['form' => $form, 'model' => $memberModel];
        }
        
        $member = $memberModel->member;
        $form->bind($member);
        $form->setData($request->getPost());
        if(! $form->isValid())
        {
            $session->memberModelData = $memberModel->getArrayCopy();
            return ['form' => $form, 'model' => $memberModel];
        }

        
        $memberModel->save();
        
        $viewModel = new ViewModel();
        $viewModel->setTemplate('/ntkp/register/confirm');
        return $viewModel;
    }
    
}
