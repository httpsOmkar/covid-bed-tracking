class Hospital {
  final String title;
  final int availableBedsNormal;
  final int availableBedsICU;
  final String objectID;
  final String location;
  final double latitude;
  final double longitude;
  final String url;
  final List<int> contactNumber;

  Hospital({
    this.title,
    this.objectID,
    this.availableBedsICU,
    this.availableBedsNormal,
    this.location,
    this.latitude,
    this.longitude,
    this.url,
    this.contactNumber,
  });

  factory Hospital.fromJSON(Map<String, dynamic> json) {
    return Hospital(
      title: json['title'],
      objectID: json['objectID'],
      availableBedsICU: json['availableBedsICU'],
      availableBedsNormal: json['availableBedsNormal'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      url: json['url'],
      contactNumber:
          json['contactNumber'].map<int>((res) => res as int).toList(),
    );
  }
}
