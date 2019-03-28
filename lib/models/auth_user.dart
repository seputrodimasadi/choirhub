import "package:flutter/material.dart";

class AuthUser {
  final String token;
  final int id;
  final String email;
  final String name;
  final String photoUrl;
  final int currentTeamId;
  final String currentTeamName;
//  final String current_team_name;

  AuthUser({
    @required  this.id,
    @required  this.email,
    @required  this.name,
    @required  this.token,
    @required  this.photoUrl,
    @required  this.currentTeamId,
    @required  this.currentTeamName,
  });
//    @required  this.current_team_name,
}