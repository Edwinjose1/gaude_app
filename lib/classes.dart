class BranchResponse {
  final String id;
  final String branchName;
  final String branchCreateDate;
  final String branchUpdateDate;

  BranchResponse({
    required this.id,
    required this.branchName,
    required this.branchCreateDate,
    required this.branchUpdateDate,
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      id: json['id'],
      branchName: json['branchName'],
      branchCreateDate: json['branchCreateDate'],
      branchUpdateDate: json['branchUpdateDate'],
    );
  }
}
