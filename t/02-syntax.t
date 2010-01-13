#! /usr/bin/perl
# $Id: 02-syntax.t,v 1.1 2010/01/13 22:07:14 dk Exp $

use strict;
use warnings;
use Moose;
use MooseX::Lists;
use Test::More tests => 1;

has_list a  => (isa => 'Array', is => 'rw');
has_list h  => (isa => 'Hash',  is => 'rw');
has_list a2 => (is => 'rw');

ok( main->new, 'object');
