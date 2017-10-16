#!/bin/perl -w

#########################################################################
#                                                                       #
#  This example shows how to use the twig_roots option                  #
#  It outputs the name of the leader in a statistical category          #
#                                                                       #
#########################################################################

use strict;
use XML::Twig;

my $xmlfile = $ARGV[0];
my $output = $ARGV[1];

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

      print $fh "$1 $utr3 $2\n";
      $t->purge;           # frees the memory
    }