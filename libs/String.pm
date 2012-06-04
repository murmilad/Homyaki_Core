package Homyaki::String;

use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

require Exporter;
@ISA = qw(Exporter);

@EXPORT_OK = qw(
	handle_template
);

sub handle_template {
	my %h = @_;
	my $template_path = $h{template_path};
	my $parameters    = $h{parameters} || {};

	my $result = '';
	if (open TEMPLATE, "<$template_path"){
		while (my $string = <TEMPLATE>) {
			foreach my $parameter (keys %{$parameters}){
				$string =~ s/\%$parameter\%/$parameters->{$parameter}/g;
				$result .= $string;
			}
		}
	}

	return $result;
}

1;
