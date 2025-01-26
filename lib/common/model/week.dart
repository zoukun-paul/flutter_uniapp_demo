
enum Weekday implements Comparable<Weekday>{

  monday(DateTime.monday),

  tuesday(DateTime.tuesday),

  wednesday(DateTime.wednesday),

  thursday(DateTime.thursday),

  friday(DateTime.friday),

  saturday(DateTime.saturday),

  sunday(DateTime.sunday),
  ;

  final int idx;

  const Weekday(this.idx);

  static Weekday? of(int week){
    for(var it in Weekday.values){
      if (it.idx == week) {
        return it;
      }
    }
    return null;
  }

   Weekday now()=> Weekday.of(DateTime.now().weekday)!;

  @override
  int compareTo(Weekday other) => idx - other.idx;

}
