<?php
print_r(" 
  +----------------------------------------------------------------------+ 
  |                Decode     MD5    From    www.xmd5.org                |
  |                            By Lovesuae                               |
  |                       h4ckj0y_at_gmail.com                           |
  |                �÷���       decode.exe md5.txt                       | 
  |                �����㱣����counter.txt��,�����Ҫ������              |
  +----------------------------------------------------------------------+ 
"); 

ini_set("max_execution_time",0); 
error_reporting(7); 
global $contents,$filename,$id,$beginid;
$filename="$argv[1]"; 
$id=1;//������
if (!strpos($filename,".")) exit;

main($filename,readcounter());


function main($filename,$beginid)
{
	global $contents,$filename,$id;
	openfile($filename);
	$handle = @fopen("$filename", "r");
	checktest();
	if ($handle) {
	   while (!feof($handle)) {
		   $buffer = fgets($handle, 128);
		   $buffer = preg_replace('/\r|\n/', '', $buffer); 
		   if (strlen($buffer) == 16 or strlen($buffer) == 32)
			{
				if ($id>=$beginid){
					echo ">�����ƽ�ɢ��".$id."��".$buffer."\r\n";
					decode($buffer,$contents);	
					if (!($id%5)){
						checktest();
						writefile($filename);
						setcounter($filename,$id);
					}
				}
			}
			$id=$id+1;
	   }
	fclose($handle);
	}		
}

function decode($hash,$contents){
	$fp = fsockopen('125.91.8.135',80);
	$out = "GET /md5/md5check.asp?md5pass=$hash HTTP/1.1\r\n";
	$out .= "Accept: */*\r\n";
	$out .= "Referer: http://www.xmd5.org/\r\n";
	$out .= "Accept-Language: zh-cn\r\n";
	$out .= "UA-CPU: x86\r\n";
	$out .= "Accept-Encoding: gzip, deflate\r\n";
	$out .= "User-Agent: Mozilla/4.0\r\n";
	$out .= "Host:www.xmd5.org:80\r\n";
	$out .= "Connection: Close\r\n";
	$out .= "Cookie: \r\n\r\n";
	fwrite($fp, $out);
	$fr= fread($fp,8096);
	$beg=strpos($fr,'Location:');
	$end=strpos($fr,'Server:');
	$result=substr($fr,$beg+51,$end-$beg-53);
	if (strlen($result)<=15){
		if ($result=="no") {
			echo ">.�޷��ƽ�\r\n\r\n";}
		else {
			echo ">.���ƽ�: $result\r\n\r\n";
			replace($hash,$result,$contents);}
	}
	else {
		echo "\r\n���ִ��󣬽������²��ź����ԣ�������\r\n";
		exit;
	}
	fclose($fp);
}

function checktest(){
	global $contents,$filename;
	$hash="CCA9F141BD0DA3496C3FA6AB3E31ADD3";
	$fp = fsockopen('125.91.8.135',80);
	$out = "GET /md5/md5check.asp?md5pass=$hash HTTP/1.1\r\n";
	$out .= "Accept: */*\r\n";
	$out .= "Referer: http://www.xmd5.org/\r\n";
	$out .= "Accept-Language: zh-cn\r\n";
	$out .= "UA-CPU: x86\r\n";
	$out .= "Accept-Encoding: gzip, deflate\r\n";
	$out .= "User-Agent: Mozilla/4.0\r\n";
	$out .= "Host:www.xmd5.org:80\r\n";
	$out .= "Connection: Close\r\n";
	$out .= "Cookie: \r\n\r\n";
	fwrite($fp, $out);
	$fr= fread($fp,4068);
	$beg=strpos($fr,'Location:');
	$end=strpos($fr,'Server:');
	$result=substr($fr,$beg+51,$end-$beg-53);
	if ($result!="no") {
		echo "��ǰ��վ�޷������ƽ⣬�������²��ź����ԣ�\r\n";
		exit;
	}
}

function replace($hash,$result,$contents)
{
	global $contents,$filename;
	$contents=str_replace($hash,$result,$contents);
}

function openfile($filename)
{
	global $contents,$filename;
	$contents = file_get_contents($filename);
}

function writefile($filename)
{
	global $contents;
	$handle = @fopen($filename, "w+");
	if (fwrite($handle,$contents)) {
		//echo "д���ļ��ɹ���\r\n";
	}
	else {
		echo "д���ļ�ʧ�ܣ�\r\n";
		exit;}
	fclose($handle);
}

function setcounter($filename,$id){
	global $beginid,$id;
	$fn="counter.txt";
	$handle = @fopen($fn, "w+");
	if (fwrite($handle,$id)) {
		//echo "д���¼��ɹ���\r\n\r\n";
		}
	else {
		echo "д���¼��ʧ�ܣ�\r\n\r\n";
		exit;}
	fclose($handle);
}
function readcounter(){
	global $beginid,$id;
	$fn="counter.txt";
	$handle2 = @fopen($fn, "a+");
	$beginid = fgets($handle2, 128);
	if ($beginid) {
		echo "\r\n>��¼���ȡ�ɹ�\r\n\r\n";}
	else $beginid=1;
	return $beginid;
}
?>
