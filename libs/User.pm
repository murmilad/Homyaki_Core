package Homyaki::User;

use strict;
use base 'Homyaki::DB';

__PACKAGE__->table('homyaki_user');
__PACKAGE__->columns(Primary => qw/id/);
__PACKAGE__->columns(Essential => qw/login password/);


sub retrieve {
	my $class = shift;
	my $id    = shift;

	my $self = $class->SUPER::retrieve($id);

	if ($self){
		$self->{permissions} = $self->get_permissions();
	} else {
		return undef;
	}

	return $self;
}

sub get_user_by_login {
	my $class = shift;
	my %h = @_;

	my $login    = $h{login};
	my $password = $h{password};

	my $user;

	my $query = q{
		SELECT * 
			FROM homyaki_user
		WHERE login = ? AND password = ?
	};

	my $users = $class->execute_free_query(
		query  => $query,
		params => [$login, $password]
	)->fetchall_arrayref({});

	if (ref($users) eq 'ARRAY' && scalar(@{$users}) > 0){
		$user = $class->retrieve($users->[0]->{id});
	}

	return $user;
}

sub get_permissions {
	my $self = shift;

	my $query = q{
		SELECT permission.name
			FROM homyaki_user_homyaki_group AS user_group
				INNER JOIN homyaki_group_permission ON homyaki_group_permission.homyaki_group_id = user_group.homyaki_group_id
				INNER JOIN permission ON permission.id = homyaki_group_permission.permission_id
		WHERE homyaki_user_id = ?
	};

	my $permissions = $self->execute_free_query(
		query  => $query,
		params => [$self->id()]
	)->fetchall_arrayref({});

	my @permissions = map {$_->{name}} @{$permissions};

	return \@permissions;
}

1;