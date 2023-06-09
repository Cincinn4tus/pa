const containers = document.querySelector(".containers");

// put all files of /assets/img/captcha/ in an array
const images = ["/assets/img/captcha/image2.jpg", "/assets/img/captcha/image3.jpg"];

// Choisir une image aléatoire
const randomImage = images[Math.floor(Math.random() * images.length)];

// Afficher l'image choisie en 300x300 dans l'id preview

const preview = document.getElementById("preview");
preview.innerHTML = `<img src="${randomImage}" width="320" height="320" alt="Puzzle preview" />`;

// Découper l'image en 9 morceaux et créer les pièces du puzzle
const pieces = [];

for (let i = 0; i < 9; i++) {
  const piece = document.createElement("div");
  piece.classList.add("puzzle-piece");
  piece.style.backgroundImage = `url(${randomImage})`;
  piece.style.backgroundPosition = `-${(i % 3) * 100}px -${Math.floor(i / 3) * 100}px`;
  piece.setAttribute("data-index", i);
  piece.setAttribute("draggable", "true");
  pieces.push(piece);
}

// Mélanger les morceaux
shuffleArray(pieces).forEach((piece, i) => {
  piece.style.left = `${(i % 3) * 100}px`;
  piece.style.top = `${Math.floor(i / 3) * 100}px`;
  containers.appendChild(piece);
});

containers.addEventListener("dragstart", dragStart);
containers.addEventListener("dragend", dragEnd);

function dragStart(event) {
  if (event.target.classList.contains("puzzle-piece")) {
    event.target.style.opacity = 0.5;
  }
}

function dragEnd(event) {
  if (event.target.classList.contains("puzzle-piece")) {
    event.target.style.opacity = 1;
  }
}

containers.addEventListener("dragover", (event) => {
  event.preventDefault();
});

containers.addEventListener("drop", (event) => {
  event.preventDefault();
  const target = event.target;
  if (target.classList.contains("puzzle-piece")) {
    const dragged = document.querySelector(".puzzle-piece[style*='opacity: 0.5']");
    const tempPos = {
      left: target.style.left,
      top: target.style.top
    };

    target.style.left = dragged.style.left;
    target.style.top = dragged.style.top;

    dragged.style.left = tempPos.left;
    dragged.style.top = tempPos.top;

    checkSolution();
  }
});

// Fonction pour mélanger un tableau
function shuffleArray(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

// Vérifier si le puzzle est résolu
function checkSolution() {
  const pieces = Array.from(document.querySelectorAll(".puzzle-piece"));
  const sortedPieces = pieces.slice().sort((a, b) => {
    return parseInt(a.style.top) - parseInt(b.style.top) || parseInt(a.style.left) - parseInt(b.style.left);
  });

  if (sortedPieces.every((piece, index) => piece.getAttribute("data-index") == index)) {
    // Rediriger vers la page sendlink.php si le puzzle est résolu
    window.location.href = "sendRegistration.php";
  }
}
