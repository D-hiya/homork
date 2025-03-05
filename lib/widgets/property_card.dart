import 'package:flutter/material.dart';
import '../models/property.dart';
import '../screens/property_details_screen.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: ListTile(
        leading: Hero(
          tag: property.id,
          child: Image.network(
            property.imageUrl,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(property.title),
        subtitle: Text('${property.price} ريال - ${property.bedrooms} غرف'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PropertyDetailsScreen(property: property)),
          );
        },
      ),
    );
  }
}
