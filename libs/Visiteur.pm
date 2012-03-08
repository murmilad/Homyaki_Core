package Homyaki::Visiteur;

use strict;

use Homyaki::Tag;

sub new {
	my $this = shift;
	my %h = @_;

	my $params = $h{params};

	my $self = {};

	my $class = ref($this) || $this;
	bless $self, $class;

	$self->{params} = $params;

	return $self;
}


sub execute {
	my $this = shift;
	my %h = @_;

	my $tag = $h{tag};

}

1;
