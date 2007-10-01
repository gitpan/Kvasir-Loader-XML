#!perl

use strict;
use warnings;

use Test::More tests => 3;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <output name="output1" instanceOf="Test::Kvasir::Output"/>
        <output name="output2" instanceOf="Test::Kvasir::Output">
            <arg1>1</arg1>
            <arg2/>
        </output>
    </engine>
});

is_deeply([sort $engine->outputs], [qw(output1 output2)]);

my $output = $engine->_get_output("output1");
is($output->_pkg, "Test::Kvasir::Output");

$output = $engine->_get_output("output2");
is_deeply($output->_args->[0], { arg1 => 1, arg2 => undef});
