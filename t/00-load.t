#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Plagger::Rule::Match' );
}

diag( "Testing Plagger::Rule::Match $Plagger::Rule::Match::VERSION, Perl $], $^X" );
