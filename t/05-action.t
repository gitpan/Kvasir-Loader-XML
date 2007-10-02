#!perl

use strict;
use warnings;

use Test::More tests => 3;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <action name="action1" instanceOf="Kvasir::Action"/>
        <action name="action2" instanceOf="Kvasir::Action">
            <arg1>1</arg1>
            <arg2/>
        </action>
    </engine>
});

is_deeply([sort $engine->actions], [qw(action1 action2)]);

my $action = $engine->_get_action("action1");
is($action->_pkg, "Kvasir::Action");

$action = $engine->_get_action("action2");
is_deeply($action->_args->[0], { arg1 => 1, arg2 => undef});
