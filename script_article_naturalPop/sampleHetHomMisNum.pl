#!/usr/bin/perl
use strict;
my $input = $ARGV[0];
open (IN,($input =~ /\.gz$/)? "gzip -dc $input |" : $input);
print"Sample\trefR\thetR\thomR\tmisR\n";
while(<IN>){
        chomp;
	my @l = split /\s+/, $_;
        next if(/CHROM|POS|REF|ALT/);
	my $het = 0;
	my $hom = 0;
	my $ref = 0;
	my $mis = 0;
	for(my $i=1;$i<=$#l;$i++){
		if($l[$i] eq "./."){
			$mis ++;
		}elsif($l[$i] eq "0/0"){
			$ref ++;
		}elsif($l[$i] eq "0/1"){
			$het ++;
		}elsif($l[$i] eq "1/1"){
			$hom ++;
		}
	}
	my $total = $het + $hom + $ref + $mis;
	my $hetR = sprintf"%.4f", $total != 0 ? $het/$total : 0;
	my $homR = sprintf"%.4f", $total != 0 ? $hom/$total : 0;
	my $refR = sprintf"%.4f", $total != 0 ? $ref/$total : 0;
	my $misR = sprintf"%.4f", $total != 0 ? $mis/$total : 0;
	print"$l[0]\t$refR\t$hetR\t$homR\t$misR\n";
}
close IN;

