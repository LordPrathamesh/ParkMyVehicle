import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AreaSelectorScreen extends StatefulWidget {
  final int cityId;
  const AreaSelectorScreen({super.key, required this.cityId});

  @override
  State<AreaSelectorScreen> createState() => _AreaSelectorScreenState();
}

class _AreaSelectorScreenState extends State<AreaSelectorScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var data = [
    {
      "latitude": 0,
      "id": 1,
      "name": "Marol-Times Square",
      "is_active": true,
      "city_id": 1,
      "longitude": 0
    },
    {
      "latitude": 0,
      "id": 2,
      "name": "Mulund-Hiramongi",
      "is_active": true,
      "city_id": 1,
      "longitude": 0
    },
    {
      "latitude": 0,
      "id": 3,
      "name": "Shivajinagar-Heritage Apt",
      "is_active": true,
      "city_id": 2,
      "longitude": 0
    }
  ];

  Iterable<Map<String, Object>> areas = [];

  getData() {
    setState(() {
      areas = data.where((element) => element["city_id"] == widget.cityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text("Location Selector Screen2 :: ${areas}"),
        ),
      ),
    );
  }
}
