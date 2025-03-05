import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  PropertyDetailsScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    final LatLng propertyLocation =
        LatLng(property.latitude, property.longitude);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(property.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: property.id,
              child: Image.network(
                property.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                property.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('${property.price} ريال',
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('${property.bedrooms} غرف',
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('الموقع: ${property.location}',
                  style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: propertyLocation,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(property.id),
                    position: propertyLocation,
                  ),
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (!authProvider.isLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("الاتصال بالمعلن...")),
                    );
                  }
                },
                child: Text('اتصل بالمعلن'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
