/*

*********************************************************************
Problem a:
3 databases are created by this script (ap, ex, om), 
and plus a original (sys) if you wanna count.

*********************************************************************
Problem b:
1. ap: general_ledger_accounts, invoice_archive, invoice_line_items, invoices, terms, vendor_contacts, vendors
2. ex: active_invoices, color_sample, customers, date_sample, departments, employees, 
		  float_sample, null_sample, paid_invoices, projects, string_sample
3. om: customers, items, order_details, orders
4. sys: sys_config

*********************************************************************
Problem c:
68

*********************************************************************
Problem d:
customer_id

*/

-- 2.f:
SELECT * FROM  om.orders;

-- 2.g:
SELECT title, artist FROM om.items;
