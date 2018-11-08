<?php

namespace hiqdev\reodb\doctrine2\migrations;

use hiqdev\reodb\doctrine2\FileBasedMigration;

class Version20181108143000 extends FileBasedMigration
{
    /**
     * {@inheritdoc}
     */
    public function getFilesDir(): string
    {
        return \dirname(__DIR__, 2) . '/src';
    }

    protected $importFiles = [
        'create.sql',
        'zero_insert.sql',
        'alter.sql',
        'aggregate.sql',
        'functions.sql',
        'triggers.sql',
        'views.sql',
        'init.sql',
    ];
}
