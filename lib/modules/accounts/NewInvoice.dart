import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:multimodule/reusables/loader.dart';

import '../../Wrapper.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';

class NewInvoice extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;

  NewInvoice({this.editingRow, this.onSaved, super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {

  Map<String, dynamic> _formData = {};
  Map<String, dynamic> _invlines_formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var invNo;


  Map<String, dynamic> formSchema={};
  Map<String, dynamic> inv_line_formSchema={};
  List<Map<String, dynamic>> invoiceLines = [];

  List customers = [];

  List chargePackages = [];

  var overallTotal;


  getCustomers()async{
    var resu = await auth.getvalues("api/finance/customer/list");
    print("values found customers are ");
    setState(() {
      customers= resu;
    });
  }

  getInvNo()async{
    var resu = await auth.getvalues("invoiceNo");
    print("values found customers are ");
    setState(() {
      invNo= resu;
    });
  }



  getFields()async{
    var resu = await auth.getvalues("apifields/finance/invoice");
    setState(() {
      formSchema = resu;
    });
  }

  getInvLines()async{
    // var resu = await auth.getvalues("apifields/finance/invline");
    var resu = await auth.getvalues("apifields/finance/invoiceline");
    print("inbvlines are ");

    setState(() {
      inv_line_formSchema = resu;
    });
  }

  getChargePackages()async{
    var resu = await auth.getvalues("api/finance/accpackage/list");
    print("charges are ${resu}");
    setState(() {
      chargePackages= resu;
    });
  }


  // updateLineTotal([Map<String, dynamic>? values]) {
  // updateLineTotal(List? values) {
  updateLineTotal(int index, String? values) {


    final selectedPackage = chargePackages.firstWhereOrNull(
          (pkg) => pkg['accpackage_id'].toString() == values.toString(),
    );

    if (selectedPackage != null) {
      setState(() {
        invoiceLines[index]['accpackage_id'] = selectedPackage['accpackage_id'];
        invoiceLines[index]['invLineDescr'] = selectedPackage['description'];
        // invoiceLines[index]['quantity'] = selectedPackage['quantity'].toString() ?? '1';
        invoiceLines[index]['quantity'] = '1';
        invoiceLines[index]['unitAmnt'] =
            selectedPackage['amount']?.toString() ?? '0';
      });
    }

    _recalculateLineTotal(index);
    setState(() {});
  }

  // selectCustomer(int index, String? values){
  selectCustomer(String? values){
    final selectedPackage = customers.firstWhereOrNull(
          (pkg) => pkg['customer_id'].toString() == values.toString(),
    );

    print("the selected Package is $selectedPackage");

    if (selectedPackage != null) {
      setState(() {
        _formData['chargedToName'] = selectedPackage['Names'];
      });
    }

  }



  void _recalculateLineTotal(int index) {
    final line = invoiceLines[index];


    final qty =
        double.tryParse(line['quantity']?.toString() ?? '1') ?? 1.0;
    final unit =
        double.tryParse(line['unitAmnt']?.toString() ?? '0') ?? 0.0;

    print("will be summing $qty  and $unit");


    final total = unit * qty;

    setState(() {
      invoiceLines[index]['totalAmnt'] = total.toStringAsFixed(2);
    });

    overallTotal = invoiceLines.fold<double>(
      0.0,
          (sum, item) =>
      sum +
          (double.tryParse(item['totalAmnt']?.toString() ?? '0') ?? 0.0),
    );

    _formData['amount'] = overallTotal;


  }
  getInvlines(existingInvNo)async{
    var resu = await auth.getvalues("api/finance/invoiceline/list?invoice_No=${existingInvNo}");
    setState(() {
      invoiceLines= resu;
    });
  }



  void addInvoiceLine() {
    setState(() {
      invoiceLines.add({
        'invoice_No':invNo,
        'accpackage_id': '',
        'invLineDescr': '',
        'unitAmnt': '',
        'quantity': '',
        'totalAmnt': '',
      });
    });
  }

  void removeInvoiceLine(int index) {
    setState(() {
      invoiceLines.removeAt(index);
    });
  }


  @override
  void initState(){
    super.initState();
    // if (widget.editingRow != null) {
    //   _formData = Map<String, dynamic>.from(widget.editingRow!);
    // }

    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
      // getInvlines(_formData['invNo']);
      if (_formData.containsKey('invoicelines')) {
        invoiceLines = List<Map<String, dynamic>>.from(_formData['invoicelines']);
      }
    }

    getInvLines();

    getFields();
    getCustomers();

    getChargePackages();
    getInvNo();
  }


  @override
  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty
        ? LoadingSpinCircle()
        : Row(
      children: [
        Container(
          width: 550,
          child: Card(
            elevation: 8,
            child: Column(
              children: [
                Text('Invoice Sample'),
                // Text('${_invlines_formData}'),
                // Text('${_formData}'),
                // Text('Invoice Lines: $invoiceLines'),
                ...invoiceLines.map((item)=>Text('${item}'))
              ],
            ),
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${invNo}'),
                        Container(
                            width: 300,
                            child: buildField("Custom Invoice No", formSchema, _formData)
                        ),
                        Expanded(child: buildField("Charged To", formSchema, _formData,customers,['Names','cust_accNo'],'customer_id',(selected) => selectCustomer(selected))),
                        // Expanded(child: buildField("Charged To", formSchema, _formData,customers,['Names','cust_accNo'],'customer_id')),
                      ],
                    ),
                    // buildField("Invoice No", formSchema, _formData),
                    // buildField("Charged To", formSchema, _formData),
                    buildField("Description", formSchema, _formData),
                    SizedBox(
                        width: 300,
                        child: buildField("Due Date", formSchema, _formData)),

                  ],
                ),
                Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Invoice Lines'),
                            ElevatedButton.icon(
                              onPressed: () {
                                print("formdata valuea are $_formData");
                                _formData.putIfAbsent("invoicelines", () => []);

                                addInvoiceLine();

                                // _formData['invoicelines'].add(_invlines_formData);
                                // sideContent = !sideContent;
                                // row.clear();
                                setState(() {});
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: const Text("", style: TextStyle(fontSize: 13)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryPurple,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            )
                          ],
                        ),
                        Divider(thickness: 0.5,),


                        Column(
                          children: invoiceLines.asMap().entries.map((entry) {
                            final index = entry.key;
                            final line = entry.value;

                            return Card(
                              margin:  EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: buildField(
                                        "Charge Package",
                                        inv_line_formSchema,
                                        line,
                                        chargePackages,
                                        ['accpackageName', 'grouping'],
                                        'accpackage_id',
                                            (selected) => updateLineTotal(index, selected),
                                      ),
                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      // child: buildField("Description", inv_line_formSchema, line),
                                      child: buildField("Description", inv_line_formSchema, line,[],(selected) => updateLineTotal(index, selected)),


                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      // child: buildField("Unit Amount", inv_line_formSchema, line,[],(selected)=> updateLineTotal(index, selected)),
                                      child: buildField("Unit Amount", inv_line_formSchema, line,[], (value) {
                                        line['unitAmnt'] = value;
                                        _recalculateLineTotal(index);
                                      },),
                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: buildField("Quantity", inv_line_formSchema, line),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: buildField("Total Unit Amount", inv_line_formSchema, line),
                                    ),
                                     SizedBox(width: 8),
                                    IconButton(
                                      icon:  Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => removeInvoiceLine(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                ),

                Text('total Amount $overallTotal'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: ()async{
                      _formKey.currentState!.save();

                      _formData['invoicelines'] = invoiceLines;
                      _formData['invNo'] = invNo;
                      // _formData['amount'] = invNo;
                      _formData['trnxType'] = 'INV';
                      _formData.putIfAbsent("companyId", () => companyId);
                      print(_formData);

                      var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");

                      if (resu['data']?['success'] == true) {
                        _formData.clear();
                        invoiceLines.clear();
                        _formKey.currentState!.reset();
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invoice saved successfully!')),
                      );

                      setState(() {});

                    },
                    // onTap: () async {
                    //
                    //   print(_formData);
                    //   if (_formKey.currentState!.validate()) {
                    //     _formKey.currentState!.save();
                    //     _formData.putIfAbsent("companyId", () => companyId);
                    //     var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");
                    //
                    //     if (resu['data']?['success'] == true) {
                    //       _formData.clear();
                    //       _formKey.currentState!.reset();
                    //     }
                    //
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text('Form submitted!', style: TextStyle(color: Colors.red))),
                    //     );
                    //
                    //     if (widget.onSaved != null) widget.onSaved!();
                    //   }
                    // },
                    child: SContainer(
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*class NewInvoice extends StatefulWidget {
  final VoidCallback? onSaved;
  final Map<String, dynamic>? editingRow;

  const NewInvoice({this.editingRow, this.onSaved, super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {};
  Map<String, dynamic> formSchema = {};
  Map<String, dynamic> invLineSchema = {};

  List customers = [];
  List chargePackages = [];
  List<Map<String, dynamic>> invoiceLines = [];

  // ────────────────────────────────────────────────────────────────
  // API DATA FETCHING
  // ────────────────────────────────────────────────────────────────
  Future<void> getCustomers() async {
    var resu = await auth.getvalues("api/finance/customer/list");
    setState(() => customers = resu);
  }

  Future<void> getInvoiceFields() async {
    var resu = await auth.getvalues("apifields/finance/invoice");
    setState(() => formSchema = resu);
  }

  Future<void> getInvoiceLineFields() async {
    var resu = await auth.getvalues("apifields/finance/invoiceline");
    setState(() => invLineSchema = resu);
  }

  Future<void> getChargePackages() async {
    var resu = await auth.getvalues("api/finance/accpackage/list");
    setState(() => chargePackages = resu);
  }

  // ────────────────────────────────────────────────────────────────
  // LINE MANAGEMENT
  // ────────────────────────────────────────────────────────────────
  void addInvoiceLine() {
    setState(() {
      invoiceLines.add({
        'accpackage_id': '',
        'invLineDescr': '',
        'unitAmnt': '',
        'quantity': '',
      });
    });
  }

  void removeInvoiceLine(int index) {
    setState(() {
      invoiceLines.removeAt(index);
    });
  }

  void updateLineFromPackage(int index, String? selectedPackageId) {
    final selectedPackage = chargePackages.firstWhereOrNull(
          (pkg) => pkg['accpackage_id'].toString() == selectedPackageId.toString(),
    );

    if (selectedPackage != null) {
      setState(() {
        invoiceLines[index]['accpackage_id'] = selectedPackage['accpackage_id'];
        invoiceLines[index]['invLineDescr'] = selectedPackage['description'];
        invoiceLines[index]['unitAmnt'] =
            selectedPackage['amount']?.toString() ?? '0';
      });
    }
  }

  // ────────────────────────────────────────────────────────────────
  // INIT
  // ────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
      if (_formData.containsKey('invoicelines')) {
        invoiceLines = List<Map<String, dynamic>>.from(_formData['invoicelines']);
      }
    }
    getInvoiceFields();
    getInvoiceLineFields();
    getCustomers();
    getChargePackages();
  }

  // ────────────────────────────────────────────────────────────────
  // BUILD
  // ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (formSchema.isEmpty || invLineSchema.isEmpty) {
      return const LoadingSpinCircle();
    }

    return Row(
      children: [
        // SIDE PANEL (Preview)
        Container(
          width: 550,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Invoice Preview', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Header Data: $_formData'),
                  const Divider(),
                  Text('Invoice Lines: $invoiceLines'),
                ],
              ),
            ),
          ),
        ),

        // MAIN FORM
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ──────────── HEADER FIELDS ────────────
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: buildField("Invoice No", formSchema, _formData),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildField(
                          "Charged To",
                          formSchema,
                          _formData,
                          customers,
                          ['Names', 'cust_accNo'],
                          'customer_id',
                        ),
                      ),
                    ],
                  ),
                  buildField("Description", formSchema, _formData),
                  SizedBox(
                    width: 300,
                    child: buildField("Due Date", formSchema, _formData),
                  ),
                  const SizedBox(height: 20),

                  // ──────────── INVOICE LINES ────────────
                  const Text(
                    'Invoice Lines',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                  // Add button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: addInvoiceLine,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Line'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ──────────── LINE LIST ────────────
                  Column(
                    children: invoiceLines.asMap().entries.map((entry) {
                      final index = entry.key;
                      final line = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: buildField(
                                  "Charge Package",
                                  invLineSchema,
                                  line,
                                  chargePackages,
                                  ['accpackageName', 'grouping'],
                                  'accpackage_id',
                                      (selected) => updateLineFromPackage(index, selected),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: buildField("Description", invLineSchema, line),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: buildField("Unit Amount", invLineSchema, line),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: buildField("Quantity", invLineSchema, line),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeInvoiceLine(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // ──────────── SAVE BUTTON ────────────
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        _formData['invoicelines'] = invoiceLines;
                        _formData.putIfAbsent("companyId", () => companyId);

                        var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");

                        if (resu['data']?['success'] == true) {
                          _formData.clear();
                          invoiceLines.clear();
                          _formKey.currentState!.reset();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invoice saved successfully!')),
                        );

                        widget.onSaved?.call();
                      }
                    },
                    child: SContainer(
                      color: Colors.blueAccent,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
