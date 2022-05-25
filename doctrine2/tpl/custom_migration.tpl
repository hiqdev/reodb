<?php

declare(strict_types=1);

namespace <namespace>;

use Doctrine\DBAL\Schema\Schema;
use hiqdev\reodb\doctrine2\BaseMigration;

final class <className> extends BaseMigration
{
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
