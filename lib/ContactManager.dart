import 'dart:async';

import 'package:emailapp/Model/Contact.dart';
import 'package:emailapp/Service/ContactService.dart';
import 'package:rxdart/rxdart.dart';


class ContactManager {
  final BehaviorSubject<int> _counterContact = BehaviorSubject<int>();
  Stream<int> get contactCounter => _counterContact.stream;
  
  
  Stream<List<Contact>> get contactsListView =>
   Stream.fromFuture(ContactService.browse());
  
  Stream<List<Contact>> filteredCollection({query}) =>
   Stream.fromFuture(ContactService.browse(query: query));

  ContactManager () {
    contactsListView.listen((list) => _counterContact.add(list.length));
  }
  
}