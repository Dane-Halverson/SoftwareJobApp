

class Index {

  int get index  {
    return index;
  }
  set index(int i) {
    index = i;
  }


  @override
  bool operator ==(Object other) {
    return index == other;
  }

}