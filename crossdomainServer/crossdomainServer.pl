#!/usr/bin/perl

use IO::Socket;
use Net::hostent;

my $port = 843;
my $server = IO::Socket::INET->new( Proto => 'tcp',
									LocalPort => $port,
									Listen => SOMAXCONN,
									Reuse => 1);

die "socket cannot be opened\n" unless $server;
print "server accepting connections on port $port\n";

while (($new_sock, $c_addr) = $server->accept())
{
	my ($client_port, $c_ip) = sockaddr_in($c_addr);
	my $client_ipnum = inet_ntoa($c_ip);
	my $client_host = gethostbyaddr($c_ip, AF_INET);
	print "connection from: " . $client_host->name . " ($client_ipnum) accepted\n"; 
	print "client says:\n";
	while (($n = read $new_sock, $data, 1) != 0)
	{
		print "AaA " . $data;
	} 
	print "\n";
	
	# write message to the client
	print $new_sock "<?xml version=\"1.0\"?><cross-domain-policy>";
	print $new_sock "<site-control permitted-cross-domain-policies=\"all\"/>";
	print $new_sock "<allow-access-from domain=\"*\" to-ports=\"*\" />";
	print $new_sock "</cross-domain-policy>\0";
	close $new_sock;
	
	print "crossdomain policy sent to client\n";
}



