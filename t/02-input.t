#!perl

use strict;
use warnings;

use Test::More tests => 3;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <input name="input1" instanceOf="Kvasir::Input"/>
        <input name="input2" instanceOf="Kvasir::Input">
            <arg1>1</arg1>
            <arg2/>
        </input>
    </engine>
});

is_deeply([sort $engine->inputs], [qw(input1 input2)]);

my $input = $engine->_get_input("input1");
is($input->_pkg, "Kvasir::Input");

$input = $engine->_get_input("input2");
is_deeply($input->_args->[0], { arg1 => 1, arg2 => undef});
