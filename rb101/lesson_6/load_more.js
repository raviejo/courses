let start;
let grow_by;
let elements = document.getElementsByClassName("result");
let w = window.innerWidth;

function setConstants() {
  if (w >= 992) {
    grow_by = 3;
    start = 3;
  }
  else {
    start = 2;
    grow_by = 2;
  }
}

function hideElements() {
  for (i = 0; i < elements.length; i++) {
    if (i < start) {
      elements[i].classList.remove("result-hidden");
    }
    else {
      elements[i].classList.add("result-hidden");
    }
  }
}

setConstants();
hideElements();

document.getElementById("loadMore").addEventListener("click", function() {
  start += grow_by;
  hideElements();
  if (elements.length < start) {
    document.getElementById("loadMore").classList.add("result-hidden")
  }
})