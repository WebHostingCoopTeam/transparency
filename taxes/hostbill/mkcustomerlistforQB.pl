#!/usr/bin/perl
# hostbill
# client_id,status,firstname,lastname,companyname,email,address1,address2,city,state,postcode,country,phonenumber,currency,credit,taxexempt,latefeeoveride,overideduenotices,datecreated,lastlogin,ip
# 1,Active,Eric,Hanson, ,erich493@gmail.com,1098 NW 5th Ave., ,Boca Raton,Florida,33432,US,5612131925,USD,0.00,0,0,0,2013-06-20,0000-00-00 00:00:00,76.108.148.164

# QB example - notice the first field appears to be blank
# ,"Active Status","Customer","Balance","Balance Total","Company","Mr./Ms./...","First Name","M.I.","Last Name","Primary Contact","Main Phone","Fax","Alt. Phone","Secondary Contact","Job Title","Main Email","Bill to 1","Bill to 2","Bill to 3","Bill to 4","Bill to 5","Ship to 1","Ship to 2","Ship to 3","Ship to 4","Ship to 5","Customer Type","Terms","Rep","Sales Tax Code","Tax item","Resale Num","Account No.","Credit Limit","Job Status","Job Type","Job Description","Start Date","Projected End","End Date"
# ,"Active","Test",0.00,0.00,"Test","mr.","Test","T","McTesterson",,"5555555555",,,,"test","test@example.com","Test","Test T McTesterson",,,,,,,,,,,,,,,,"",,,,,,

use strict;
use warnings;
use DBI;

# Connect to the database, (the directory containing our csv file(s))
my $dbh = DBI->connect ("dbi:CSV:", undef, undef, {
  f_dir   => ".",
  f_ext   => ".csv/r",
  f_enc   => "utf-8",
  });

print  ',"Active Status","Customer","Balance","Balance Total","Company","Mr./Ms./...","First Name","M.I.","Last Name","Primary Contact","Main Phone","Fax","Alt. Phone","Secondary Contact","Job Title","Main Email","Bill to 1","Bill to 2","Bill to 3","Bill to 4","Bill to 5","Ship to 1","Ship to 2","Ship to 3","Ship to 4","Ship to 5","Customer Type","Terms","Rep","Sales Tax Code","Tax item","Resale Num","Account No.","Credit Limit","Job Status","Job Type","Job Description","Start Date","Projected End","End Date"';
#my $sth = $dbh->prepare ("select * from invoices join clients on invoices.email = clients.email");
my $sth = $dbh->prepare ("select * from clients");
#my $sth = $dbh->prepare ("select * from invoices where firstname like 'G%'");
#my $sth = $dbh->prepare ("select * from invoices");
$sth->execute;
while (my $row = $sth->fetchrow_hashref) {
  # print "  name = $row->{firstname} \tcontact = $row->{lastname}\n";
  # print "$row->{email},Credit,$row->{invoice_id},$row->{date},$row->{duedate},,$row->{total},$row{total}\n";
  # ,"Active Status"
  print ',' . '"' . $row->{status} . '"';
  # ,"Customer"
  print ',' . '"' . $row->{email} . '"';
  # "Balance note in hostbill this is a credit so applied here negatively"
  print ',' . '"-' . $row->{credit} . '"';
  # "Balance Total"
  print ',' . '"-' . $row->{credit} . '"';
  # "Company"
  print ',' . '"' . $row->{companyname} . '"';
  # "Mr./Ms./..." nothing in hostbill for his
  print ',';
  # "First Name"
  print ',' . '"' . $row->{firstname} . '"';
  # "M.I."
  print ',';
  # "Last Name"
  print ',' . '"' . $row->{lastname} . '"';
  # "Primary Contact"
  print ',';
  # "Main Phone"
  print ',' . '"' . $row->{phonenumber} . '"';
  # "Fax"
  print ',';
  # "Alt. Phone"
  print ',';
  # "Secondary Contact"
  print ',';
  # "Job Title"
  print ',';
  # "Main Email"
  print ',' . '"' . $row->{email} . '"';
  # "Bill to 1"
  print ',' . '"' . $row->{address1} . '"';
  # "Bill to 2"
  print ',' . '"' . $row->{address2} . '"';
  # "Bill to 3"
  print ',';
  # "Bill to 4"
  print ',';
  # "Bill to 5"
  print ',';
  # "Ship to 1"
  print ',' . '"' . $row->{address1} . '"';
  # "Ship to 2"
  print ',' . '"' . $row->{address2} . '"';
  # "Ship to 3"
  print ',';
  # "Ship to 4"
  print ',';
  # "Ship to 5"
  print ',';
  # "Customer Type"
  print ',';
  # "Terms"
  print ',';
  # "Rep"
  print ',';
  # "Sales Tax Code"
  print ',';
  # "Tax item"
  print ',';
  # "Resale Num"
  print ',';
  # "Account No."
  print ',' . '"' . $row->{client_id} . '"';
  # "Credit Limit"
  print ',';
  # "Job Status"
  print ',';
  # "Job Type"
  print ',';
  # "Job Description"
  print ',';
  # "Start Date"
  print ',' . '"' . $row->{datecreated} . '"';
  # "Projected End"
  print ',';
  # "End Date"
  print ',';
  print "\n";
}

