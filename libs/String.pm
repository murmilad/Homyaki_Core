package Homyaki::String;

use strict;

sub handle_template {
	my $class = shift;

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
