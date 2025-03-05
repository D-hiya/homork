import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import '../models/property.dart';
import '../providers/property_provider.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newProperty = Property(
        id: Uuid().v4(),
        title: _titleController.text,
        imageUrl: _imageUrlController.text.isEmpty
            ? 'https://via.placeholder.com/400'
            : _imageUrlController.text,
        price: double.parse(_priceController.text),
        bedrooms: int.parse(_bedroomsController.text),
        location: _locationController.text,
        latitude: _latitudeController.text.isNotEmpty
            ? double.parse(_latitudeController.text)
            : 24.7136,
        longitude: _longitudeController.text.isNotEmpty
            ? double.parse(_longitudeController.text)
            : 46.6753,
      );
      Provider.of<PropertyProvider>(context, listen: false)
          .addProperty(newProperty);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة عقار جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'عنوان العقار'),
                validator: (value) => value == null || value.isEmpty
                    ? 'الرجاء إدخال العنوان'
                    : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'أدخل سعر صحيح'
                        : null,
              ),
              TextFormField(
                controller: _bedroomsController,
                decoration: InputDecoration(labelText: 'عدد الغرف'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                        ? 'أدخل عدد غرف صحيح'
                        : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'الموقع'),
                validator: (value) => value == null || value.isEmpty
                    ? 'الرجاء إدخال الموقع'
                    : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'رابط الصورة (اختياري)'),
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'خط العرض (اختياري)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'خط الطول (اختياري)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('أضف العقار'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
