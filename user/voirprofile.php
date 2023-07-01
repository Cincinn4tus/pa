<?php
session_start();
require $_SERVER['DOCUMENT_ROOT'] . "/conf.inc.php";
require $_SERVER['DOCUMENT_ROOT'] . "/core/functions.php";
$pageTitle = "Amis";
saveLogs();
getUserInfos();
include $_SERVER['DOCUMENT_ROOT'] . "/assets/templates/header.php";
?>

<main id="main">
    <!-- ======= Breadcrumbs ======= -->
    <div class="breadcrumbs d-flex align-items-center" style="background-image: url('../assets/img/breadcrumbs-bg.jpg');">
        <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
            <h2>Profil</h2>
            <ol>
                <li><a href="/">Accueil</a></li>
                <li>Profil</li>
            </ol>
        </div>
    </div><!-- End Breadcrumbs -->

    <div class="container-fluid">
        <?php
        $connection = connectDB();
        $profileUserId = $_GET['id'];
        $currentUserId = $_SESSION['id'];

        try {
            $stmt = $connection->prepare("SELECT * FROM pa_user WHERE id = ?");
            $stmt->execute([$profileUserId]);
            $user = $stmt->fetch();

            if ($user) {
                echo "Profil de " . htmlspecialchars($user['firstname']) . " " . htmlspecialchars($user['lastname']);

                $friendshipStmt = $connection->prepare("SELECT status, blocked_status FROM friendship WHERE (user1_id = ? AND user2_id = ?) OR (user1_id = ? AND user2_id = ?)");
                $friendshipStmt->execute([$currentUserId, $profileUserId, $profileUserId, $currentUserId]);

                $friendship = $friendshipStmt->fetch();

                if ($friendship === false) {
                    echo "<form action='friendshipActions.php' method='post'>";
                    echo "<input type='hidden' name='action' value='sendFriendRequest'>";
                    echo "<input type='hidden' name='user_id' value='" . $profileUserId . "'>";
                    echo "<button type='submit'>Ajouter comme ami</button>";
                    echo "</form>";
                } elseif ($friendship['status'] === 'pending') {
                    echo "Demande en attente";
                } elseif ($friendship['status'] === 'accepted') {
                    echo "<form action='friendshipActions.php' method='post'>";
                    echo "<input type='hidden' name='action' value='removeFriend'>";
                    echo "<input type='hidden' name='friend_id' value='" . $profileUserId . "'>";
                    echo "<button type='submit'>Supprimer l'ami</button>";
                    echo "</form>";

                    if ($friendship['blocked_status'] === 'blocked') {
                        // Bouton de déblocage
                        echo "<form action='friendshipActions.php' method='post'>";
                        echo "<input type='hidden' name='action' value='unblockUser'>";
                        echo "<input type='hidden' name='user_id' value='" . $profileUserId . "'>";
                        echo "<button type='submit'>Débloquer</button>";
                        echo "</form>";
                    } else {
                        // Bouton de blocage
                        echo "<form action='friendshipActions.php' method='post'>";
                        echo "<input type='hidden' name='action' value='blockUser'>";
                        echo "<input type='hidden' name='user_id' value='" . $profileUserId . "'>";
                        echo "<button type='submit'>Bloquer</button>";
                        echo "</form>";
                    }
                }
            } else {
                echo "Profil introuvable";
            }
        } catch (PDOException $e) {
            echo "Erreur lors de la récupération des informations de profil: " . $e->getMessage();
        }
        ?>
    </div>

    <?php include $_SERVER['DOCUMENT_ROOT'] . "/assets/templates/footer.php"; ?>
