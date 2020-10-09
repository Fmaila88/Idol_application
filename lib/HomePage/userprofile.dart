import 'dart:ffi';

class UserProfile {
  String id;
  String profileId;

  UserProfile({
   this.id,
   this.profileId,
});

  factory UserProfile.fromJson(Map<String,dynamic> json){

    return UserProfile(

      profileId: json['profilePicture']['id'] as String,
      id:        json['profilePicture']['id'] as String,
    );
  }
}