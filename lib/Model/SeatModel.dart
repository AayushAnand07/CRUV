class SeatData {
  final int seatNo;
  final List<Reservation> reservations;

  SeatData({
    required this.seatNo,
    required this.reservations,
  });

  factory SeatData.fromJson(Map<String, dynamic> json) {
    return SeatData(
      seatNo: json['seatNo'],
      reservations: (json['reservations'] as List)
          .map((reservation) => Reservation.fromJson(reservation))
          .toList(),
    );
  }
}

class Reservation {
  final String from;
  final String to;

  Reservation({
    required this.from,
    required this.to,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      from: json['from'],
      to: json['to'],
    );
  }
}
