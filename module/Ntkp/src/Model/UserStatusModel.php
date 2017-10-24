<?php
/**
 * UserStatusModel, class that handles the ui for user status.
 * @author Sinisa
 */
namespace Ntkp\Model;

use Zend\Db\TableGateway\TableGateway;

/**
 * UserStatusModel class.
 * @author Sinisa Ristic
 *
 */
class UserStatusModel
{
    private $tableGateway;
    
    /**
     * Constructor.
     * @param TableGateway $tableGateway
     */
    public function __construct(TableGateway $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }
    
    public function fetchAll()
    {
        return $this->tableGateway->select();
    }
    
    public function getUserStatusValue($id)
    {
        $rowset = $this->tableGateway->select(['id' => $id]);
        $row = $rowset->current();
        return $row->value;
    }
}

