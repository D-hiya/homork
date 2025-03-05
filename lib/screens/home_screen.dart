import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/property_provider.dart';
import '../widgets/property_card.dart';
import 'login_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'add_property_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool)? onThemeChanged;
  final bool? isDarkMode;

  HomeScreen({this.onThemeChanged, this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('البحث عن المنازل للإيجار'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          Switch(
            value: isDarkMode ?? false,
            onChanged: onThemeChanged,
          ),
          if (authProvider.isLoggedIn)
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Text(
                  authProvider.fullName != null &&
                          authProvider.fullName!.isNotEmpty
                      ? authProvider.fullName!.substring(0, 1)
                      : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("بيانات المستخدم"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الاسم: ${authProvider.fullName ?? ''}"),
                        Text("البريد: ${authProvider.email ?? ''}"),
                        Text("رقم الهاتف: ${authProvider.phone ?? ''}"),
                        Text("نوع المستخدم: ${authProvider.userType ?? ''}"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("إغلاق"),
                      ),
                    ],
                  ),
                );
              },
            ),
          if (authProvider.isLoggedIn)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authProvider.logout();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("تم تسجيل الخروج")));
              },
            ),
        ],
      ),
      body: propertyProvider.properties.isEmpty
          ? Center(child: Text("لا توجد عقارات"))
          : ListView.builder(
              itemCount: propertyProvider.properties.length,
              itemBuilder: (context, index) {
                return PropertyCard(
                    property: propertyProvider.properties[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (!authProvider.isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPropertyScreen()),
            );
          }
        },
      ),
    );
  }
}
