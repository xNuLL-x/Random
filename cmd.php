<?php
if (isset($_POST["Host"])) {
    $Host=$_POST['Host'];
    $command=escapeshellcmd("ping $Host");
    echo shell_exec($command);
}
?>