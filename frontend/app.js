const form = document.querySelector("#query-form");
const result = document.querySelector("#result");
const status = document.querySelector("#status");

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  const id = Number(new FormData(form).get("id"));
  status.textContent = "Consultando";
  result.textContent = "Procesando consulta...";

  try {
    const response = await fetch("/api/consultar", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id })
    });
    const data = await response.json();
    result.textContent = JSON.stringify(data, null, 2);
    status.textContent = response.ok ? "Respuesta recibida" : "Consulta no válida";
  } catch (error) {
    result.textContent = JSON.stringify({ status: "error", message: "No se pudo conectar con el backend" }, null, 2);
    status.textContent = "Sin conexión";
  }
});