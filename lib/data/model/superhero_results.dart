class SuperheroDetailResponse {
  final String id;
  final String name;
  final String realName;
  final String? affiliation;
  final Map<String, dynamic> powerstats;

  SuperheroDetailResponse({
    required this.id,
    required this.name,
    required this.realName,
    required this.affiliation,
    required this.powerstats,
  });

  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailResponse(
      id: json["id"],
      name: json["name"],
      realName: json["biography"]["full-name"],
      affiliation: json["connections"]["group-affiliation"],
      powerstats: json["powerstats"],
    );
  }
}
