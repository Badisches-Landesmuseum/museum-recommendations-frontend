/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:flutter/material.dart';
import 'package:frontend/requests.dart';
import 'package:frontend/qr.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class MuseumObjectDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MuseumObjectDisplayState();
}

class _MuseumObjectDisplayState extends State<MuseumObjectDisplay>{
  late Future<MuseumObject> futureObject;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<MuseumObject>(
          future: futureObject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column (
                  children: <Widget> [
                    RichText(
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: "Object Info: \n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                              TextSpan(text: 'Title: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: snapshot.data!.title + "\n"),
                              TextSpan(text: "Inventory Number: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: snapshot.data!.inventoryNum + "\n"),
                            ]
                        )
                    ),
                    snapshot.data!.image!,
                  ]
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },

        )
    );
  }

  @override
  void initState() {
    futureObject = fetchMuseumObject();
    super.initState();
  }

}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MuseumObjectDisplay()
        ],
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
