#!/usr/bin/perl

use strict;
use warnings;
use DBI;

my %uniqids = ();
my %uniqgateways = ();
my %uniqdescriptions = ();
mkdir '../output' or die "(hint: remove the old output directory) Error creating directory: $!";
#mkdir '../output/owners' or die "(hint: remove the old owners directory) Error creating directory: $!";
mkdir '../output/gateway' or die "(hint: remove the old gateway directory) Error creating directory: $!";
#mkdir '../output/descriptions' or die "(hint: remove the old descriptions directory) Error creating directory: $!";

# Connect to the database, (the directory containing our csv file(s))
my $dbh = DBI->connect ("dbi:CSV:", undef, undef, {
  f_dir   => ".",
  f_ext   => ".csv/r",
  f_enc   => "utf-8",
});

#print "Vendor,Type,Num,Date,Due Date,Aging,Amount,Open Balance\n";
#print ",,,,,,,\n";
my $presth = $dbh->prepare ("select * from invoiceswitems join clients on invoiceswitems.email = clients.email");
$presth->execute;
while (my $prerow = $presth->fetchrow_hashref) {
  $uniqids{ $prerow->{email} } = 1;
  $uniqgateways{ $prerow->{gateway} } = 1;
  $uniqdescriptions{ $prerow->{description} } = 1;
}

# genIDs();
# genDescriptions();
#genGateways();
genWeigleyHBGateways();

sub genIDs {
  for my $key (keys %uniqids) {
    my $uniq_output = "date,description,id,firstname,lastname,gateway,amount\n";
    # print "date,description,id,firstname,lastname,gateway,amount\n";
    # my $sth = $dbh->prepare ("select * from invoiceswitems join clients on invoiceswitems.email = clients.email");
    my $sth = $dbh->prepare ("select * from invoiceswitems where invoiceswitems.email = '$key'");
    #my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
    #my $sth = $dbh->prepare ("select * from invoices");
    $sth->execute;
    while (my $row = $sth->fetchrow_hashref) {
      my $printme;
      # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
      # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
      # print "$row->{email},$row->{invoice_id},$row->{date},$row->{duedate},$row->{description},$row->{price}\n";
      #print "$key $row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme = "$row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme  =~ s/\r\n/\ /g;
      $printme  =~ s/\n/\ /g;
      $printme  =~ s/\r/\ /g;
      $printme .= "\n";
      #  print "$printme";
      $uniq_output .= $printme;

    }
    $key =~ tr/ //ds;
    $key =~ s/[^A-Za-z0-9]//g;
    $key .= '-owner.csv';
    open(my $fh, '>>', "../output/owners/$key") or die "Could not open file 'owners/$key' $!";
    print $fh "$uniq_output";
    close $fh;
  }
  return;
}

sub genWeigleyHBGateways {
  for my $key (keys %uniqgateways) {
    #my $uniq_output = "date,invoice_id,description,id,firstname,lastname,gateway,amount\n";
    my $uniq_output = "";
    # print "date,description,id,firstname,lastname,gateway,amount\n";
    # my $sth = $dbh->prepare ("select * from invoiceswitems join clients on invoiceswitems.email = clients.email");
    my $sth = $dbh->prepare ("select * from invoiceswitems where invoiceswitems.gateway = '$key'");
    #my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
    #my $sth = $dbh->prepare ("select * from invoices");
    $sth->execute;
    while (my $row = $sth->fetchrow_hashref) {
      my $printme;
      # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
      # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
      # print "$row->{email},$row->{invoice_id},$row->{date},$row->{duedate},$row->{description},$row->{price}\n";
      #print "$key $row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      my ($year, $month, $day) = split(/-/, $row->{duedate});
      $printme = "$month/$day/$year,$row->{invoice_id},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme  =~ s/\r\n/\ /g;
      $printme  =~ s/\n/\ /g;
      $printme  =~ s/\r/\ /g;
      $printme .= "\n";
      #  print "$printme";
      $uniq_output .= $printme;

    }
    $key =~ tr/ //ds;
    $key =~ s/[^A-Za-z0-9]//g;
    $key .= '-gateway.csv';
    print $key . "\n";
    open(my $fh, '>>', "../output/gateway/$key") or die "Could not open file 'gateway/$key' $!";
    print $fh "$uniq_output";
    close $fh;
  }
  return;
}
sub genGateways {
  for my $key (keys %uniqgateways) {
    my $uniq_output = "date,description,id,firstname,lastname,gateway,amount\n";
    # print "date,description,id,firstname,lastname,gateway,amount\n";
    # my $sth = $dbh->prepare ("select * from invoiceswitems join clients on invoiceswitems.email = clients.email");
    my $sth = $dbh->prepare ("select * from invoiceswitems where invoiceswitems.gateway = '$key'");
    #my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
    #my $sth = $dbh->prepare ("select * from invoices");
    $sth->execute;
    while (my $row = $sth->fetchrow_hashref) {
      my $printme;
      # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
      # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
      # print "$row->{email},$row->{invoice_id},$row->{date},$row->{duedate},$row->{description},$row->{price}\n";
      #print "$key $row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme = "$row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme  =~ s/\r\n/\ /g;
      $printme  =~ s/\n/\ /g;
      $printme  =~ s/\r/\ /g;
      $printme .= "\n";
      #  print "$printme";
      $uniq_output .= $printme;

    }
    $key =~ tr/ //ds;
    $key =~ s/[^A-Za-z0-9]//g;
    $key .= '-gateway.csv';
    print $key . "\n";
    open(my $fh, '>>', "../output/gateway/$key") or die "Could not open file 'gateway/$key' $!";
    print $fh "$uniq_output";
    close $fh;
  }
  return;
}

sub genDescriptions {
  for my $key (keys %uniqdescriptions) {
    my $uniq_output = "date,description,id,firstname,lastname,gateway,amount\n";
    # print "date,description,id,firstname,lastname,gateway,amount\n";
    # my $sth = $dbh->prepare ("select * from invoiceswitems join clients on invoiceswitems.email = clients.email");
    my $sth = $dbh->prepare ("select * from invoiceswitems where invoiceswitems.description = '$key'");
    #my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
    #my $sth = $dbh->prepare ("select * from invoices");
    $sth->execute;
    while (my $row = $sth->fetchrow_hashref) {
      my $printme;
      # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
      # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
      # print "$row->{email},$row->{invoice_id},$row->{date},$row->{duedate},$row->{description},$row->{price}\n";
      #print "$key $row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme = "$row->{duedate},$row->{description},$row->{email},$row->{firstname},$row->{lastname},$row->{gateway},$row->{price}";
      $printme  =~ s/\r\n/\ /g;
      $printme  =~ s/\n/\ /g;
      $printme  =~ s/\r/\ /g;
      $printme .= "\n";
      #  print "$printme";
      $uniq_output .= $printme;

    }
    $key =~ tr/ //ds;
    $key =~ s/[^A-Za-z0-9]//g;
    $key .= '-description.csv';
    $key = substr($key, 0, 55);
    open(my $fh, '>>', "../output/descriptions/$key") or die "Could not open file 'descriptions/$key' $!";
    print $fh "$uniq_output";
    close $fh;
  }
  return;
}
