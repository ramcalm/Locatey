import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locatey/models/place.dart';
import 'package:locatey/screens/search.dart';
import 'package:locatey/services/geolocator_service.dart';
import 'package:locatey/services/places_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/locate': (context) => MyApp2(),
      },
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lime[50],
        appBar: AppBar(
          title: Text('Locatey'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(
              child: new Image.network('https://i.ibb.co/t3hz3jF/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                child: Text(
                    'New to your Locality?\nWanna know your way around?\nWe got you covered with\njust a click!',
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 25.0,
                    )),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DropdownExample(),
                    RaisedButton(
                      child: Text('Locate'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/locate');
                      },
                    ),
                  ],
                )),
            Container(),
          ],
        )
/*      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownExample(),
          RaisedButton(
            child: Text('Locate'),
            onPressed: () {
              Navigator.pushNamed(context, '/locate');
            },
          ),
        ],
      )), */
        );
  }
}

class MyApp2 extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Locatey',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Locatey'),
            backgroundColor: Colors.green,
          ),
          body: Search(),
        ),
      ),
    );
  }
}

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() {
    return _DropdownExampleState();
  }
}

class _DropdownExampleState extends State<DropdownExample> {
  String _value = 'one';
  var details = {
    'one': 'atm',
    'two': 'bakery',
    'three': 'bank',
    'four': 'beauty_salon',
    'five': 'bus_station',
    'six': 'cafe',
    'seven': 'car_repair',
    'eight': 'church',
    'nine': 'department_store',
    'ten': 'electronics_store',
    'eleven': 'gas_station',
    'twelve': 'hindu_temple',
    'thirteen': 'hospital',
    'fourteen': 'mosque',
    'fifteen': 'movie_theater',
    'sixteen': 'park',
    'seventeen': 'parking',
    'eighteen': 'pharmacy',
    'nineteen': 'police',
    'twenty': 'post_office',
    'twentyone': 'restaurant',
    'twentytwo': 'school',
    'twentythree': 'shopping_mall',
    'twentyfour': 'supermarket',
    'twentyfive': 'taxi_stand',
  };
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            child: Text('ATM'),
            value: 'one',
          ),
          DropdownMenuItem<String>(
            child: Text('Bakery'),
            value: 'two',
          ),
          DropdownMenuItem<String>(
            child: Text('Bank'),
            value: 'three',
          ),
          DropdownMenuItem<String>(
            child: Text('Beauty Salon'),
            value: 'four',
          ),
          DropdownMenuItem<String>(
            child: Text('Bus Station'),
            value: 'five',
          ),
          DropdownMenuItem<String>(
            child: Text('Cafe'),
            value: 'six',
          ),
          DropdownMenuItem<String>(
            child: Text('Car Repair'),
            value: 'seven',
          ),
          DropdownMenuItem<String>(
            child: Text('Church'),
            value: 'eight',
          ),
          DropdownMenuItem<String>(
            child: Text('Department Store'),
            value: 'nine',
          ),
          DropdownMenuItem<String>(
            child: Text('Electronics Store'),
            value: 'ten',
          ),
          DropdownMenuItem<String>(
            child: Text('Gas Station'),
            value: 'eleven',
          ),
          DropdownMenuItem<String>(
            child: Text('Hindu Temple'),
            value: 'twelve',
          ),
          DropdownMenuItem<String>(
            child: Text('Hospital'),
            value: 'thirteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Mosque'),
            value: 'fourteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Movie Theatre'),
            value: 'fifteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Park'),
            value: 'sixteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Parking Lot'),
            value: 'seventeen',
          ),
          DropdownMenuItem<String>(
            child: Text('Pharmacy'),
            value: 'eighteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Police Station'),
            value: 'nineteen',
          ),
          DropdownMenuItem<String>(
            child: Text('Post Office'),
            value: 'twenty',
          ),
          DropdownMenuItem<String>(
            child: Text('Restaurant'),
            value: 'twentyone',
          ),
          DropdownMenuItem<String>(
            child: Text('School'),
            value: 'twentytwo',
          ),
          DropdownMenuItem<String>(
            child: Text('Shopping Mall'),
            value: 'twentythree',
          ),
          DropdownMenuItem<String>(
            child: Text('Super Market'),
            value: 'twentyfour',
          ),
          DropdownMenuItem<String>(
            child: Text('Taxi Stand'),
            value: 'twentyfive',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
            PlacesService.place = details[value];
          });
        },
        hint: Text('Airport'),
        value: _value,
      ),
    );
  }
}
