/////////////////////////////////////////////
/// 文件： time_utils.dart
/// 描述： 负责时间相关处理，解决是否显示时间，时间戳转换
/// 作者： Suihongwei 2021/4/27
/////////////////////////////////////////////
class TimeUtils {
  TimeUtils._();

  static int lastCreateTime = 0;

  ///获取现在的时间
  static int getDayNow() {
    var nowTime = DateTime.now();
    return nowTime.millisecondsSinceEpoch;
  }

  //格式化时间
  static String formatTime(int time) {
    var now = new DateTime.now();
    var createTime = DateTime.fromMillisecondsSinceEpoch(time);

    //不在当年
    if (now.year != createTime.year) {
      return "${createTime.year}年${createTime.month}月${addZeroBeforeData(createTime.day)}日 ${addZeroBeforeData(createTime.hour)}:${addZeroBeforeData(createTime.minute)}";
    }

    var different = now.difference(createTime);
    //当天
    if (different.inDays == 0) {
      return "${addZeroBeforeData(createTime.hour)}:${addZeroBeforeData(createTime.minute)}";
    }

    //昨天
    if (different.inDays == 1) {
      return "昨天 ${addZeroBeforeData(createTime.hour)}:${addZeroBeforeData(createTime.minute)}";
    }

    //一个星期内
    if (different.inDays < 7) {
      return "星期${convertToUppercaseNumbers(createTime.weekday)} ${addZeroBeforeData(createTime.hour)}:${addZeroBeforeData(createTime.minute)}";
    } else {
      //一个星期之外
      return "${createTime.month}月${addZeroBeforeData(createTime.day)}日 ${addZeroBeforeData(createTime.hour)}:${addZeroBeforeData(createTime.minute)}";
    }
  }

  //判断是否需要显示时间
  static bool whetherToDisplayTheTime(int time) {
    if (lastCreateTime == 0) {
      return true;
    }
    if (lastCreateTime / 1000 / 60 == time / 1000 / 60) {
      return false;
    } else {
      lastCreateTime = time;
      return true;
    }
  }

  //不全数字前面的0
  static String addZeroBeforeData(int value) {
    if (value ~/ 10 == 0) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  //获取到汉字星期
  static String convertToUppercaseNumbers(int numbers) {
    String uppercaseNumber = "";
    switch (numbers) {
      case 1:
        uppercaseNumber = "一";
        break;
      case 2:
        uppercaseNumber = "二";
        break;
      case 3:
        uppercaseNumber = "三";
        break;
      case 4:
        uppercaseNumber = "四";
        break;
      case 5:
        uppercaseNumber = "五";
        break;
      case 6:
        uppercaseNumber = "六";
        break;
      case 7:
        uppercaseNumber = "日";
        break;
      default:
        uppercaseNumber = "";
    }
    return uppercaseNumber;
  }
}
