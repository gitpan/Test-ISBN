# $Id: load.t 1470 2004-09-08 09:10:23Z comdog $
BEGIN {
	@classes = qw(Test::ISBN);
	}

use Test::More tests => scalar @classes;

foreach my $class ( @classes )
	{
	print "bail out! $class did not compile\n" unless use_ok( $class );
	}
