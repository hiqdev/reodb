<?php
declare(strict_types=1);

namespace hiqdev\reodb\doctrine2;

use PDO;

trait BatchSqlTrait
{
    protected bool $attrEmulatePrepares;

    public function batchSql(string $sql): void
    {
        $this->enableBatchSql();
        $this->addSql($sql);
        $this->disableBatchSql();
    }

    public function enableBatchSql(): void
    {
        $pdoConnection = $this->connection->getNativeConnection();
        $this->attrEmulatePrepares = $pdoConnection->getAttribute(PDO::ATTR_EMULATE_PREPARES);
        $pdoConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    }

    public function disableBatchSql(): void
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
