<?php

namespace hiqdev\reodb\yii;

use PDO;
use yii\base\InvalidCallException;
use yii\db\Migration;

/**
 * Class FileBasedMigration
 *
 * @author Dmytro Naumenko <d.naumenko.a@gmail.com>
 */
abstract class FileBasedMigration extends Migration
{
    protected $importFiles = [];

    /**
     * @return string the dir with files
     */
    abstract public function getFilesDir();

    public function safeUp()
    {
        $dir = $this->getFilesDir();
        if (!file_exists($dir)) {
            throw new InvalidCallException('Wrong directory for file based migration: ' . $dir);
        }
        foreach ($this->importFiles as $filename) {
            $this->applyMigrationFile($dir . '/' . $filename);
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
