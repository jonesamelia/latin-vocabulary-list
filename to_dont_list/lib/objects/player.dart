class Player {
  Player({required this.name, required this.number});

  final int number;
  final String name;
  // int ppg = 0;
  int fga = 0;
  int fgm = 0;
  double avg = 0;

  void calculateAvg() {
    avg = fga / fgm;
  }

  void updateStats(int fga, int fgm) {
    this.fga += fga;
    this.fgm += fgm;
  }

  void clearStats() {
    fga = 0;
    fgm = 0;
    avg = 0;
  }
}