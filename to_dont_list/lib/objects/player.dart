class Player {
  Player({required this.name, required this.number});

  final int number;
  final String name;
  // int ppg = 0;
  int gamesPlayed = 0;
  int gamesStarted = 0;
  int minutesPlayed = 0;

  int fga = 0;
  int fgm = 0;
  double avg = 0;

  int fta = 0;
  int ftm = 0;
  double ftAvg = 0;

  int threesA = 0;
  int threesM = 0;
  double threesAvg = 0;

  int dRebounds = 0;
  int oRebounds = 0;
  int totalRebounds = 0;

  int assists = 0;
  int steals = 0;

  double roundTwoDecimals(double d) {
    //d = 0.75876
    String inString = d.toStringAsFixed(3); // 0.75
    double inDouble = double.parse(inString);
    return inDouble;
  }

  void calculateAvg() {
    avg = (fgm / fga);
    avg = roundTwoDecimals(avg) * 100;
    ftAvg = (ftm / fta);
    ftAvg = roundTwoDecimals(ftAvg) * 100;
    threesAvg = (threesM / threesA);
    threesAvg = roundTwoDecimals(threesAvg) * 100;
    totalRebounds = dRebounds + oRebounds;
  }

  // void clearStats() {
  //   fga = 0;
  //   fgm = 0;
  //   fta = 0;
  //   ftm = 0;
  //   threesA = 0;
  //   threesM = 0;
  //   calculateAvg();
  // }
}
