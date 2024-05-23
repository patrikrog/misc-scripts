#!/usr/bin/perl
use strict; use warnings; use Env;

my %hidden_windows;
my @hidden_window_ids = split("\n", `bspc query -N -n .hidden.window`);

for my $hidden_window_id (@hidden_window_ids) {
    my @window_name = split("\"", `xprop -id $hidden_window_id WM_CLASS`);
    chomp($window_name[3]);
    $hidden_windows{$hidden_window_id} = $window_name[3];
}

my $rofi_string = "";

for my $hidden_window_id (keys %hidden_windows) {
    $rofi_string = $rofi_string . "$hidden_windows{$hidden_window_id},";
}

my $choice = `echo $rofi_string | rofi -dmenu -sep ,`; chomp($choice);
my @matches;

for my $hidden_window_id (keys %hidden_windows) {
    my $window_name = $hidden_windows{$hidden_window_id};
    print("$choice == $window_name\n");
    push(@matches, $hidden_window_id) if ($window_name eq $choice);
}

foreach (@matches) {
    system("bspc node $_ -g hidden=off");
    system("bspc node -f $_");
}
