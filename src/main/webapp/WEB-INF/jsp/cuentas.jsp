<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Cuentas</title>
        <style>
            /* Animación para el contenido desplegable */
            .details-content {
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.4s ease-in-out, opacity 0.3s ease-in-out;
                opacity: 0;
            }

            .details-content.active {
                max-height: 1000px;
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <div class="flex items-center justify-center min-h-screen bg-gray-50">
            <div class="w-full max-w-2xl px-4">
                <!-- Breadcrumb con fondo -->
                <nav class="mb-6 bg-teal-50 rounded-lg px-4 py-3 border border-teal-200">
                    <ol class="flex items-center space-x-2 text-sm">
                        <li>
                            <a href="/" class="text-teal-600 hover:text-teal-800 font-medium transition-colors">
                                Inicio
                            </a>
                        </li>
                        <li class="text-teal-300">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </li>
                        <li>
                            <a href="/cuentas" class="text-gray-700 font-semibold">
                                Cuentas
                            </a>
                        </li>
                    </ol>
                </nav>
                <h2 class="text-2xl font-bold mb-6 text-gray-700">Información de Cuentas</h2>
                <button command="show-modal" commandfor="cuenta" 
                        class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600"                        >
                    Añadir
                </button>
                <dialog id="cuenta" aria-labelledby="dialog-title" class="fixed inset-0 m-0 size-auto max-h-none max-w-none overflow-y-auto bg-transparent p-0 backdrop:bg-transparent">
                    <el-dialog-backdrop class="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"></el-dialog-backdrop>
                    <div tabindex="0" class="flex min-h-full items-end justify-center p-4 text-center focus:outline focus:outline-0 sm:items-center sm:p-0">
                        <el-dialog-panel class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95">
                            <form:form id="form-retiro" method="POST" modelAttribute="cuenta" 
                                       action="${pageContext.request.contextPath}/cuentas/add"
                                       enctype="multipart/form-data"
                                       class="space-y-4 mt-2">   


                                <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">

                                    <!-- Número de Cuenta -->
                                    <div>
                                        <label for="numeroCuenta" class="block text-sm font-medium text-gray-700 mb-1">
                                            Número de Cuenta
                                        </label>
                                        <input 
                                            type="text"
                                            id="numeroCuenta"
                                            name="numeroCuenta"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Ingresa el número de cuenta"
                                            required
                                            />
                                    </div>

                                    <!-- Tipo de Cuenta -->
                                    <div>
                                        <label for="tipoCuenta" class="block text-sm font-medium text-gray-700 mb-1">
                                            Tipo de Cuenta
                                        </label>
                                        <select 
                                            id="tipoCuenta"
                                            name="tipoCuenta"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            required>
                                            <option value="">Selecciona una opción</option>
                                            <option value="Débito">Débito</option>
                                            <option value="Crédito">Crédito</option>
                                            <option value="Ahorro">Ahorro</option>
                                        </select>
                                    </div>

                                    <!-- Saldo Inicial -->
                                    <div>
                                        <label for="saldoInicial" class="block text-sm font-medium text-gray-700 mb-1">
                                            Saldo Inicial
                                        </label>
                                        <input 
                                            type="number"
                                            id="saldoInicial"
                                            name="saldoInicial"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Ingresa el saldo"
                                            required
                                            />
                                    </div>

                                    <!-- Nombre del Titular -->
                                    <div>
                                        <label for="nombreTitular" class="block text-sm font-medium text-gray-700 mb-1">
                                            Nombre del Titular
                                        </label>
                                        <input 
                                            type="text" 
                                            id="nombreTitular" 
                                            name="nombreTitular"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Nombre completo"
                                            required
                                            />
                                    </div>

                                </div>

                                <div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                                    <button 
                                        type="submit"
                                        class="inline-flex w-full justify-center rounded-md bg-green-600 hover:bg-green-500 
                                        px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto">
                                        Guardar Cuenta
                                    </button>

                                    <button 
                                        type="button"
                                        command="close"
                                        commandfor="cuenta"
                                        class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm 
                                        font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 
                                        sm:mt-0 sm:w-auto">
                                        Cancelar
                                    </button>
                                </div>


                            </form:form>
                        </el-dialog-panel>
                    </div>
                </dialog>
                <div class="flex gap-4 mb-6">

                    <!-- FILTRO POR ESTADO -->
                    <select id="filtro-activa"
                            class="border border-gray-300 rounded-lg px-3 py-2 text-gray-700 focus:ring-teal-500 focus:border-teal-500">
                        <option value="">Estado</option>
                        <option value="true"  ${param.activa == 'true' ? 'selected' : ''}>Activa</option>
                        <option value="false" ${param.activa == 'false' ? 'selected' : ''}>Inactiva</option>
                    </select>

                    <!-- FILTRO POR TIPO -->
                    <select id="filtro-tipo"
                            class="border border-gray-300 rounded-lg px-3 py-2 text-gray-700 focus:ring-teal-500 focus:border-teal-500">
                        <option value="">Tipo de Cuenta</option>
                        <option value="AHORROS"    ${param.tipo == 'AHORROS' ? 'selected' : ''}>Ahorro</option>
                        <option value="CORRIENTE" ${param.tipo == 'CORRIENTE' ? 'selected' : ''}>Corriente</option>
                        <option value="DÉBITO"    ${param.tipo == 'DÉBITO' ? 'selected' : ''}>Débito</option>
                    </select>

                </div>

                <div class="space-y-4">
                    <c:if test="${not empty cuentas}">
                        <c:forEach var="cuenta" items="${cuentas}" varStatus="status">
                            <div class="bg-white rounded-lg shadow-md overflow-hidden transition-shadow duration-300 hover:shadow-lg">
                                <!-- Header clickeable -->
                                <div class="flex items-center justify-between border-b-2 border-teal-500 py-4 px-6 cursor-pointer hover:bg-teal-50 transition-colors duration-200"
                                     onclick="toggleDetails('cuenta-${status.index}')">
                                    <div>
                                        <h3 class="text-lg font-semibold text-teal-700">
                                            ${cuenta.numeroCuenta}
                                        </h3>
                                        <p class="text-sm text-gray-600">${cuenta.tipoCuenta}</p>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <span class="text-teal-600 font-semibold">$${cuenta.saldo}</span>
                                        <!-- Icono de flecha -->
                                        <svg id="arrow-cuenta-${status.index}" 
                                             class="w-5 h-5 text-teal-500 transform transition-transform duration-300" 
                                             fill="none" 
                                             stroke="currentColor" 
                                             viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                        </svg>
                                    </div>
                                </div>

                                <!-- Detalles colapsables con animación -->
                                <div id="cuenta-${status.index}" class="details-content">
                                    <table class="w-full">
                                        <tbody>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium w-1/2">Número de Cuenta</td>
                                                <td class="py-3 px-6 text-gray-700">${cuenta.numeroCuenta}</td>
                                            </tr>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium">Tipo de Cuenta</td>
                                                <td class="py-3 px-6 text-gray-700">${cuenta.tipoCuenta}</td>
                                            </tr>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium">Saldo</td>
                                                <td class="py-3 px-6 text-teal-600 font-semibold">$${cuenta.saldo}</td>
                                            </tr>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium">Fecha de Apertura</td>
                                                <td class="py-3 px-6 text-gray-700">${cuenta.fechaApertura}</td>
                                            </tr>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium">Estado</td>
                                                <td class="py-3 px-6">
                                                    <c:if test="${cuenta.activa}">
                                                        <span class="bg-teal-500 text-white text-sm py-1 px-3 rounded">
                                                            Activa
                                                        </span>
                                                    </c:if> 
                                                    <c:if test="${!cuenta.activa}">
                                                        <span class="bg-gray-500 text-white text-sm py-1 px-3 rounded">
                                                            Inactiva
                                                        </span>
                                                    </c:if> 
                                                </td>
                                            </tr>
                                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium">Nombre del Titular</td>
                                                <td class="py-3 px-6 text-gray-700">${cuenta.nombreTitular}</td>
                                            </tr>
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-6 text-gray-600 font-medium"></td>
                                                <td class="py-3 px-6 text-gray-700">
                                                    <a href="/cuentas/detalles/${cuenta.id}" 
                                                       class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600" >
                                                        Detalles
                                                    </a>                                                    
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <c:if test="${empty cuentas}">  
                        <div class="bg-white rounded-lg shadow-md p-6 text-center text-gray-500">
                            No hay cuentas disponibles
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <script>
            function toggleDetails(id) {
                const details = document.getElementById(id);
                const arrow = document.getElementById('arrow-' + id);

                if (details.classList.contains('active')) {
                    details.classList.remove('active');
                    arrow.classList.remove('rotate-180');
                } else {
                    details.classList.add('active');
                    arrow.classList.add('rotate-180');
                }
            }

        </script>
        <script>
            document.addEventListener("DOMContentLoaded", () => {

                const filtroActiva = document.getElementById("filtro-activa");
                const filtroTipo = document.getElementById("filtro-tipo");

                function aplicarFiltros() {
                    const activa = filtroActiva.value;
                    const tipo = filtroTipo.value;

                    let url = "/cuentas";

                    // Construimos parámetros dinámicamente
                    let params = [];

                    if (activa !== "")
                        params.push("activa=" + activa);
                    if (tipo !== "")
                        params.push("tipo=" + tipo);

                    if (params.length > 0) {
                        url += "?" + params.join("&");
                    }

                    window.location.href = url; // recargar con filtros
                }

                // Cuando cambias un select → aplicar filtro
                filtroActiva.addEventListener("change", aplicarFiltros);
                filtroTipo.addEventListener("change", aplicarFiltros);

            });
        </script>

    </body>
</html>