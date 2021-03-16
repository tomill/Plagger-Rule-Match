use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Plagger::Rule::Match',
    AUTHOR              => 'Naoki Tomita <tomita@cpan.org>',
    VERSION_FROM        => 'lib/Plagger/Rule/Match.pm',
    ABSTRACT_FROM       => 'lib/Plagger/Rule/Match.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Plagger-Rule-Match-*' },
);
