<?php

require("../config/db.php");

$mysql_link = mysqli_connect($servername, $dbusername, $dbpassword) or die("Error! (database connection)");
mysqli_select_db($mysql_link, $dbname) or die("Error! (database access)");

$query = "SELECT count(*) AS output FROM `test`";
$lookup = mysqli_query($mysql_link, $query);
if ( mysqli_num_rows($lookup) > 0 ) {
  $data = mysqli_fetch_assoc($lookup);
  echo $data["output"];
}
mysqli_free_result($lookup);

?>
