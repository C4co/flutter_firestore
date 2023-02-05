import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart' show Faker, random;
import '/domain/domain.dart';

class SchoolRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Faker faker = Faker();

  Future<DocumentReference> addSchool() {
    var address = Address(
      streetName: faker.address.streetName(),
      city: faker.address.city(),
      district: faker.address.neighborhood(),
      cep:
          '${random.integer(1000)}-${random.integer(1000)}.${random.integer(1000)}',
      number: '${random.integer(1000)}',
    );

    var school = School(
      name: 'School: ${faker.person.name()}',
      address: address,
    );

    return _db.collection("schools").add(school.toJson());
  }
}
