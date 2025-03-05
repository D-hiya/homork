import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String password = '';
  String phone = '';
  String userType = 'مستأجر';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إنشاء حساب")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "الاسم الكامل"),
                  validator: (value) => value == null || value.isEmpty
                      ? "الرجاء إدخال الاسم الكامل"
                      : null,
                  onSaved: (value) => fullName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "البريد الإلكتروني"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty
                      ? "الرجاء إدخال البريد الإلكتروني"
                      : null,
                  onSaved: (value) => email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "كلمة المرور"),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? "الرجاء إدخال كلمة المرور"
                      : null,
                  onSaved: (value) => password = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "رقم الهاتف"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty
                      ? "الرجاء إدخال رقم الهاتف"
                      : null,
                  onSaved: (value) => phone = value!,
                ),
                SizedBox(height: 16),
                Text("نوع المستخدم", style: TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'مستأجر',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    Text("مستأجر"),
                    Radio<String>(
                      value: 'مؤجر',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    Text("مؤجر"),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      bool success = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .register(fullName, email, password, phone, userType);
                      setState(() {
                        isLoading = false;
                      });
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("فشل إنشاء الحساب")),
                        );
                      }
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("إنشاء حساب"),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("لديك حساب؟ سجل الدخول"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
