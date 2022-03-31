<?php

namespace hiqdev\reodb\doctrine2\migrations;

use hiqdev\reodb\doctrine2\FileBasedMigration;

class Version20181108143000 extends FileBasedMigration
{
    public function getDescription(): string
    {
        return "Import basic table structure, functions and references from files " . implode(', ', $this->importFiles);
    }

    /**
     * {@inheritdoc}
     */
    public function getFilesDir(): string
    {
        return \dirname(__DIR__, 2) . '/src';
    }

    protected array $importFiles = [
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
