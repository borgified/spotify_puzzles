#!/usr/bin/env perl

use warnings;
use strict;

my $a=13;

my $bin_a=sprintf("%b",$a);

my @bin_a=split(//,$bin_a);

my @bin_b=reverse(@bin_a);

my $bin_b=join('',@bin_b);

my $b = oct("0b$bin_b");

print $b;
