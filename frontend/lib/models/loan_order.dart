// To parse this JSON data, do
//
//     final loanOrder = loanOrderFromJson(jsonString);

import 'dart:convert';

List<LoanOrder> loanOrderFromJson(String str) => List<LoanOrder>.from(json.decode(str).map((x) => LoanOrder.fromJson(x)));

String loanOrderToJson(List<LoanOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanOrder {
  LoanOrder({
    required this.loanOrderId,
    required this.userId,
    required this.loanId,
    required this.turn,
    required this.interestRate,
  });

  int loanOrderId;
  dynamic userId;
  int loanId;
  int turn;
  double interestRate;

  factory LoanOrder.fromJson(Map<String, dynamic> json) => LoanOrder(
    loanOrderId: json["loanOrderId"],
    userId: json["userId"],
    loanId: json["loanId"],
    turn: json["turn"],
    interestRate: json["interestRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "loanOrderId": loanOrderId,
    "userId": userId,
    "loanId": loanId,
    "turn": turn,
    "interestRate": interestRate,
  };
}

class LoanOrderList {
  final List<LoanOrder> loans;

  LoanOrderList({
    required this.loans,
  });

  factory LoanOrderList.fromJson(List<dynamic> parsedJson) {

    List<LoanOrder> loans = <LoanOrder>[];
    loans = parsedJson.map((i)=>LoanOrder.fromJson(i)).toList();

    return new LoanOrderList(
      loans: loans,
    );
  }
  isEmpty(){
    if(loans.isEmpty) return true;
    else return false;
  }
}