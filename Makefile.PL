#!perl

use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Kvasir::Loader::XML',
    VERSION_FROM        => 'lib/Kvasir/Loader/XML.pm',
    LICENSE             => 'MIT',
    PREREQ_PM           => {
        Kvasir              => 0.07,
        Object::Tiny        => 0,
        Scalar::Util        => 0,
        Test::Exception     => 0,
        Test::More          => 0,
        XML::LibXML         => 0,
    },
    ABSTRACT_FROM       => 'lib/Kvasir/Loader/XML.pm', 
    AUTHOR              => 'Claes Jakobsson <claesjac@cpan.org>',
);