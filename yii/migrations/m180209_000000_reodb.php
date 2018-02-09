<?php

namespace osce\tramplin\migrations;

use PDO;
use yii\base\InvalidCallException;
use yii\db\Migration;

class m180209_000000_reodb extends Migration
{
    protected $dir = dirname(dirname(__DIR__)) . '/src';

    protected $importFiles = [
        "create.sql",
        "zero_insert.sql",
        "alter.sql",
        "aggregate.sql",
        "functions.sql",
        "triggers.sql",
        "views.sql",
        "init.sql",
    ];

    public function safeUp()
    {
        foreach ($this->importFiles as $filename) {
            $this->applyMigrationFile($this->dir . '/' . $filename);
        }
    }

    protected function applyMigrationFile($filename)
    {
        $attr_emulate_prepares = $this->db->pdo->getAttribute(PDO::ATTR_EMULATE_PREPARES);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
        $time = $this->beginCommand('Importing ' . $filename);
        $sql = file_get_contents($filename);
        $command = $this->db->createCommand($sql);
        $command->execute();
        $this->endCommand($time);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, $attr_emulate_prepares);
    }

    public function down()
    {
        throw new InvalidCallException('Down is not supported for Reodb migration. You can drop database, if you dare :)');
    }
}
