String padDateTimeWithZero(String time) {
  if (time.isEmpty) return '';
  return time.length == 1 ? '0$time' : time;
}