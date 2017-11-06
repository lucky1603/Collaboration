<?php
/**
 * Name: OptionModel.php
 * Description: Class that wrapps the data for all option tables table. 
 * Author: Sinisa <sinisa.ristic@gmail.com>
 * Created: 02.11.2017.
 */
namespace Ntkp\Model;

use Zend\Db\TableGateway\TableGateway;

/**
 * MemberRoleModel - class
 * @author Sinisa Ristic
 *
 */
class SimpleOptionModel
{
    private $tableGateway;
    
    /**
     * Constructor
     * @param TableGateway $tableGateway
     */
    public function __construct(TableGateway $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }
    
    /**
     * Fetch all rows.
     * @return \Zend\Db\ResultSet\ResultSet
     */
    public function fetchAll()
    {
        return $this->tableGateway->select();
    }
    
    
}

