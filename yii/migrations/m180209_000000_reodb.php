<?php

namespace hiqdev\reodb\yii\migrations;

use hiqdev\reodb\yii\FileBasedMigration;

class m180209_000000_reodb extends FileBasedMigration
{
    /**
     * {@inheritdoc}
     */
    public function getFilesDir()
    {
        return dirname(dirname(__DIR__)) . '/src';
    }

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
}
