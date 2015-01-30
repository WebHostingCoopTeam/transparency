#!/usr/bin/perl

  use strict;
  use warnings;
  use DBI;

  # Connect to the database, (the directory containing our csv file(s))
  my $dbh = DBI->connect ("dbi:CSV:", undef, undef, {
      f_dir   => ".",
      f_ext   => ".csv/r",
      f_enc   => "utf-8",
      });

  print "Vendor,Type,Num,Date,Due Date,Aging,Amount,Open Balance\n";
  print ",,,,,,,\n";
  my $sth = $dbh->prepare ("select * from invoices join clients on invoices.email = clients.email");
  #my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
  #my $sth = $dbh->prepare ("select * from invoices");
  $sth->execute;
  while (my $row = $sth->fetchrow_hashref) {
    # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
    # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
    print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row->{total}\n";
      }
