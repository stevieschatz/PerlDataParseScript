#!/usr/bin/perl

#Stephen Schatzl 
#Perl Script

use strict;
use warnings;



my $line;
my $date;
my $time;
my $pubNum;
my $user;
my $status;
my $line1;
my $line2;
my $trimStatus;

my $username;
my $user1;
my $line3;
my $line4;

open(FD,"/home/sschatzl/log.smbd") or die("Could Not Open File"); #Opens log file with data to be manipulated     

foreach $line (<FD>){

	if(index($line, 'make_connection') != -1) {
		 #This stores the first line to be manipulated and stores the important information into variables
		 $line1 = $line;
		 $date = substr($line1,1,10);
		 $time = substr($line1,12,8);
		
		}
	elsif(index($line, 'connect to service') != -1){
		 $line2 = $line; 
		 $pubNum = substr($line2,0,index($line2, '('));
		 $pubNum =~ s/^\s+|\s+$//g; #trim both ends
		 $status = substr($line2,index($line2,')'),9);	
		 $trimStatus = substr($status,2,7);		
		 #$user = substr($line2, index($line2, 'user'),index($line2, '(u'));
		 $username = substr($line2, index($line2,'user'),index($line2,'(u'));
                 $user1 = substr($username,5,index($line2,'(u'));
                 $user1 =~ s/^\s+//;
                 $user1 =~ s/ .+$//;
		 $user1 =~ s/^\s+|\s+$//g;
	
		print "\"$date\",\"$time\",\"$pubNum\",\"$trimStatus\",\"$user1\" \n";
		
		}
	elsif(index($line, 'close_cnum') != -1){
		$line3 = $line;	

		$date = substr($line1,1,10);
		$time = substr($line1,12,8);


		
	
		}
	elsif(index($line, 'closed') != -1){
                        $line4 = $line;
                        $pubNum = substr($line4 ,0, index($line4 ,'('));
                        $pubNum =~ s/^\s+|\s+$//g;
                        $status = substr($line4,index($line4,')'),12 );
                        $trimStatus = substr($status,2,6);
                        #print "$trimStatus\n";
                        
			$username = substr($line4, index($line4,'service',12));
			$username = substr($username,7,50);
			$username =~ s/^\s+|\s+$//g;
 	         
		 
		 #	$user1 = substr($username,5,index($line4,'(u'));
                 #	$user1 =~ s/^\s+//;
                 #	$user1 =~ s/ .+$//;
			
		
		print "\"$date\",\"$time\",\"$pubNum\",\"$trimStatus\",\"$username\" \n";

        }
	



#print "This is our pubname $user1 \n";


#print "This is our date: $date \n";
#print "This is our time: $time \n";
	
}





