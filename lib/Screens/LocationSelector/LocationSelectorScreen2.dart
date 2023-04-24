import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AreaSelectorScreen extends StatefulWidget {
  const AreaSelectorScreen({super.key});

  @override
  State<AreaSelectorScreen> createState() => _AreaSelectorScreenState();
}

class _AreaSelectorScreenState extends State<AreaSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        
      ),
      body: const Center(
        child: Text("Location Selector Screen2"),
      ),
    );
  }
}
