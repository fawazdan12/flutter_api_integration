import 'package:bloc/data/models/apprenant_model.dart';

class UserModel {
  final int id;
  final String nom;
  final String prenom;
  final String sexe;
  final String numerotel;
  final String dateNaissance;
  final String email;
  final String dateInscription;
  final String role;
  final String type;
  final String updatedAt;
  final String createdAt;
  final ApprenantModel? apprenant;

  UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.numerotel,
    required this.dateNaissance,
    required this.email,
    required this.dateInscription,
    required this.role,
    required this.type,
    required this.updatedAt,
    required this.createdAt,
    this.apprenant,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      sexe: json['sexe'],
      numerotel: json['numerotel'],
      dateNaissance: json['dateNaissance'],
      email: json['email'],
      dateInscription: json['dateInscription'],
      role: json['role'],
      type: json['type'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      apprenant: json['apprenant'] != null
          ? ApprenantModel.fromJson(json['apprenant'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'numerotel': numerotel,
      'dateNaissance': dateNaissance,
      'email': email,
      'dateInscription': dateInscription,
      'role': role,
      'type': type,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'apprenant': apprenant?.toJson(),
    };
  }
}
