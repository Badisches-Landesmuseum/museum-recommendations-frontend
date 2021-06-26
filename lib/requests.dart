import 'package:flutter/cupertino.dart';

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}
class _MainFetchDataState extends State<MainFetchData> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Fetch Data JSON"),
    ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: new Text("Fetch Data"),
        onPressed: () => null,
      ),
    ),
    body: Container(),
  );