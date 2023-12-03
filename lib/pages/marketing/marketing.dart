import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pos/pages/marketing/marketing_c.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class Marketing extends GetWidget<MarketingController> {
  static const String path = '/marketing';
  Marketing({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        //   length: 2,
        //   child: Scaffold(
        //     appBar: AppBar(
        //       bottom: TabBar(
        //         tabs: [
        //           Tab(icon: Icon(Icons.flight)),
        //           Tab(icon: Icon(Icons.directions_transit)),
        //         ],
        //       ),
        //       title: Text('Tabs Demo'),
        //     ),
        //     body: TabBarView(
        //       children: [
        //         Icon(Icons.flight, size: 350),
        //         Icon(Icons.directions_transit, size: 350),
        //       ],
        //     ),
        //   ),
        // );

        SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          // appBar: AppBar(
          //   bottom: const
          //   title: const Text("Marketing"),
          // ),
          appBar: TabBar(
            // indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,

            tabs: const [
              Tab(
                icon: Icon(Icons.mark_email_read_outlined),
                text: "Marketing",
              ),
              Tab(
                icon: Icon(Icons.perm_phone_msg_outlined),
                text: "Promotion",
              ),
            ],
          ),
          // body: Center(
          //   child: Text(
          //     "Marketing",
          //     style: Theme.of(context).textTheme.displayMedium,
          //   ),
          // ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Message",
                        ),
                        onChanged: (val) {
                          controller.textMessage.value = val;
                        },
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => controller.textMessage.trim() != ''
                          ? controller.share()
                          : Snackbar.trigger("No message", "No text to share or wrong format"),
                      icon: const Icon(Icons.send),
                      label: const Text("Send/Share"),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     // physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 19,
                    //     itemBuilder: (context, index) {
                    //       return const Card(
                    //         child: SizedBox(
                    //           // height: 80,
                    //           // width: 80,
                    //           child: Center(
                    //             child: Text("POSTER"),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Card(
                        elevation: 0.5,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Hot Posters'),
                        ),
                      ),
                    ),
                    // horizontal listview for templates
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 13,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          String _asset = 'assets/${(index + 1)}.jpg';
                          return Card(
                            // margin: EdgeInsets.all(15),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Image(image: AssetImage(_asset), fit: BoxFit.fill),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OutlinedButton.icon(
                                        icon: const Icon(Icons.save_alt),
                                        onPressed: () => controller.saveAssetImageToDevice(index),
                                        // onPressed: () async {
                                        //   controller.saveAssetImageToDevice(index);
                                        // },
                                        label: const Text("Save"),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () => controller.shareAssetImage(_asset),
                                        icon: const Icon(Icons.share),
                                        label: const Text("Share"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 200,
                    //   child: FutureBuilder(
                    //     // initialData: controller.getImageFileFromAssets("assets/4.jpg"),
                    //     future: controller.getImageFileFromAssets("assets/1.jpg"),
                    //     builder: (context, snapshot) {
                    //       return Image(image: FileImage(snapshot.data!));
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SingleChildScrollView(
                child: Column(
                  children: [
                    Text("data"),
                    Text("data"),
                    Text("data"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
