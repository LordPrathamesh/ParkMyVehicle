import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkmyvehicle/Screens/LocationSelector/LocationSelectorScreen2.dart';

import '../../Widgets/index.dart';

class LocationSelectorScreen extends StatefulWidget {
  const LocationSelectorScreen({super.key});

  @override
  State<LocationSelectorScreen> createState() => _LocationSelectorScreenState();
}

class _LocationSelectorScreenState extends State<LocationSelectorScreen> {
  var data = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    debugPrint("===getData===");
    await Future.delayed(const Duration(milliseconds: 5000));

    setState(() {
      data = [
        {
          "cities": [
            {"cityname": "Mumbai", "cityid": 1},
            {"cityname": "Pune", "cityid": 2}
          ],
          "stateid": 1,
          "statename": "Maharashtra"
        },
        {
          "cities": [
            {"cityname": "Kochi", "cityid": 6}
          ],
          "stateid": 2,
          "statename": "Kerala"
        }
      ];
      isLoading = false;
    });
  }

  _buildExpandableContent(Map<String, Object> data) {
    List<Widget> columnContent = [];
    List<Map<String, Object>> innerdataList =
        (data["cities"] as List<Map<String, Object>>?) ??
            <Map<String, Object>>[];
    for (Map<String, Object> content in innerdataList) {
      columnContent.add(
        ListTile(
          title: Text(
            content["cityname"].toString(),
            style: const TextStyle(fontSize: 18.0),
          ),
          leading: const Icon(Icons.location_city),
          trailing: IconButton(
              onPressed: () {
                debugPrint(content["cityid"].toString());
                // convertToInt(content["cityid"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AreaSelectorScreen(
                          cityId: int.parse(content["cityid"].toString()))),
                );
                // debugPrint("After :: ${content["cityid"]}");
              },
              icon: const Icon(Icons.arrow_circle_right_outlined)),
        ),
      );
    }
    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Location"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const ColorfulProgressIndicator(time: 5000)
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.map_outlined),
                          const SizedBox(width: 25),
                          Text(
                            data[i]["statename"].toString(),
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                      children: <Widget>[
                        Column(
                          children: _buildExpandableContent(data[i]),
                        ),
                      ],
                    );
                  }),
        )
            // Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   const Text("Location Selector Screen1"),
            // const SizedBox(height: 25,),
            // ExpansionTile(
            //   title: const Text('List-A'),
            //   children: _getChildren(4, 'A-'),
            // ),
            // ExpansionTile(
            //   title: const Text('List-B'),
            //   children: _getChildren(3, 'B-'),
            // ),

            // IconButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const AreaSelectorScreen()),
            //     );
            //   },
            //   icon: const Icon(Icons.navigate_next),
            // )
            // ]),
            ),
      ),
    );
  }
}
