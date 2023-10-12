import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/pos_loading.dart';

// pickFile() async {
//    FilePickerResult? result = await FilePicker.platform.pickFiles();
//    if (result != null) {
//      PlatformFile file = result.files.first;

//      final input =  File(file.path!).openRead();
//      final fields = await input
//          .transform(utf8.decoder)
//          .transform( CsvToListConverter())
//          .toList();

//      print(fields);
//    }
//  }

pickXLFile(context) async {
  List rows = [];
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    lockParentWindow: true,
    type: FileType.custom,
    allowedExtensions: [
      'xlsx',
      // 'xls',
    ],
    allowMultiple: false,
  );
  print("${pickedFile!.files[0].path}");

  try {
    // var file = pickedFile.files[0].path;
    var file = pickedFile.files.single.path;
    var bytes = File(file.toString()).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      print(table); // sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print('==> $row <==');
        rows.add(row);
      }
    }
    csvListData(context, rows);
  } catch (e) {
    log(e.toString());
  }
}

pickCSVFile(context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['csv'],
    type: FileType.custom,
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    print("Picked");
    //
    try {
      final input = File(file.path).openRead();
      final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();

      print(fields.toString());
      log("Navigating");
      csvListData(context, fields);
    } catch (e) {
      log(e.toString());
      notifyUser(context, e.toString());
      log(e.runtimeType.toString());
    }
  } else {
    // User canceled the picker
    log("User canceled the pickup");
  }
}

void csvListData(context, csvData) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        Text(
          "Data",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: csvData.length,
              itemBuilder: (context, index) {
                List _data = csvData[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                          _data[index].toString(),
                        );
                      },
                    ),
                  ),
                );
              }),
        ),
        ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowCSVData(data: csvData),
              ),
            ).then((value) => log("Closed and back to previous page"));
          },
          child: const Text("Table view"),
        )
      ],
    ),
  );
}

class ShowCSVData extends StatefulWidget {
  final List<List> data;
  const ShowCSVData({super.key, required this.data});

  @override
  State<ShowCSVData> createState() => _ShowCSVDataState();
}

class _ShowCSVDataState extends State<ShowCSVData> {
  bool isLoading = true;

  @override
  void initState() {
    // log('Loaded');
    print("initState");
    setState(() => isLoading = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => isLoading = false);
      print("WidgetsBinding");
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => isLoading = false));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("SchedulerBinding");
      setState(() => isLoading = false);
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   print(widget.data.toString());
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const ShowLoading()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('Tabular view'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        border: TableBorder.all(width: 1.0),
                        children: widget.data.map((item) {
                          return TableRow(
                              children: item.map((row) {
                            return SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  row.toString(),
                                ),
                              ),
                            );
                          }).toList());
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
