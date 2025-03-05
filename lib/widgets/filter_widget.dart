import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  FilterWidget({required this.onApplyFilters});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedLocation = 'الرياض';
  double selectedPrice = 5000;
  int selectedBedrooms = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر الموقع:', style: TextStyle(fontSize: 16)),
        DropdownButton<String>(
          value: selectedLocation,
          items: ['الرياض', 'جدة', 'الدمام']
              .map((location) => DropdownMenuItem(
                    child: Text(location),
                    value: location,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedLocation = value!;
            });
          },
        ),
        SizedBox(height: 10),
        Text('اختر الحد الأقصى للسعر:', style: TextStyle(fontSize: 16)),
        Slider(
          min: 1000,
          max: 20000,
          divisions: 19,
          value: selectedPrice,
          label: '${selectedPrice.round()} ريال',
          onChanged: (value) {
            setState(() {
              selectedPrice = value;
            });
          },
        ),
        SizedBox(height: 10),
        Text('اختر عدد الغرف:', style: TextStyle(fontSize: 16)),
        Row(
          children: [
            Radio<int>(
              value: 2,
              groupValue: selectedBedrooms,
              onChanged: (value) {
                setState(() {
                  selectedBedrooms = value!;
                });
              },
            ),
            Text('2'),
            Radio<int>(
              value: 3,
              groupValue: selectedBedrooms,
              onChanged: (value) {
                setState(() {
                  selectedBedrooms = value!;
                });
              },
            ),
            Text('3'),
            Radio<int>(
              value: 4,
              groupValue: selectedBedrooms,
              onChanged: (value) {
                setState(() {
                  selectedBedrooms = value!;
                });
              },
            ),
            Text('4'),
          ],
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              widget.onApplyFilters({
                'location': selectedLocation,
                'price': selectedPrice,
                'bedrooms': selectedBedrooms,
              });
            },
            child: Text('تطبيق الفلاتر'),
          ),
        ),
      ],
    );
  }
}
