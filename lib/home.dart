import 'package:flutter/material.dart';
import 'dart:async';
import 'contact.dart';
import 'crud.dart';
import 'entryform.dart';
//pendukung program asinkron

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  int count = 0;
  Future<List<Contact>> future;

  @override
  void initState() {
    super.initState();
    future = dbHelper.getContactList();
  }

  void addContact(Contact object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editContact(Contact object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteContact(Contact object) async {
    int result = await dbHelper.delete(object);
    if (result > 0) {
      updateListView();
    }
  }

  Card cardo(Contact contact) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.people),
        ),
        title: Text(
          contact.name,
        ),
        subtitle: Text(contact.phone.toString()),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () {
            deleteContact(contact);
          },
        ),
        onTap: () async {
          var contact2 = await navigateToEntryForm(context, contact);
          if (contact2 != null) editContact(contact2);
        },
      ),
    );
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getContactList();
    });
  }

  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data-Data'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.map((todo) => cardo(todo)).toList());
          } else {
            return SizedBox();
          }
        },
      ),
      //createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) addContact(contact);
        },
      ),
    );
  }
}
