#! /usr/bin/perl
# $Id: 99_pod_coverage.t,v 1.1 2010/01/13 22:07:14 dk Exp $

use strict;
use warnings;

use Test::More;

eval 'use Test::Pod::Coverage';
plan skip_all => 'Test::Pod::Coverage required for testing POD coverage'
     if $@;

plan tests => 1;
pod_coverage_ok( 'MooseX::Lists');
