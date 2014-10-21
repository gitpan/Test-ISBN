# $Id: ISBN.pm,v 1.4 2002/09/09 16:34:12 comdog Exp $
package Test::ISBN;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

use Business::ISBN;
use Exporter;
use Test::Builder;

my $Test = Test::Builder->new();

$VERSION = '0.5_04';
@EXPORT  = qw(isbn_ok isbn_country_ok isbn_publisher_ok);

=head1 NAME

Test::ISBN - Check International Standard Book Numbers

=head1 SYNOPSIS

	use Test::More tests => 1;
	use Test::ISBN;
	
	isbn_ok( $isbn );
	
=head1 DESCRIPTION

=head1 FUNCTIONS

=over 4

=item isbn_ok( STRING )

Ok is the STRING is a valid ISBN, in any format that
Business::ISBN accepts.  This function only checks
the checksum.  The publisher and country codes might
be invalid even though the checksum is valid.

=cut

sub isbn_ok
	{	
	my $isbn = shift;
	my $ok   = Business::ISBN::is_valid_checksum( $isbn ) 
		eq Business::ISBN::GOOD_ISBN;
	
	$Test->ok( $ok );

	$Test->diag( "The string [$isbn] is not a valid ISBN" ) unless $ok;
	}
	
=item isbn_country_ok( STRING, COUNTRY )

Ok is the STRING is a valid ISBN and its country
code is the same as COUNTRY.

=cut

sub isbn_country_ok
	{
	my $isbn    = shift;
	my $country = shift;
	my $object  = Business::ISBN->new($isbn);
	
	unless( $object->is_valid )
		{
		$Test->ok(0);
		$Test->diag("ISBN [$isbn] is not valid"),
		}
	elsif( $object->country_code eq $country )
		{
		$Test->ok(1);
		}
	else
		{
		$Test->ok(0);
		$Test->diag("ISBN [$isbn] country code is wrong\n",
			"\tExpected [$country]\n",
			"\tGot [" . $object->country_code . "]\n" );
		}
		
	}

=item isbn_publisher_ok( STRING, PUBLISHER )

Ok is the STRING is a valid ISBN and its publisher
code is the same as PUBLISHER.

=cut
	
sub isbn_publisher_ok
	{
	my $isbn      = shift;
	my $publisher = shift;
	my $object    = Business::ISBN->new($isbn);
	
	unless( $object->is_valid )
		{
		$Test->ok(0);
		$Test->diag("ISBN [$isbn] is not valid"),
		}
	elsif( $object->publisher_code eq $publisher )
		{
		$Test->ok(1);
		}
	else
		{
		$Test->ok(0);
		$Test->diag("ISBN [$isbn] publisher code is wrong\n",
			"\tExpected [$publisher]\n",
			"\tGot [" . $object->publisher_code . "]\n" );
		}
	}
	
=back

=head1 AUTHOR

brian d foy, E<lt>brian d foyE<gt>

=head1 COPYRIGHT

Copyright 2002 brian d foy, All rights reserved.

You can use this module under the same terms as
Perl itself.

=cut

1;
