#!/bin/bash
rm /tmp/whc.dat
#cd hostbill
#perl mkhostbillforLedger.pl
#find output/ -iname '*.csv'|xargs -n1 -I{} echo {}
#find output/ -iname '*.csv'|xargs -n1 -I{} reckon -a {} --contains-header -f {} -p 
#echo "for now you have to manually copy and paste each of these into bash, working on workarounds next"
#find output/ -iname '*.csv'|xargs -n1 -I{} echo "reckon -a Member:Sales --contains-header -f {} -o /tmp/whc.dat"
#find output/ -iname '*.csv'|xargs -n1 -I{} /usr/local/bin/CSV2Ledger.pl -c "date,invoice_id,description,id,firstname,lastname,gateway,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i {} -o '/tmp/whc.dat'
#find output/ -iname '*.csv'|xargs -n1 -I{} -m 'AccountMatches.yaml' /usr/local/bin/CSV2Ledger.pl -c "date,invoice_id,description,id,firstname,lastname,gateway,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i {} -o '/tmp/whc.dat'

#start making
#/usr/local/bin/CSV2Ledger.pl -m 'AccountMatches.yaml' -s 'Gateway:Bitcoin' -c "date,invoice_id,description,id,firstname,lastname,gateway,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'output/gateway/PaywithBitcoin-gateway.csv' -o '/tmp/whc.dat'
#/usr/local/bin/CSV2Ledger.pl -m 'AccountMatches.yaml' -s 'Gateway:Paypal' -c "date,invoice_id,description,id,firstname,lastname,gateway,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'output/gateway/PaywithPayPal-gateway.csv' -o '/tmp/whc.dat'
#/usr/local/bin/CSV2Ledger.pl -m 'AccountMatches.yaml' -s 'Gateway:Authorize.net' -c "date,invoice_id,description,id,firstname,lastname,gateway,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'output/gateway/PaywithaCreditCard-gateway.csv' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'ATTAccountMatches.yaml' -s 'Expense:ATT' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/att.CSV' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'buycpanelAccountMatches.yaml' -s 'Expense:buycpanel' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/buycpanel.CSV' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'cloudlinuxAccountMatches.yaml' -s 'Expense:cloudlinux' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/cloudlinux.CSV' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'rackspaceAccountMatches.yaml' -s 'Expense:rackspace' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/rackspace.CSV' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'realnormalAccountMatches.yaml' -s 'Expense:realnormal' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/realnormal.CSV' -o '/tmp/whc.dat'
/usr/local/bin/CSV2Ledger.pl -m 'xtremexhibitsAccountMatches.yaml' -s 'Expense:xtremexhibits' -c "vendor,description,invoice_id,date,duedate,unknown,subtotal,amount" -d "date" -a "amount" -n "invoice_id" -t "description" -i 'CSV/xtremexhibits.CSV' -o '/tmp/whc.dat'
