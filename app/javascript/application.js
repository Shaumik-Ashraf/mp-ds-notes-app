// Vanilla JS for interactive behavior (no Turbo, no Stimulus)

document.addEventListener("click", function (e) {
  var link = e.target.closest("[data-method]");
  if (!link) return;

  if (link.hasAttribute("data-confirm") && !confirm(link.getAttribute("data-confirm"))) {
    e.preventDefault();
    return;
  }

  var method = link.getAttribute("data-method");
  if (method && method.toLowerCase() !== "get") {
    e.preventDefault();
    var form = document.createElement("form");
    form.action = link.href;
    form.method = "post";
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "_method";
    input.value = method;
    form.appendChild(input);
    var csrf = document.querySelector('meta[name="csrf-token"]');
    if (csrf) {
      var csrfInput = document.createElement("input");
      csrfInput.type = "hidden";
      csrfInput.name = "authenticity_token";
      csrfInput.value = csrf.content;
      form.appendChild(csrfInput);
    }
    document.body.appendChild(form);
    form.submit();
  }
});