# $Id: load.t,v 1.2 2004/09/08 09:10:23 comdog Exp $
BEGIN {
	@classes = qw(Test::ISBN);
	}

use Test::More tests => scalar @classes;

foreach my $class ( @classes )
	{
	print "bail out! $class did not compile\n" unless use_ok( $class );
	}
