<?php

namespace hiqdev\reodb\yii\migrations;

use PDO;
use yii\db\Migration;

class m180201_000000_extensions extends Migration
{
    public $extensions = [
        'pgcrypto',
        'hstore',
    ];

    public function safeUp()
    {
        foreach ($this->extensions as $name) {
            $this->createExtension($name);
        }
    }

    public function down()
    {
        foreach ($this->extensions as $name) {
            $this->dropExtension($name);
        }
    }

    public function createExtension($name)
    {
        $attr_emulate_prepares = $this->db->pdo->getAttribute(PDO::ATTR_EMULATE_PREPARES);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
        $time = $this->beginCommand('Creating extension ' . $name);
        $sql = 'CREATE EXTENSION IF NOT EXISTS ' . $name;
        $command = $this->db->createCommand($sql);
        $command->execute();
        $this->endCommand($time);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, $attr_emulate_prepares);
    }

    protected function dropExtension($name)
    {
        $attr_emulate_prepares = $this->db->pdo->getAttribute(PDO::ATTR_EMULATE_PREPARES);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
        $time = $this->beginCommand('Dropping extension ' . $name);
        $sql = 'DROP EXTENSION IF EXISTS ' . $name;
        $command = $this->db->createCommand($sql);
        $command->execute();
        $this->endCommand($time);
        $this->db->pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, $attr_emulate_prepares);
    }
}
