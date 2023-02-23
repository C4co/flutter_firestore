import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart' show Faker;
import 'package:flutter/material.dart';
import '/domain/domain.dart';

class PersonRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Faker faker = Faker();

  Future<void> addPerson() {
    final id = UniqueKey().hashCode.toString();

    final name = faker.person.name();

    var person = Person(
      id: id,
      name: name,
      email: faker.internet.email(),
      image:
          'https://ui-avatars.com/api/?name=$name&background=2C75F4&color=fff',
    );

    return _db.collection("people").doc(id).set(person.toJson());
  }
}
