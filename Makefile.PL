# $Id: Makefile.PL,v 1.2 2010/01/13 22:10:03 dk Exp $
use ExtUtils::MakeMaker;
WriteMakefile(
	NAME          => 'MooseX::Lists',
	AUTHOR        => 'Dmitry Karasik <dmitry@karasik.eu.org>',
	ABSTRACT_FROM => 'lib/MooseX/Lists.pm',
	VERSION_FROM  => 'lib/MooseX/Lists.pm',
	PREREQ_PM     => { 'Moose'  => 0 },
);
