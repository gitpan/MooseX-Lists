# $Id: Lists.pm,v 1.2 2010/01/13 22:10:03 dk Exp $
package MooseX::Lists;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:KARASIK';

use strict;
use warnings;
use Moose ();
use Moose::Exporter;

sub Array
{
	my $next = shift;
	my $self = shift;
	if ( 1 == @_ and $_[0] and ref($_[0]) eq 'ARRAY') {
		return $self->$next(@_);
	} elsif ( @_ ) {
		return $self->$next(\@_);
	} else {
		my $r = $self-> $next;
		return wantarray ? @$r : $r;
	}
}

sub Hash
{
	my $next = shift;
	my $self = shift;
	if ( 1 == @_ and $_[0] and ref($_[0]) eq 'HASH') {
		return $self->$next(@_);
	} elsif ( @_ ) {
		return $self->$next({@_});
	} else {
		my $r = $self-> $next;
		return wantarray ? %$r : $r;
	}
}

sub has_list
{
	my ( $meta, $name, %options ) = @_;

	my $accessor;
	if ( defined $options{isa}) {
		if ( $options{isa} eq 'Array') {
			$accessor = \&Array;
		} elsif ( $options{isa} eq 'Hash') { 
			$accessor = \&Hash;
		} else {
			die "bad 'isa' option: must be either 'Array' or 'Hash";
		}
		delete $options{isa};
	} else {
		$accessor = \&array_ref;
	}

	$meta-> add_attribute($name, %options);
	$meta-> add_around_method_modifier( $name, $accessor);
}

Moose::Exporter-> setup_import_methods(
      with_meta => [ 'has_list' ],
);


1;

__DATA__

=pod

=head1 NAME

MooseX::Lists - treat arrays and hashes as lists

=head1 SYNOPSIS

   package Stuff;

   use Moose;
   use MooseX::Lists;

   has_list a => ( is => 'rw', isa => 'Array');
   has_list h => ( is => 'rw', isa => 'Hash' );

   has_list same_as_a => ( is => 'rw' );

   ...

   my $s = Stuff-> new(
   	a => [1,2,3],
	h => { a => 1, b => 2 }
   );

   my @list   = $s-> a;     # ( 1 2 3 )
   my $scalar = $s-> a;     # [ 1 2 3 ]

   $s-> a(1,2,3);           # 1 2 3
   $s-> a([1,2,3]);         # 1 2 3
   $s-> a([]);              # empty array
   $s-> a([[]]);            # []

   my %list = $s-> h;       # ( a => 1, b => 2 )
   my $sc   = $s-> h;       # { a => 1, b => 2 }

   $s-> h(1,2,3,4);         # 1 2 3 4
   $s-> h({1,2,3,4});       # 1 2 3 4
   $s-> h({});              # empty hash

=head1 DESCRIPTION

Provides asymmetric list access for arrays and hashes. 

=head1 METHODS

=over

=item has_list

Replacement for C<has>, with exactly same syntax, expect for C<isa>,
which can be either C<Array> or C<Hash>. C<[]> notation is not supported.

When a method is declared with C<has_list>, internally it is a normal
perl array or hash (Moose's C<ArrayRef> and C<HashRef> don't apply).
The method behaves differently if called in scalar or list context.
See below for details.

=item Array

In get-mode, behaves like C<auto_deref>: in scalar context, returns direct
reference to the array, list context, returns defereenced array.

In set-mode behaves asymmetrically: if passed one argument, and this
argument is an arrayref, treats it as an arrayref, otherwise dereferences
the arguments and creates a new arrayref, which is stored internally.
I.e. the only way to clear the array is to call C< ->method([]) >.

=item Hash

In get-mode, behaves like C<auto_deref>: in scalar context, returns direct
reference to the hash, list context, returns defereenced hash.

In set-mode behaves asymmetrically: if passed one argument, and this
argument is a hashref, treats it as a hashref, otherwise dereferences
the arguments and creates a new hashref, which is stored internally.
I.e. the only way to clear the hash is to call C< ->method({}) >.

=back

=head1 AUTHOR

Dmitry Karasik, E<lt>dmitry@karasik.eu.orgE<gt>.

=head1 THANKS

Karen Etheridge, Jesse Luehrs.

=cut
