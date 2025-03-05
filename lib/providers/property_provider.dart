import 'package:flutter/material.dart';
import '../models/property.dart';
import '../helpers/db_helper.dart';

class PropertyProvider with ChangeNotifier {
  List<Property> _properties = [];

  List<Property> get properties => _properties;

  Future<void> fetchProperties() async {
    _properties = await DBHelper().getProperties();
    notifyListeners();
  }

  Future<void> addProperty(Property property) async {
    await DBHelper().insertProperty(property);
    _properties.add(property);
    notifyListeners();
  }

  Future<void> deleteProperty(String id) async {
    await DBHelper().deleteProperty(id);
    _properties.removeWhere((prop) => prop.id == id);
    notifyListeners();
  }
}
