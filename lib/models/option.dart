class Option {
  String title;
  String type;
  String current;
  List<String> optionTiles;

  Option(String _title, String _type, String _current, List<String> _optionTiles) {
    this.title = _title;
    this.type = _type;
    this.current = _current;
    this.optionTiles = _optionTiles;
  }
}