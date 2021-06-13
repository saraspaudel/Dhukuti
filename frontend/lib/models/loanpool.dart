import 'package:cloud_firestore/cloud_firestore.dart';

class LoanPoolModel{
  String loanPoolId;
  num loanAmount;
  String loanFrequencyInDays;
  num interestRate;
  num poolParticipantsTotal;

  LoanPoolModel({
    this.loanPoolId,
    this.loanAmount,
    this.loanFrequencyInDays,
    this.interestRate,
    this.poolParticipantsTotal
  });

  LoanPoolModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){
    loanPoolId = documentSnapshot.id;
    loanAmount = documentSnapshot.get('loanAmount') as num;
    loanFrequencyInDays = documentSnapshot.get('loanFrequencyInDays');
    interestRate = documentSnapshot.get('interestRate') as num;
    poolParticipantsTotal = documentSnapshot.get('poolParticipantsTotal') as num;
  }
}