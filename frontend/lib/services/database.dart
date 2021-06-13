import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/models/loanpool.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<LoanPoolModel>> streamTodos({String uid}) {
    try {
      return firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .snapshots()
          .map((query) {
        final List<LoanPoolModel> retVal = <LoanPoolModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(LoanPoolModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo({String uid, num loanAmount, String loanFrequencyInDays, num interestRate, poolParticipantsTotal}) async {
    try {
      firestore.collection("todos").doc(uid).collection("todos").add({
        "loanAmount": loanAmount,
        "loanFrequencyInDays": loanFrequencyInDays,
        "interestRate": interestRate,
        "poolParticipantsTotal": poolParticipantsTotal
      });
    } catch (e) {
      rethrow;
    }
  }
}