#!/bin/perl -w

#########################################################################
#                                                                       #
#  This program parse a XML file, extracting the ID, total length,      #
#  3`UTR length and cds position.                                       #
#  INPUT: XMLparser.pl file.xml output.txt 100                          #
#  OUTPUT: output.txt (ID utr-length cds-position)                      #
#                                                                       #
#########################################################################

use strict;
use XML::Twig;

my ($xmlfile, $output, $min_utr) = @ARGV;

  open(my $fh, ">", $output)
or die "Can't open > $output: $!";

my $t = XML::Twig->new( 
       # the twig will include just the root and selected titles 
           twig_roots   => { 'Item' => \&get_data}
                      );
$t->parsefile( $xmlfile);

  sub get_data 
    { my( $t, $elt)= @_;
      my $old_cds_location = $elt->first_child('old_cds_location')->text;    # print the text (including sub-element texts
      my $length =  $elt->first_child('length')->text;

      $old_cds_location =~ m/gb.(\w*):\d*-(\S*)/; #gb|LC069810:88-10251

      my $utr3 = $length - $2; #$total_length - $cds_length

      if($utr3  >= $min_utr){
        print $fh "$1 $utr3 $2\n";
      }

      $t->purge;           # frees the memory
    }