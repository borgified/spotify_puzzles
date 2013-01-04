#!/usr/bin/env perl

use strict;
use warnings;

#open(INPUT,"input1") or die "cant open $!\n";
open(INPUT,"input2") or die "cant open $!\n";

my($number_of_songs,$number_to_select)=split(/ /,<INPUT>);

my %db;

for(my $i=1;$i <= $number_of_songs;$i++){
	my($f,$name_of_song)=split(/ /,<INPUT>);
	chomp($name_of_song);
	my $z = 1/$i;
	my $q = $f/$z;
	$db{$q}{$i}=$name_of_song;
}


my $counter=1;

foreach my $q (sort { $b <=> $a} keys %db){
	foreach my $i (sort keys $db{$q}){
		print "$db{$q}{$i}\n";
		$counter++;
		if($counter>$number_to_select){
			exit;
		}
	}
}
