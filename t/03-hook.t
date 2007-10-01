#!perl

use strict;
use warnings;

use Test::More tests => 4;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <prehook name="hook1" instanceOf="Test::Kvasir::Hook"/>
        <prehook name="hook2" instanceOf="Test::Kvasir::Hook">
            <arg1>1</arg1>
            <arg2/>
        </prehook>

        <posthook name="hook3" instanceOf="Test::Kvasir::Hook"/>
        <posthook name="hook4" instanceOf="Test::Kvasir::Hook">
            <arg1>1</arg1>
            <arg2/>
        </posthook>
    </engine>
});

is_deeply(sort $engine->_pre_hooks, [qw(hook1 hook2)]);
is_deeply(sort $engine->_post_hooks, [qw(hook3 hook4)]);

my $hook = $engine->_get_hook("hook1");
is($hook->_pkg, "Test::Kvasir::Hook");

$hook = $engine->_get_hook("hook2");
is_deeply($hook->_args->[0], { arg1 => 1, arg2 => undef});
