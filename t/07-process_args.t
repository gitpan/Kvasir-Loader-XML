#!perl

package Test::Kvasir::Input2;

use strict;
use warnings;

use Test::More tests => 5;

use Kvasir::Loader::XML;

use base qw(Kvasir::Input);

sub process_xml_loader_args {
    my ($self, $element) = @_;
    
    is($self, "Test::Kvasir::Input2");
    isa_ok($element, "XML::LibXML::Element");
    my $text = $element->textContent();
    return ($text);
}

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <input name="input1" instanceOf="Test::Kvasir::Input2">IZ DIS VALID ARGUMENT?</input>
    </engine>
});

ok($engine->has_input("input1"));
my $input = $engine->_get_input("input1");
ok(defined $input);
is_deeply($input->_args, ['IZ DIS VALID ARGUMENT?']);


