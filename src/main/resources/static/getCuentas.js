document.addEventListener('DOMContentLoaded', () => {
    fetchCuentas();
});

function fetchCuentas() {
    fetch('cuentas/list')
        .then(response => response.json())
        .then(data => renderCuentas(data))
        .catch(err => console.error("Error cargando cuentas:", err));
}

function renderCuentas(cuentas) {
    const contenedor = document.getElementById('contenedor-cuentas');
    contenedor.innerHTML = "";

    cuentas.forEach((cuenta, index) => {
        const isActiva = cuenta.activa
            ? `<span class="bg-teal-500 text-white text-sm py-1 px-3 rounded">Activa</span>`
            : `<span class="bg-gray-500 text-white text-sm py-1 px-3 rounded">Inactiva</span>`;

        const card = `
        <div class="bg-white rounded-lg shadow-md overflow-hidden transition-shadow duration-300 hover:shadow-lg">

            <div class="flex items-center justify-between border-b-2 border-teal-500 py-4 px-6 cursor-pointer hover:bg-teal-50"
                 onclick="toggleDetails(${index})">

                <div>
                    <h3 class="text-lg font-semibold text-teal-700">${cuenta.numeroCuenta}</h3>
                    <p class="text-sm text-gray-600">${cuenta.tipoCuenta}</p>
                </div>

                <div class="flex items-center gap-4">
                    <span class="text-teal-600 font-semibold">$${cuenta.saldo}</span>

                    <svg id="arrow-${index}" 
                        class="w-5 h-5 text-teal-500 transform transition-transform duration-300" 
                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M19 9l-7 7-7-7"/>
                    </svg>
                </div>

            </div>

            <div id="cuenta-${index}" class="details-content hidden">
                <table class="w-full">
                    <tbody>
                        <tr class="border-b border-gray-200"><td class="py-3 px-6 text-gray-600">Número de Cuenta</td><td class="py-3 px-6 text-gray-700">${cuenta.numeroCuenta}</td></tr>
                        <tr class="border-b border-gray-200"><td class="py-3 px-6 text-gray-600">Tipo</td><td class="py-3 px-6 text-gray-700">${cuenta.tipoCuenta}</td></tr>
                        <tr class="border-b border-gray-200"><td class="py-3 px-6 text-gray-600">Saldo</td><td class="py-3 px-6 text-teal-600 font-semibold">$${cuenta.saldo}</td></tr>
                        <tr class="border-b border-gray-200"><td class="py-3 px-6 text-gray-600">Apertura</td><td class="py-3 px-6 text-gray-700">${cuenta.fechaApertura}</td></tr>
                        <tr class="border-b border-gray-200"><td class="py-3 px-6 text-gray-600">Estado</td><td class="py-3 px-6">${isActiva}</td></tr>
                        <tr class=""><td class="py-3 px-6">Titular</td><td class="py-3 px-6 text-gray-700">${cuenta.nombreTitular}</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
        `;

        contenedor.insertAdjacentHTML('beforeend', card);
    });
}

// HACER GLOBAL LA FUNCIÓN Y USAR EL ÍNDICE DIRECTAMENTE
window.toggleDetails = function (index) {
    const content = document.getElementById("cuenta-" + index);
    const arrow = document.getElementById("arrow-" + index);

    content.classList.toggle('hidden');
    arrow.classList.toggle('rotate-180');
};
