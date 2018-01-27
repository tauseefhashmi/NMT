<?php
$con=mysqli_connect("localhost","root","","Tauseef");

if(!=$con)
  {
  echo "Failed to connect to MySQL: ";
  }
$a=$_POST['email'];
$b=$_POST['pswd'];
echo $a;
echo $b;
 mysql_select_db($con,"Tauseef");
{
$s="select* FROM Registration where EmailAddress='$a'&& Password='$b';";
$result=mysqli_query($con,$s);
$rowcount=mysqli_num_rows($result);
if($rowcount==1)
{
echo"Authorization Granted";
}
else
{
echo"Unauthorized Access";
}

?> 
