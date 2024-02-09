import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.download) ,label: Text('Loading...')),
    //   ),
    // );
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
