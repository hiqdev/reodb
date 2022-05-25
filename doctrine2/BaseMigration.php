<?php
declare(strict_types=1);

namespace hiqdev\reodb\doctrine2;

use PDO;
use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

abstract class BaseMigration extends AbstractMigration
{
    /**
     * @var bool
     */
    protected bool $attrEmulatePrepares;

    /**
     * @inheritDoc
     */
    abstract public function up(Schema $schema): void;

    public function enableBatchSql():void
    {
        $pdoConnection = $this->connection->getNativeConnection();
        $this->attrEmulatePrepares = $pdoConnection->getAttribute(PDO::ATTR_EMULATE_PREPARES);
        $pdoConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    }

    public function disableBatchSql():void
    {
        $pdoConnection = $this->connection->getNativeConnection();
        $pdoConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
    }

    public function resetEmulatePreparesToStart(): bool
    {
        $result = false;
        if (!empty($this->attrEmulatePrepares)) {
            $pdoConnection = $this->connection->getNativeConnection();
            $pdoConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, $this->attrEmulatePrepares);
            $result = true;
        }
        return $result;
    }
}
