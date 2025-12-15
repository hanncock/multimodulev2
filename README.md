/setup => create tables
/apifields/{module}/{class} => get the fields
/showclasses => get the classes/tables
/api/{module}/{class} =>  get the data


https://dribbble.com/search/vehicle-management-system-wiith-forms-for-adding-new-vehicle


[//]: # (INSERT INTO accpackages &#40;accpackage_id, accpackageName, description, poastingaccId, companyId, amount&#41;)

[//]: # (VALUES)

[//]: # (&#40;'d9081522359106185', 'Subscription', 'Instant Subscription', '9081510518846744', 'COMP006', 10000&#41;,)

[//]: # (&#40;'9091100561498077', 'Registration', 'Student Registration', '9081510518846744', 'COMP006', 5000&#41;;)

[//]: # ()
[//]: # ()
[//]: # (INSERT INTO accpackages &#40;accpackage_id, accpackageName, description, coa_id, companyId, amount&#41;)

[//]: # (VALUES)

[//]: # (&#40;'9081522359106185', 'Subscription', 'Instant Subscription', '9081510518846744', 'COMP006', 10000&#41;,)

[//]: # (&#40;'9091100561498077', 'Registration', 'Student Registration', '9081510518846744', 'COMP006', 5000&#41;;)

INSERT INTO accpackages (accpackage_id, accpackageName, description, postingaccId, companyId, amount)
VALUES  
('9081522359106185', 'Subscription', 'Instant Subscription', '9081510518846744', 'COMP006', 10000),
('9091100561498077', 'Registration', 'Student Registration', '9081510518846744', 'COMP006', 5000);


Expanded(child: buildField("Quantity", inv_line_formSchema, _invlines_formData, [updateLineTotal])),
Expanded(child: buildField("Unit Amount", inv_line_formSchema, _invlines_formData, [updateLineTotal])),

invoice sample
https://dribbble.com/shots/26253670-Finnie-Payment-Invoices


{"custom_inv_No":"INV234","chargedTo":"9091042045562782","chargedToName":"Bucky
Barnes","description":"DESCR","dueDate":"2025-12-05","invoicelines":[{"invoice_No":"202512011444364032","accpackage_id":"9081522359106185","invLineDescr":"Instant
Subscription","unitAmnt":"10000","quantity":"1","totalAmnt":"10000.00","chargedPackage":"9081522359106185","journalentries":[{"transaction_id":"null","account_id":"9081510518846744","accountName":"Subscription","journalDate":"",
"debit":"10000.00","credit":"0.00"},{"transaction_id":"null","account_id":"11240912359273114","accountName":"Other
Receivables","journalDate":"","debit":"0.00","credit":"10000.00"}]},{"invoice_No":"202512011444364032","accpackage_id":"11261448078645969","invLineDescr":"Customer
messaging","unitAmnt":"500","quantity":"1","totalAmnt":"500.00","chargedPackage":"11261448078645969","journalentries":[{"transaction_id":"null","account_id":"901155325667185","accountName":"Tuition","journalDate":"","debit":"500
.00","credit":"0.00"},{"transaction_id":"null","account_id":"11240912359273114","accountName":"Other
Receivables","journalDate":"","debit":"0.00","credit":"500.00"}]}],"amount":10500,"invNo":"202512011444364032","status":"PENDING","trnxType":"INV","companyId":"COMP006"}
