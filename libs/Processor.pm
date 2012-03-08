package Homyaki::Processor;

sub new {
        my $this = shift;
        my %h = @_;

        my $self = {};

        my $class = ref($this) || $this;
        bless $self, $class;

        return $self;
}

sub pre_process {
        my $this = shift;
        my %h = @_;

}

1;
