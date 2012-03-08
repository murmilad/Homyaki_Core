package Homyaki::Permission_Factory;

use strict;

use Exporter;

use base 'Homyaki::Factory';


use constant INTERFACE_MAP => {
	main         => 'Homyaki::Interface::Permissions',
	default      => 'Homyaki::Interface::Permissions',
	gallery      => 'Homyaki::Interface::Gallery::Permissions',
	task         => 'Homyaki::Interface::Task_Manager::Permissions',
	geo_maps     => 'Homyaki::Interface::Geo_Maps::Permissions',
};

sub create_permissions{
	my $class = shift;

	my %h = @_;
	my $handler      = $h{handler};
	my $params       = $h{params};

	my $interface;
	
	if (&INTERFACE_MAP->{$handler}) {
		$class->require_handler(&INTERFACE_MAP->{$handler});
		&INTERFACE_MAP->{$handler}->new(
			params => $params,
		);
	} else {
		$class->require_handler(&INTERFACE_MAP->{default});
		&INTERFACE_MAP->{default}->new(
			params => $params,
		);
	}
}

1;
