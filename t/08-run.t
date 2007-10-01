#!perl

use strict;
use warnings;

use Test::More tests => 4;
use Test::Exception;

use Kvasir::Loader::XML;

my $engine = Kvasir::Loader::XML->load_string(q{
    <engine>
        <action name="action1" instanceOf="Kvasir::Action"/>
        <action name="action2" instanceOf="Kvasir::Action"/>
        
        <rule name="rule1" instanceOf="Kvasir::Rule"/>
        <rule name="rule2" instanceOf="Kvasir::Rule"/>
        
        <ruleset name="all_rules" rulesMatchingName=".*"/>
        
        <run action="action1">
            <rule>rule1</rule>
        </run>
        
        <run action="action2">
            <ruleset>all_rules</ruleset>
        </run>
    </engine>
});

is_deeply($engine->_get_rule_actions("rule1"), [qw(action1 action2)]);
is_deeply($engine->_get_rule_actions("rule2"), [qw(action2)]);

throws_ok {
    Kvasir::Loader::XML->load_string("<engine><run/></engine>");
} qr/Missing attribute 'action' for element 'run'/;

throws_ok {
    Kvasir::Loader::XML->load_string("<engine><run action=\"foo\"/></engine>");
} qr/No action named 'foo' exists/;