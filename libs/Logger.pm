package Homyaki::Logger;

use strict;

use POSIX qw(strftime);

sub print_log {
        my $str = shift;


        my $now_string = strftime "%a %b %e %H:%M:%S %Y", localtime;

        open LOG,">>/var/log/homyaki.log";
        print LOG  "[$now_string] $str\n";
        close LOG;
}

1;


