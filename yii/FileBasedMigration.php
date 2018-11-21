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
    /**
     * @var string[]
     */
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
        $time = $this->beginCommand('Importing ' . $filename);
        $sql = file_get_contents($filename);
        $this->db->pdo->exec($sql);
        $this->endCommand($time);
    }

    public function down()
    {
        throw new InvalidCallException('Down is not supported for file based migration. Sorry!');
    }
}
