class Option {
  String title;
  String type;
  String current;
  List<String> optionTiles;

  Option(String _title, String _type, String _current) {
    this.title = _title;
    this.type = _type;
    this.current = _current;
    this.optionTiles = new List<String>();
  }
}