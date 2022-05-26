<?php

declare(strict_types=1);

namespace <namespace>;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class <className> extends AbstractMigration
{
    use \hiqdev\reodb\doctrine2\BatchSqlTrait;

    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        <up>
    }

    public function down(Schema $schema): void
    {
        <down>
    }<override>
}
