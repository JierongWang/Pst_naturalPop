#!/usr/bin/perl
use strict;
my $input = $ARGV[0];
open (IN,($input =~ /\.gz$/)? "gzip -dc $input |" : $input);
while(<IN>){
        chomp;
	my @l = split /\s+/, $_;
	if(/^#CHROM/){
		print"$l[0]\t$l[1]\t$l[3]\t$l[4]";
		for(my $i=9;$i<=$#l;$i++){
			print"\t$l[$i]";
		}
		print"\n";
	}
        next if(/^#/);
	print"$l[0]\t$l[1]\t$l[3]\t$l[4]";
	for(my $i=9;$i<=$#l;$i++){
		my @type = split /\:|\/|\|/, $l[$i]; 
		if($type[0] eq "."){
			print"\t$type[0]/$type[0]";
		}else{
			print"\t$type[0]/$type[1]";
		}
	}
	print"\n";
}
close IN;

