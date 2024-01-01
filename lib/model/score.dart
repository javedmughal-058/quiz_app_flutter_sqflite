class Score {
  int? id;
  String nameUser;
  String categories;
  int score;
  String date;
  int totalAnswer;
  int totalQuestion;

  // Constructor
  Score({
    this.id,
    required this.nameUser,
    required this.categories,
    required this.score,
    required this.date,
    required this.totalAnswer,
    required this.totalQuestion,
  });

  // Factory method to create a Score instance from a Map
  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'],
      nameUser: json['nameUser'],
      categories: json['categories'],
      score: json['score'],
      date: json['date'],
      totalAnswer: json['totalAnswer'],
      totalQuestion: json['totalQuestion'],
    );
  }

  // Method to convert the Score instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'nameUser': nameUser,
      'categories': categories,
      'score': score,
      'date': date,
      'totalAnswer': totalAnswer,
      'totalQuestion': totalQuestion,
    };
  }
}
