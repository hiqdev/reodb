<?php

namespace hiqdev\reodb\doctrine2\migrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

class Version20181108142116 extends AbstractMigration
{
    public array $extensions = [
        'pgcrypto',
        'hstore',
    ];

    public function up(Schema $schema): void
    {
        foreach ($this->extensions as $name) {
            $this->addSql('CREATE EXTENSION IF NOT EXISTS ' . $name);
        }
    }

    public function down(Schema $schema): void
    {
        foreach ($this->extensions as $name) {
            $this->addSql('DROP EXTENSION IF EXISTS ' . $name);
        }
    }
}
