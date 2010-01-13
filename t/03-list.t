#! /usr/bin/perl
# $Id: 03-list.t,v 1.1 2010/01/13 22:07:14 dk Exp $

use strict;
use warnings;

use Moose;
use MooseX::Lists;
use Test::More tests => 17;

has_list ar => (isa => 'Array', is => 'rw');
has_list hr => (isa => 'Hash',  is => 'rw');

my $x = main-> new;
ok($x, "object");

$x = main-> new( ar => [1,2,3]);
ok( 123 eq join('', $x->ar),           "ar.new/array");
ok( 123 eq join('', @{scalar $x->ar}), "ar.new/scalar");
$x-> ar(1,2,3);
ok( 123 eq join('', $x->ar),           "ar.list/array");
ok( 123 eq join('', @{scalar $x->ar}), "ar.list/scalar");
$x-> ar([1,2,3]);
ok( 123 eq join('', $x->ar),           "ar.ref/array");
ok( 123 eq join('', @{scalar $x->ar}), "ar.ref/scalar");
$x-> ar([]);
ok( '' eq join('', $x->ar),            "ar.empty/array");
ok( '' eq join('', @{scalar $x->ar}),  "ar.empty/scalar");

$x = main-> new( hr => {1,2,3,4});
ok( 1234 eq join('', sort $x->hr),           "hr.new/array");
ok( 1234 eq join('', sort %{scalar $x->hr}), "hr.new/scalar");
$x-> hr(1,2,3,4);
ok( 1234 eq join('', sort $x->hr),           "hr.list/array");
ok( 1234 eq join('', sort %{scalar $x->hr}), "hr.list/scalar");
$x-> hr({1,2,3,4});
ok( 1234 eq join('', sort $x->hr),           "hr.ref/array");
ok( 1234 eq join('', sort %{scalar $x->hr}), "hr.ref/scalar");
$x-> hr({});
ok( '' eq join('', sort $x->hr),             "hr.empty/array");
ok( '' eq join('', sort %{scalar $x->hr}),   "hr.empty/scalar");

