class LoanPoolList {
  final List<LoanPoolModel> loans;

  LoanPoolList({
    required this.loans,
  });

  factory LoanPoolList.fromJson(List<dynamic> parsedJson) {

    List<LoanPoolModel> loans = <LoanPoolModel>[];
    loans = parsedJson.map((i)=>LoanPoolModel.fromJson(i)).toList();

    return new LoanPoolList(
      loans: loans,
    );
  }
  isEmpty(){
    if(loans.isEmpty) return true;
    else return false;
  }
}

class LoanPoolModel{
  String loanId;
  num loanAmount;
  num loanFrequencyInDays;
  num loanInterestRate;
  num totalParticipants;

  LoanPoolModel({
    required this.loanId,
    required this.loanAmount,
    required this.loanFrequencyInDays,
    required this.loanInterestRate,
    required this.totalParticipants
  });

  factory LoanPoolModel.fromJson(Map<String, dynamic> json) {
    return LoanPoolModel(
      loanId: json['loanId'].toString(),
      loanAmount: json['loanAmount'],
      loanFrequencyInDays: json['loanFrequencyInDays'],
      loanInterestRate: json['loanInterestRate'],
      totalParticipants: json['totalParticipants'],
    );
  }
}
