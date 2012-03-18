package Homyaki::Converter;

use strict;

use vars qw(@ISA @EXPORT_OK);

require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(get_html);

sub get_html {
	my $string = shift;

	$string =~ s/\n/<br\/>/g;

	return $string;
}

1;