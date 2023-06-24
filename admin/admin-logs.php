<?php 
    session_start();
    $pageTitle = "Logs";
    require $_SERVER['DOCUMENT_ROOT'] . "/conf.inc.php";
    require $_SERVER['DOCUMENT_ROOT'] . "/core/functions.php";
    saveLogs();
    include $_SERVER['DOCUMENT_ROOT'] . "/assets/templates/header.php";
?>

<?php
	$connection = connectDB();
	$results = $connection->query("SELECT * FROM ".DB_PREFIX."logs");
	$results = $results->fetchAll()
?>

<a href="/core/export-csv.php" class="btn btn-primary">Exporter en CSV</a>
<a href="/core/export-pdf.php" class="btn btn-primary">Exporter en PDF</a>


<table class="table mt-5">
    <thead>
        <tr>
            <th>id</th>
            <th>Utilisateur</th>
            <th>Adresse IP</th>
            <th>date</th>
            <th>heure</th>
            <th>page visitée</th>
        </tr>
    </thead>
    <tbody class="table_odd">
        <?php
            foreach ($results as $logs) {
                echo "<tr>";
                    echo "<td>".$logs["id"]."</td>";
                    echo "<td>".$logs["user"]."</td>";
                    echo "<td>".$logs["ip"]."</td>";
                    echo "<td>".$logs["visit_date"]."</td>";
                    echo "<td>".$logs["visit_hour"]."</td>";
                    echo "<td>".$logs["page_visited"]."</td>";
                echo "</tr>";
            }
        ?>
    </tbody>
</table>

<!-- récupérer le nombre de logs des dernières 24h
-->



<?php include $_SERVER['DOCUMENT_ROOT'] . "/assets/templates/footer.php"; ?>