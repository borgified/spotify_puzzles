#!/usr/bin/env perl

use warnings;
use strict;

sub main{

	if(defined($ARGV[0])){
		open(INPUT,"$ARGV[0]") or die "can't open $!";
	}else{
		open(INPUT,"input") or die "can't open $!";
	}
	while(defined(my $line=<INPUT>)){
		chomp($line);
		if($line=~/^#/){ #skip commented lines
			next;
		}
		my($a,$b,$c)=split(/\//,$line);

		my @date=($a,$b,$c);

		my @try = ($date[0],$date[1],$date[2]);
		my @try2= ($date[0],$date[2],$date[1]);
		my @try3= ($date[2],$date[1],$date[0]);
		my @try4= ($date[2],$date[0],$date[1]);
		my @try5= ($date[1],$date[0],$date[2]);
		my @try6= ($date[1],$date[2],$date[0]);

		my @alltry=([@try],[@try2],[@try3],[@try4],[@try5],[@try6]);

		my $legal=0;
		my @legal_dates;
		foreach my $date (@alltry){
			if(&is_legal(@$date)){
				push(@legal_dates,&format_date(@$date));
				$legal=1;
			}
		}
		if($legal == 0){
			print "$line is illegal\n";
		}else{
			@legal_dates=sort(@legal_dates);
			shift(@legal_dates)=~/(\d\d\d\d)(\d\d)(\d\d)/;
			#print "$line $1-$2-$3\n";
			print "$1-$2-$3\n";
		}
	}
}
&main;

#input: 3 item array ($month, $day, $year)
#output: a string: YYYYMMDD
sub format_date{
	my($month,$day,$year)=@_;

	$month=sprintf("%02d",$month);
	$day=sprintf("%02d",$day);

	if($year<1000){
		$year=$year+2000;
	}

	my $output=$year.$month.$day;

	return $output;
}




#input: a year
#output: 1 if leap year, 0 if not
sub is_leap{
	my($year)=@_;
	if($year<1000){
		$year=$year+2000;
	}
	my $leap=0;
	if(($year % 4) == 0){
		$leap=1;
		if(($year % 100) == 0){
			$leap=0;
			if(($year % 400) == 0){
				$leap=1;
			}
		}
	}
	return $leap;
}

#print &is_leap(2000); #1
#print &is_leap(2100); #0
#print &is_leap(2012); #1

#input: array ($month,$date,$year)
#output: 1 if legal, else 0
sub is_legal{
	my($month,$day,$year)=@_;

	my %max_days = (
		1 => '31',
		2 => '28',
		3 => '31',
		4 => '30',
		5 => '31',
		6 => '30',
		7 => '31',
		8 => '31',
		9 => '30',
		10 => '31',
		11 => '30',
		12 => '31',
	);


	my %max_days_leap = (
		1 => '31',
		2 => '29',
		3 => '31',
		4 => '30',
		5 => '31',
		6 => '30',
		7 => '31',
		8 => '31',
		9 => '30',
		10 => '31',
		11 => '30',
		12 => '31',
	);

	$month=$month+0; #0 unpad month so that it can be used as key in hashes

	if(($month>0)&&($month<13)){
		if(&is_leap($year)){
			if(($day>0)&&($day<=$max_days_leap{$month})){
				return 1;
			}
		}else{
			if(($day>0)&&($day<=$max_days{$month})){
				return 1;
			}
		}
	}
	return 0;
}

#print &is_legal(1,1,2013); #1
#print &is_legal(2,29,2013); #0
#print &is_legal(4,31,2013); #0
#print &is_legal(5,30,2013); #1
