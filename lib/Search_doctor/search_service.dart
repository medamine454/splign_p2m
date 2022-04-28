import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    /*   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Username', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
    print(querySnapshot.docs);*/
    return FirebaseFirestore.instance
        .collection('users')
        .where("role", isEqualTo: 'doctor')
        .where("searchKey",
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
