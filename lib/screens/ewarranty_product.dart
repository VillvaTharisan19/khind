import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khind/components/gradient_button.dart';
import 'package:khind/models/product_warranty.dart';
import 'package:khind/services/repositories.dart';
import 'package:khind/util/helpers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:http/http.dart' as http;

class EwarrantyProduct extends StatefulWidget {
  final Map arguments;

  const EwarrantyProduct({Key? key, required this.arguments}) : super(key: key);
  @override
  _EwarrantyProductState createState() => _EwarrantyProductState();
}

class _EwarrantyProductState extends State<EwarrantyProduct> {
  int quantity = 0;
  String fileName = '';
  late File receiptFile;
  DateTime choosenDate = DateTime.now();
  bool displayDate = false;

  List<String> store = [
    'Lazada',
    'Shoppe',
    'Other Online Platform',
    'Physical Store',
  ];

  late String chosenStore;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      choosenDate = args.value;
      displayDate = false;
    });

    print(choosenDate.toString());
  }

  TextEditingController ref = new TextEditingController();

  @override
  void initState() {
    chosenStore = store[0];
    ref.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Helpers.customAppBar(
        context,
        _scaffoldKey,
        title: "Ewarranty",
        hasActions: false,
        isBack: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: FutureBuilder(
          future: Repositories.getProduct(
              productModel: widget.arguments['productModel']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProductWarranty productWarranty =
                  productWarrantyFromJson(snapshot.data.toString());

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          color: Colors.grey,
                          spreadRadius: 0.5,
                          // offset:
                        ),
                      ],
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productWarranty.data![0].productGroupDescription!),
                        Text(productWarranty.data![0].modelDescription!),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('Quantity'),
                            SizedBox(width: 30),
                            // Text

                            GestureDetector(
                              onTap: () {
                                if (quantity != 0) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 15,
                                ),
                              ),
                            ),

                            SizedBox(width: 7.5),
                            Text(quantity.toString()),
                            SizedBox(width: 7.5),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('Warranty Period : '),
                            Text('${formatDate(choosenDate, [
                                  'dd',
                                  '-',
                                  'mm',
                                  '-',
                                  'yyyy'
                                ])} - ${formatDate(choosenDate.add(Duration(days: 365)), [
                                  'dd',
                                  '-',
                                  'mm',
                                  '-',
                                  'yyyy'
                                ])}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          color: Colors.grey,
                          spreadRadius: 0.5,
                          // offset:
                        ),
                      ],
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Text('Purchase Date '),
                            ),
                            Expanded(
                              child: displayDate
                                  ? SfDateRangePicker(
                                      onSelectionChanged: _onSelectionChanged,
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      minDate: DateTime.now()
                                          .subtract(Duration(days: 7)),
                                      maxDate: DateTime.now(),
                                      initialDisplayDate: DateTime.now(),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          displayDate = true;
                                        });
                                      },
                                      child: choosenDate == DateTime.now()
                                          ? Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                              ),
                                              child: Text('Choose Date'),
                                            )
                                          : Text(formatDate(choosenDate, [
                                                'dd',
                                                '-',
                                                'mm',
                                                '-',
                                                'yyyy'
                                              ]) +
                                              ' (Click to change date)'),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Text('Store '),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                items: store.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  );
                                }).toList(),
                                isExpanded: true,
                                value: chosenStore,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    chosenStore = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Text('Referral Code '),
                            ),
                            Expanded(
                              child: TextField(
                                controller: ref,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          color: Colors.grey,
                          spreadRadius: 0.5,
                          // offset:
                        ),
                      ],
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              setState(() {
                                fileName = file.name;
                                receiptFile = File(file.path!);
                              });

                              print(file.name);
                              print(file.bytes);
                              print(file.size);
                              print(file.extension);
                              print(file.path);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              // color: Color(0xFFEFF0EF),
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: Text('Upload File'),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(fileName)),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Please fill in the blanks fields'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GradientButton(
                        height: 40,
                        child: Text(
                          "Save",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[Colors.white, Colors.grey[400]!],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        onPressed: () async {
                          var email = "khindcustomerservice@gmail.com";
                          await Repositories.registerEwarranty(
                            email: email,
                            productModel:
                                productWarranty.data![0].productModel!,
                            quantity: '$quantity',
                            purchaseDate: formatDate(
                                choosenDate, ['dd', '-', 'mm', '-', 'yyyy']),
                            referralCode: '',
                            receiptFile: receiptFile,
                          );

                          // print(ref.text);
                          // FormData formData = new FormData.from({
                          //   "name": "wendux",
                          //   "file1": new UploadFileInfo(
                          //       new File("./upload.jpg"), "upload1.jpg")
                          // });
                          // response = await dio.post("/info", data: formData);

                          Alert(
                            context: context,
                            // type: AlertType.info,
                            title: "Warranty Activation Submitted",
                            desc:
                                "Items will be reflected on My Purchases page",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Okay",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                        'home', (route) => false),
                                width: 120,
                              )
                            ],
                          ).show();
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
