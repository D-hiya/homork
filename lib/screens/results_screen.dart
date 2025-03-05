import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../providers/property_provider.dart';
import '../widgets/property_card.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> filters;

  ResultsScreen({required this.filters});

  List<Property> getFilteredProperties(List<Property> properties) {
    return properties.where((property) {
      bool matchesLocation = property.location.contains(filters['location']);
      bool matchesPrice = property.price <= filters['price'];
      bool matchesBedrooms = property.bedrooms == filters['bedrooms'];
      return matchesLocation && matchesPrice && matchesBedrooms;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);
    List<Property> filteredProperties =
        getFilteredProperties(propertyProvider.properties);

    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج البحث'),
      ),
      body: filteredProperties.isEmpty
          ? Center(child: Text("لا توجد عقارات مطابقة للفلتر"))
          : ListView.builder(
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                return PropertyCard(property: filteredProperties[index]);
              },
            ),
    );
  }
}
