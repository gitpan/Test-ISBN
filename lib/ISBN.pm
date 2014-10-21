# $Id: ISBN.pm 2347 2007-10-28 02:16:07Z comdog $
package Test::ISBN;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

use Business::ISBN 2.0;
use Exporter;
use Test::Builder;

my $Test = Test::Builder->new();

$VERSION = 2.01;
@EXPORT  = qw(isbn_ok isbn_group_ok isbn_country_ok isbn_publisher_ok);

=head1 NAME

Test::ISBN - Check International Standard Book Numbers

=head1 SYNOPSIS

	use Test::More tests => 1;
	use Test::ISBN;

	isbn_ok( $isbn );

=head1 DESCRIPTION

This is the 2.x version of Test::ISBN and works with Business::ISBN 2.x.

=head2 Functions

=over 4

=item isbn_ok( STRING )

Ok is the STRING is a valid ISBN, in any format that Business::ISBN
accepts.  This function only checks the checksum.  The publisher and
country codes might be invalid even though the checksum is valid.

=cut

sub isbn_ok
	{
	my $isbn = shift;
	
	my $object = Business::ISBN->new( $isbn );
	
	my $ok   = ref $object && 
		( $object->is_valid_checksum( $isbn ) eq Business::ISBN::GOOD_ISBN );

	$Test->ok( $ok );

	$Test->diag( "The string [$isbn] is not a valid ISBN" ) unless $ok;
	}

=item isbn_group_ok( STRING, COUNTRY )

Ok is the STRING is a valid ISBN and its country
code is the same as COUNTRY.

=cut

sub isbn_group_ok
	{
	my $isbn    = shift;
	my $country = shift;
	my $object  = Business::ISBN->new($isbn);

	unless( $object->is_valid )
		{
		$Test->diag("ISBN [$isbn] is not valid"),
		$Test->ok(0);
		}
	elsif( $object->group_code eq $country )
		{
		$Test->ok(1);
		}
	else
		{
		$Test->diag("ISBN [$isbn] group code is wrong\n",
			"\tExpected [$country]\n",
			"\tGot [" . $object->group_code . "]\n" );
		$Test->ok(0);
		}

	}

=item isbn_country_ok( STRING, COUNTRY )

Deprecated. Use isbn_group_ok. This is still exported, though.

For now it warns and redirects to isbn_group_ok.

=cut

sub isbn_country_ok
	{
	$Test->diag( "isbn_country_ok is deprecated. Use isbn_group_ok" );
	
	&isbn_group_ok;
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
		$Test->diag("ISBN [$isbn] is not valid"),
		$Test->ok(0);
		}
	elsif( $object->publisher_code eq $publisher )
		{
		$Test->ok(1);
		}
	else
		{
		$Test->diag("ISBN [$isbn] publisher code is wrong\n",
			"\tExpected [$publisher]\n",
			"\tGot [" . $object->publisher_code . "]\n" );
		$Test->ok(0);
		}
	}

=back

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	http://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2002-2007 brian d foy.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


1;
