<?php

namespace hiqdev\reodb\yii;

use PDO;
use yii\base\InvalidCallException;
use yii\db\Migration;

class FileBasedMigration extends Migration
{
    protected $dir;

    protected $importFiles = [];

    public function safeUp()
    {
        if (!dir_exists($this->dir)) {
            throw new InvalidCallException('Wrong directory for file based migration: ' . $this->dir);
        }
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
        throw new InvalidCallException('Down is not supported for file based migration. Sorry!');
    }
}
