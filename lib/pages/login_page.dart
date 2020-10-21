import 'package:flutter/material.dart';
import 'package:tool_organizer/services/database.dart';

class LoginPage extends StatefulWidget {
  final void Function(String, String) loginCallback;
  final Database db;

  LoginPage({this.loginCallback, this.db});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _errorText;

  @override
  void initState() {
    super.initState();
    _errorText = '';
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      if (_username != null) {
        Database.getUserFullName(_username).then((value) {
          if (value != null) {
            widget.loginCallback(_username, value);
          } else {
            setState(() {
              _errorText = 'That user does not exist';
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tool Organizer Login'),
      ),
      body: showForm(),
    );
  }

  Widget showForm() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showUsernameInput(),
            showPrimaryButton(),
            buildErrorText(),
          ],
        ),
      ),
    );
  }

  Widget showLogo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Icon(
            Icons.build,
            size: 100,
          ),
        ),
      ),
    );
  }

  Widget showUsernameInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        autofocus: false,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Username',
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Username is required';
          } else if (value.length > 20) {
            return 'Username must be less than 20 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => _username = value.trim(),
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
      child: SizedBox(
        height: 40,
        child: RaisedButton(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.indigo,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.grey[200]),
          ),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  Widget buildErrorText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Center(
        child: Text(
          _errorText,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
