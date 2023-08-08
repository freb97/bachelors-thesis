<?php

namespace BestIt\ExamplePlugin\Tests\Unit;

use BestIt\ExamplePlugin\BestItExamplePlugin;
use PHPUnit\Framework\TestCase;

class BestItExamplePluginTest extends TestCase
{
    public function testThatClassExistsAndCanBeInstanced(): void
    {
        static::assertTrue(class_exists(BestItExamplePlugin::class));

        static::assertInstanceOf(
            BestItExamplePlugin::class,
            new BestItExamplePlugin(true, __DIR__),
        );
    }
}