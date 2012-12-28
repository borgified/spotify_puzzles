#!/usr/bin/env perl

#this script generates an input file for testing the bestbefore script

my $entries=100;

while($entries>0){
	$entries--;

	my $day = int(rand(30))+1;
	my $month = int(rand(11))+1;
	my $year = int(rand(999))+2000;

	if($day<10 && (int(rand(2)) == 0)){
		$day=sprintf("%02d",$day);
	}

	if($month<10 && (int(rand(2)) == 0)){
		$month=sprintf("%02d",$month);
	}

	if($year<2010 && (int(rand(2)) == 0)){
		$year=~/\d\d\d(\d)/;
		$year=$1;
	}elsif($year<2100 && (int(rand(2)) == 0)){
		$year=~/\d\d(\d\d)/;
		$year=$1;
	}

	print "$month/$day/$year\n";
	print "$month/$year/$day\n";
	print "$day/$month/$year\n";
	print "$day/$year/$month\n";
	print "$year/$month/$day\n";
	print "$year/$day/$month\n";
}

