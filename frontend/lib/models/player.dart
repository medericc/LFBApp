class Player {
  final String name;
  final String forename;
  final int points;
  final int assists;
  final int rebonds;  // Changé de "rebounds"
  final int steals;
  final int blocks;
  final int evaluation;
  final int threePoints;  // Changé de "three_points"
  final int lancers;
  final int teamId;

  Player({
    required this.name,
    required this.forename,
    required this.points,
    required this.assists,
    required this.rebonds,  // Adapté
    required this.steals,
    required this.blocks,
    required this.evaluation,
    required this.threePoints,  // Adapté
    required this.lancers,
    required this.teamId,
  });

factory Player.fromJson(Map<String, dynamic> json) {
  print('Parsing JSON: $json'); // Ajoute cette ligne pour déboguer

  return Player(
    name: json['name'] ?? '',
    forename: json['forename'] ?? '',
    points: json['points'] is int ? json['points'] : 0,
    assists: json['assists'] is int ? json['assists'] : 0,
    rebonds: json['rebonds'] is int ? json['rebonds'] : 0,
    steals: json['steals'] is int ? json['steals'] : 0,
    blocks: json['blocks'] is int ? json['blocks'] : 0,
    evaluation: json['evaluation'] is int ? json['evaluation'] : 0,
    threePoints: json['three_points'] is int ? json['three_points'] : 0,
    lancers: json['lancers'] is int ? json['lancers'] : 0,
    teamId: json['team_id'] is int ? json['team_id'] : 0,
  );
}


}
