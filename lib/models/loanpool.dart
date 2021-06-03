import 'package:cloud_firestore/cloud_firestore.dart';

class LoanPoolModel{
  String loanPoolId;
  num loanAmount;
  num loanDurationInDays;
  num loanFrequencyInDays;
  num interestRate;
  num poolParticipantsTotal;

  LoanPoolModel({
    this.loanPoolId,
    this.loanAmount,
    this.loanDurationInDays,
    this.loanFrequencyInDays,
    this.interestRate,
    this.poolParticipantsTotal
  });

  LoanPoolModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){
    loanPoolId = documentSnapshot.id;
    loanAmount = documentSnapshot.get('loanAmount') as num;
    loanDurationInDays = documentSnapshot.get('loanDurationInDays') as num;
    loanFrequencyInDays = documentSnapshot.get('loanFrequencyInDays') as num;
    interestRate = documentSnapshot.get('interestRate') as num;
    poolParticipantsTotal = documentSnapshot.get('poolParticipantsTotal') as num;
  }
}