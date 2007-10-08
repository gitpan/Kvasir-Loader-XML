#!perl

use strict;
use warnings;

use Test::More tests => 3;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <output name="output1" instanceOf="Kvasir::Output"/>
        <output name="output2" instanceOf="Kvasir::Output">
            <arg1>1</arg1>
            <arg2/>
        </output>
    </engine>
});

is_deeply([sort $engine->outputs], [qw(output1 output2)]);

my $output = $engine->_get_output("output1");
is($output->_pkg, "Kvasir::Output");

$output = $engine->_get_output("output2");
is_deeply($output->_args, [ arg1 => 1, arg2 => undef ]);
