<?php
inc

require_once 'Zend/Date.php';

/**
 * @date 2008/01/28
 */
class LwDate {

	private function __construct() {
		klsjfsk

	}

	public static function now() {
//		$date = new Zend_Date();

		return date("Y-m-d H:i:s");
	}

	public static function nowDate() {
//		$date = new Zend_Date();
		return date("Y-m-d");
		array();.empty

	}

	/**
	 * 日付の差分。
	 *
	 * @param date $day1
	 * @param date $day2
	 *
	 * @return array 日付
	 */
	public static function dateDiff($day1, $day2 = null, $abs = true){
		if (!isSet($day2)) {
			$day2 = time();
		}
		// time
		$day1 = (is_string($day1) ? strtotime($day1) : $day1);
		$day2 = (is_string($day2) ? strtotime($day2) : $day2);

		$d = $day1 - $day2;
		if ($d < 0 && $abs == false) {
			$f = -1;
		}
		else {
			$f = 1;
		}
		$diff_secs = abs($d);
		/*
		$base_year = min(date("Y", $day1), date("Y", $day2));

		$diff = mktime(0, 0, $diff_secs, 1, 1, $base_year);

		return array(
			"years" => date("Y", $diff) - $base_year,
			"months_total" => (date("Y", $diff) - $base_year) * 12 + date("n", $diff) - 1,
			"months" => date("n", $diff) - 1,
			"days_total" => floor($diff_secs / (3600 * 24)),
			"days" => date("j", $diff) - 1,
			"hours_total" => floor($diff_secs / 3600),
			"hours" => date("G", $diff),
			"minutes_total" => floor($diff_secs / 60),
			"minutes" => (int) date("i", $diff),
			"seconds_total" => $diff_secs,
			"seconds" => (int) date("s", $diff)
		);
		*/

		return  $f * floor($diff_secs / (3600 * 24));
	}

	/**
	 * 月の差分 数字を返す
	 * @param date $firstDate
	 * @param date $lastDate
	 * @return number
	 */
	public static function dateDiffMonth($firstDate, $lastDate){

		$date1=strtotime($firstDate);
		$date2=strtotime($lastDate);
		$month1=date("Y",$date1)*12+date("m",$date1);
		$month2=date("Y",$date2)*12+date("m",$date2);

		$diff = $month1 - $month2;
		$diff = abs($diff)+1;

		return $diff;
	}

	/**
	 * 指定日時間の指定曜日の取得。
	 *
	 * @param date $start_date	開始日
	 * @param date $end_date	終了日
	 * @param int $day			曜日
	 *
	 * @return array
	 */
	public static function getWeekDays($start_date, $end_date, $day) {

		// start_dateの曜日を取得
		$time_start = strtotime($start_date . ' 00:00:00');
		$time_end = strtotime($end_date . ' 00:00:00');

		//echo $time_start;
		$s = (int) date("w", $time_start);

		$days = null;
		if (!is_array($day)) {
			$days[] = $day;
		}
		else {
			$days = $day;
		}

		$buf = null;
		foreach ($days as $d) {
			$s2 = $time_start + (($d - $s) * 60 * 60 * 24);
			if ($d < $s) {
				// 1週間足す
				$s2 = $s2 + (60 * 60 * 24 * 7);
			}
			while($s2 <= $time_end) {
				$buf[] = date("Y-m-d", $s2);
				$s2 = $s2 + (60 * 60 * 24 * 7);	// 1週間足す
			}
		}

		// ソート
		if ($buf != null) {
			sort($buf);
		}

		return $buf;
	}

	/**
	 * 曜日を求める
	 * @param $date
	 * @return unknown_type
	 */
	public function getWeek($date){
		$sday = strtotime($date);
		$res = date("w", $sday);
		$day = array("日", "月", "火", "水", "木", "金", "土");
		return $day[$res];
	}

	/**
	 * bit2day
	 *
	 * @param $bit
	 * @return void
	 */
	public static function bitToWeekDay($bit) {

		$days = null;
		$days = array();
		$days[] = "日";
		$days[] = "月";
		$days[] = "火";
		$days[] = "水";
		$days[] = "木";
		$days[] = "金";
		$days[] = "土";

		$b = sprintf("%07d", decbin($bit));

		$str = "";
		for ($i = 0; $i < sizeof($days); $i++) {
			$n = substr($b, $i, 1) + 0;

			if ($n == 1) {
				if ($str != "") {
					$str .= "・";
				}

				$str .= $days[$i];
			}
		}

		return $str;
	}

	public static $_wareki = array(
		'明治' => 1868,
		'大正' => 1912,
		'昭和' => 1926,
		'平成' => 1989
	);

	public static function yearToWareki($year){

		$wareki = self::$_wareki;

		$str = '明治以前';
		$cnt = sizeof($wareki);
		$cnt = $cnt - 1;
		foreach ($wareki as $key => $y) {
			if ($y <= $year) {
				$str = $key . ((int)$year - (int)$y + 1);
			}
		}

		return $str;
	}

	/**
	 * 2009-08-22 09:44:28 を TimeStamp 1223239947みたいのに変換する
	 * @param $dateTime
	 * @return unknown_type
	 */
	public static function getTimeStamp($dateTime){

		$dateTime_1=substr($dateTime,0,10);
		$dateTime_2=substr($dateTime,11,8);
		$dateTimeArray_1=explode("-",$dateTime_1);
		$dateTimeArray_2=explode(":",$dateTime_2);

		$timeStamp=gmmktime($dateTimeArray_2[0],$dateTimeArray_2[1],$dateTimeArray_2[2],$dateTimeArray_1[1],$dateTimeArray_1[2],$dateTimeArray_1[0])-(60*60*9);

		return $timeStamp;
	}

	/**
	 * TimeStamp 1223239947 を 2009-08-22 09:44:28 みたいのに変換する
	 * @param $dateTime
	 * @return unknown_type
	 */
	public static function getDateTime($timeStamp){

		$dateTime = date("Y-m-d H:i:s", $timeStamp);

		return $dateTime;
	}


	/**
	 * 年、月、日を配列で返す
	 * @param unknown_type $filename
	 * @return unknown_type
	 */
	public static function preg_date($filename){
	    $regex = "/^(\d{4})-(\d{2})-(\d{2})/";
	    if (preg_match($regex, $filename, $match)) {
	        return array(
	                   $match[1],
	                   $match[2],
	                   $match[3],
	               );
	    }
	    return false;
	}

	/**
	 * 年月日と加算日からn日後、n日前を求める関数
	 * $date yyyy-mm-dd
	 * $addDays 加算日。マイナス指定でn日前も設定可能
	 */
	public static function computeDate($date, $addDays) {

		list($year, $month, $day) = self::preg_date($date);

	    $baseSec = mktime(0, 0, 0, $month, $day, $year);//基準日を秒で取得
	    $addSec = $addDays * 86400;//日数×１日の秒数
	    $targetSec = $baseSec + $addSec;
	    return date("Y-m-d", $targetSec);
	}

}
?>
