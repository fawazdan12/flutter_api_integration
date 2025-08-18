class ApprenantModel {
  final int id;
  final int utilisateurId;
  final int niveau;
  final dynamic recompenses; // peut être null
  final int points;
  final String createdAt;
  final String updatedAt;

  ApprenantModel({
    required this.id,
    required this.utilisateurId,
    required this.niveau,
    this.recompenses,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApprenantModel.fromJson(Map<String, dynamic> json) {
    return ApprenantModel(
      id: json['id'],
      utilisateurId: json['utilisateur_id'],
      niveau: json['niveau'],
      recompenses: json['recompenses'],
      points: json['points'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'utilisateur_id': utilisateurId,
      'niveau': niveau,
      'recompenses': recompenses,
      'points': points,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}