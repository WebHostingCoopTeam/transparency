#!/bin/bash
#./icsv2ledger.py --config-file=./ics.config --account=hostbill --clear-screen=True --credit=18 --debit=0 --currency='$' --date=3 --csv-date-format='%Y-%b-%m' --skip-lines=1 invoiceswitems.csv /tmp/outty.dat
#./icsv2ledger.py --account hostbill --clear-screen --credit 18 --debit 0 --currency '$' --date 3 --csv-date-format '%Y-%b-%m' --skip-lines 1 invoiceswitems.csv /tmp/outty.dat
./icsv2ledger.py --account hostbill --clear-screen --credit 18 --debit 0 --currency '$' --date 3 --csv-date-format '%Y-%b-%m' --skip-lines 1 /tmp/test.csv /tmp/outty.dat
