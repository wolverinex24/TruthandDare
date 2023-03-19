class customUserDare {
  String? dare;

  customUserDare({
    required this.dare,
  });

  static List<customUserDare> _userDarelist() {
    return [customUserDare(dare: "sing in helium voice")];
  }
}
