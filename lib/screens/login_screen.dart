import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userType = 'مستأجر';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تسجيل الدخول")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                    bool success =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .login(email, password, userType);
                    setState(() {
                      isLoading = false;
                    });
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("فشل تسجيل الدخول")),
                      );
                    }
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("تسجيل الدخول"),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text("ليس لديك حساب؟ سجل الآن"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
