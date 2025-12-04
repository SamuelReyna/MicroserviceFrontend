
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

    </head>
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
    <script src="https://cdn.jsdelivr.net/npm/@tailwindplus/elements@1" type="module"></script> 

    <body>
        <div id="alert-container" class="fixed top-4 right-4 z-50 space-y-2"></div>
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
                            <a href="/cuentas" class="text-teal-600 hover:text-teal-800 font-medium transition-colors">
                                Cuentas
                            </a>
                        </li>
                        <li class="text-teal-300">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </li>
                        <li>
                            <span class="text-gray-700 font-semibold">
                                Información de Cuenta
                            </span>
                        </li>
                    </ol>
                </nav>
                <h2 class="text-2xl font-bold mb-4 text-gray-700">Información de Cuenta</h2>

                <div class="flex gap-3 mb-4">

                    <button command="show-modal" commandfor="deposito" 
                            data-id="${cuenta.id}"
                            class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600"                        >
                        Depósito
                    </button>

                    <button command="show-modal" commandfor="retiro" 
                            data-id="${cuenta.id}"
                            class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600"                        >
                        Retiro
                    </button>

                </div>


                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <c:if test ="${cuenta != null}">

                            <thead>
                                <tr class="border-b-2 border-teal-500">
                                    <th class="text-left py-3 px-4 text-teal-500 font-semibold">Cuenta</th>
                                    <th class="text-left py-3 px-4 text-teal-500 font-semibold"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Número de Cuenta</td>
                                    <td class="py-3 px-4 text-gray-700">${cuenta.numeroCuenta}</td>
                                </tr>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Tipo de Cuenta</td>
                                    <td class="py-3 px-4 text-gray-700">${cuenta.tipoCuenta}</td>
                                </tr>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Saldo</td>
                                    <td class="py-3 px-4 text-teal-600 font-semibold">$ ${cuenta.saldo}</td>
                                </tr>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Fecha de Apertura</td>
                                    <td class="py-3 px-4 text-gray-700">${cuenta.fechaApertura}</td>
                                </tr>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Estado</td>
                                    <td class="py-3 px-4">
                                        <c:if test="${cuenta.activa}">
                                            <button data-id="${cuenta.id}" data-activa="${cuenta.activa}" command="show-modal" commandfor="dialog" 
                                                    class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600" >
                                                Activa 
                                            </button>
                                        </c:if> 
                                        <c:if test="${!cuenta.activa}">
                                            <button data-id="${cuenta.id}" data-activa="${cuenta.activa}" command="show-modal" commandfor="dialog"
                                                    class="inline-flex items-center bg-gray-500 text-white text-sm py-1 px-3 rounded hover:bg-gray-600" >
                                                Inactiva 
                                            </button>
                                        </c:if> 
                                    </td>
                                </tr>
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Nombre del Titular</td>
                                    <td class="py-3 px-4 text-gray-700">${cuenta.nombreTitular}</td>
                                </tr>
                                <tr>                          
                                    <td class="py-3 px-4 text-gray-600 font-medium"></td>
                                    <td class="py-3 px-4">
                                        <button id="movimientosBtn"
                                                class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600" 
                                                onClick="toggleDetails()">
                                            <span>Movimientos</span>
                                            <svg id="arrow-cuenta" 
                                                 class="w-4 h-4 transform transition-transform duration-300" 
                                                 fill="none" 
                                                 stroke="currentColor" 
                                                 viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                            </svg>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </c:if>
                    </table>


                    <div id="movimientos" class="details-content">
                        <div class="flex gap-4 mb-4">

                            <!-- Fecha inicio -->
                            <div class="flex flex-col">
                                <label for="fechaInicio" class="text-sm text-gray-600 mb-1">Fecha inicio</label>
                                <input 
                                    type="date" 
                                    id="fechaInicio"
                                    class="border border-gray-300 rounded-lg px-3 py-2 text-gray-700 focus:ring-teal-500 focus:border-teal-500"
                                    value="${param.fechaInicio != null ? param.fechaInicio : ''}"
                                    >
                            </div>

                            <!-- Fecha fin -->
                            <div class="flex flex-col">
                                <label for="fechaFin" class="text-sm text-gray-600 mb-1">Fecha fin</label>
                                <input 
                                    type="date" 
                                    id="fechaFin"
                                    class="border border-gray-300 rounded-lg px-3 py-2 text-gray-700 focus:ring-teal-500 focus:border-teal-500"
                                    value="${param.fechaFin != null ? param.fechaFin : ''}"
                                    >
                            </div>

                        </div>
                        <table class="w-full">
                            <c:if test="${not empty movimientos}">
                                <div class="space-y-2 max-h-96 overflow-y-auto pr-2">
                                    <c:forEach var="movimiento" items="${movimientos}" varStatus="status">
                                        <div class="flex items-center justify-between bg-white border-l-4 
                                             ${movimiento.tipo == 'deposito' ? 'border-green-500' : 'border-red-500'} 
                                             rounded-r-lg p-4 shadow-sm hover:shadow-md transition-all duration-200">

                                            <!-- Lado izquierdo: Info -->
                                            <div class="flex items-center gap-4 flex-1">
                                                <!-- Número -->
                                                <div class="flex-shrink-0 w-10 h-10 bg-teal-100 rounded-full flex items-center justify-center">
                                                    <span class="text-teal-700 font-bold text-sm">${status.index + 1}</span>
                                                </div>

                                                <!-- Detalles -->
                                                <div class="flex-1">
                                                    <div class="flex items-center gap-2 mb-1">
                                                        <span class="px-2 py-1 text-xs font-semibold rounded
                                                              ${movimiento.tipo == 'deposito' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                                            ${movimiento.tipo}
                                                        </span>
                                                        <span class="text-gray-400">•</span>
                                                        <span class="text-sm text-gray-500">${movimiento.fechaFormateada}</span>
                                                    </div>
                                                    <p class="text-gray-700 font-medium">${movimiento.descripcion}</p>
                                                </div>
                                            </div>

                                            <!-- Lado derecho: Monto -->
                                            <div class="flex-shrink-0 text-right">
                                                <span class="text-2xl font-bold ${movimiento.tipo == 'deposito' ? 'text-green-600' : 'text-red-600'}">
                                                    ${movimiento.tipo == 'deposito' ? '+' : '-'}$${movimiento.monto}
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>  
                            </c:if>
                            <c:if test="${empty movimientos}">
                                <div class="flex items-center justify-center bg-white border-l-4 ">
                                    Sin movimientos
                                </div>
                            </c:if>

                        </table>
                    </div>
                </div>
            </div>
            <!-- Include this script tag or install `@tailwindplus/elements` via npm: -->
            <el-dialog>
                <dialog id="dialog" aria-labelledby="dialog-title" class="fixed inset-0 m-0 size-auto max-h-none max-w-none overflow-y-auto bg-transparent p-0 backdrop:bg-transparent">
                    <el-dialog-backdrop class="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"></el-dialog-backdrop>
                    <div tabindex="0" class="flex min-h-full items-end justify-center p-4 text-center focus:outline focus:outline-0 sm:items-center sm:p-0">
                        <el-dialog-panel class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95">
                            <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                                <div class="sm:flex sm:items-start">
                                    <!-- Icono dinámico -->
                                    <div id="dialog-icon" class="mx-auto flex size-12 shrink-0 items-center justify-center rounded-full bg-red-100 sm:mx-0 sm:size-10">
                                        <svg id="icon-warning" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" data-slot="icon" aria-hidden="true" class="size-6 text-red-600">
                                        <path d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                        <svg id="icon-check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="size-6 text-green-600 hidden">
                                        <path d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                    </div>
                                    <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                                        <h3 id="dialog-title" class="text-base font-semibold text-gray-900"></h3>
                                        <div class="mt-2">
                                            <p id="dialog-message" class="text-sm text-gray-500"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                                <button id="btn-confirmar" type="button" command="close" commandfor="dialog" onclick="desactivarAccount()" class="inline-flex w-full justify-center rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto"></button>
                                <button type="button" command="close" commandfor="dialog" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Cancelar</button>
                            </div>
                        </el-dialog-panel>
                    </div>
                </dialog>
            </el-dialog>
            <el-dialog>
                <dialog id="retiro" aria-labelledby="dialog-title" class="fixed inset-0 m-0 size-auto max-h-none max-w-none overflow-y-auto bg-transparent p-0 backdrop:bg-transparent">
                    <el-dialog-backdrop class="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"></el-dialog-backdrop>
                    <div tabindex="0" class="flex min-h-full items-end justify-center p-4 text-center focus:outline focus:outline-0 sm:items-center sm:p-0">
                        <el-dialog-panel class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95">
                            <form:form id="form-retiro" method="POST" modelAttribute="movimiento" 
                                       action="${pageContext.request.contextPath}/movimiento/retiro/${cuenta.id}"
                                       enctype="multipart/form-data"
                                       class="space-y-4 mt-2">   
                                <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                                    <!-- Campo Monto -->
                                    <div>
                                        <label for="monto" class="block text-sm font-medium text-gray-700 mb-1">
                                            Monto
                                        </label>
                                        <input 
                                            type="number" 
                                            id="monto" 
                                            name="monto" 
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Ingresa el monto"
                                            required
                                            />
                                    </div>

                                    <!-- Campo Descripción -->
                                    <div>
                                        <label for="descripcion" class="block text-sm font-medium text-gray-700 mb-1">
                                            Descripción
                                        </label>
                                        <textarea 
                                            id="descripcion" 
                                            name="descripcion" 
                                            rows="3"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Descripción del retiro"
                                            required
                                            ></textarea>
                                    </div>


                                </div>
                                <div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                                    <button id="btn-confirmar-retiro" type="submit" command="close" commandfor="retiro" class="inline-flex w-full justify-center rounded-md bg-green-600 hover:bg-green-500 px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto">Confirmar</button>
                                    <button type="button" command="close" commandfor="retiro" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Cancelar</button>
                                </div>
                            </form:form>
                        </el-dialog-panel>
                    </div>
                </dialog>
            </el-dialog>
            <el-dialog>
                <dialog id="deposito" aria-labelledby="dialog-title" class="fixed inset-0 m-0 size-auto max-h-none max-w-none overflow-y-auto bg-transparent p-0 backdrop:bg-transparent">
                    <el-dialog-backdrop class="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"></el-dialog-backdrop>
                    <div tabindex="0" class="flex min-h-full items-end justify-center p-4 text-center focus:outline focus:outline-0 sm:items-center sm:p-0">


                        <el-dialog-panel class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95">
                            <form:form id="form-deposito" method="POST" modelAttribute="movimiento" 
                                       action="${pageContext.request.contextPath}/movimiento/deposito/${cuenta.id}"
                                       enctype="multipart/form-data"
                                       class="space-y-4 mt-2">
                                <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">

                                    <!-- Campo Monto -->
                                    <div>
                                        <label for="monto" class="block text-sm font-medium text-gray-700 mb-1">
                                            Monto
                                        </label>
                                        <input 
                                            type="number" 
                                            id="monto" 
                                            name="monto" 
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Ingresa el monto"
                                            required
                                            />
                                    </div>

                                    <!-- Campo Descripción -->
                                    <div>
                                        <label for="descripcion" class="block text-sm font-medium text-gray-700 mb-1">
                                            Descripción
                                        </label>
                                        <textarea 
                                            id="descripcion" 
                                            name="descripcion" 
                                            rows="3"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                            placeholder="Descripción del deposito"
                                            required
                                            ></textarea>
                                    </div>

                                </div>
                                <div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                                    <button 
                                        id="btn-confirmar-deposito" 
                                        type="submit"
                                        command="close" commandfor="deposito" 
                                        class="inline-flex w-full justify-center rounded-md bg-green-600 hover:bg-green-500 px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto"
                                        >Confirmar</button>
                                    <button 
                                        type="button"
                                        command="close"
                                        commandfor="deposito"
                                        class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                                        >Cancelar</button>
                                    </
                                </form:form>
                        </el-dialog-panel>

                    </div>
                </dialog>
            </el-dialog>


        </div>
        <script src="${pageContext.request.contextPath}/alertas.js"></script>
        <script>
                                    document.addEventListener("DOMContentLoaded", () => {

                                        const fInicio = document.getElementById("fechaInicio");
                                        const fFin = document.getElementById("fechaFin");
                                        function aplicarFiltrosFecha() {

                                            const inicio = fInicio.value;
                                            const fin = fFin.value;
                                            let url = window.location.pathname; // /cuentas/detalles/ID
                                            let params = [];
                                            console.log("fechaFin: ", fin);
                                            if (new Date(inicio).getTime() > new Date(fin).getTime()) {
                                                fInicio.value = "";
                                                fFin.value = "";
                                                mostrarAlerta("La fecha inicio no puede ser mayor que la fecha fin", 'warning');
                                            } else {
                                                if (inicio !== "")
                                                    params.push("fechaInicio=" + inicio);
                                                if (fin !== "")
                                                    params.push("fechaFin=" + fin);
                                                if (params.length > 0) {
                                                    url += "?" + params.join("&");
                                                }

                                                window.location.href = url;
                                            }

                                        }

                                        fInicio.addEventListener("change", aplicarFiltrosFecha);
                                        fFin.addEventListener("change", aplicarFiltrosFecha);
                                    });
        </script>

        <script>
            // Capturar el data-id cuando se abre el modal
            let cuentaIdSeleccionada = null;
            let cuentaActiva = null;
            let botonActual = null;
            document.addEventListener('click', function (e) {
                if (e.target.hasAttribute('command') && e.target.getAttribute('command') === 'show-modal') {
                    botonActual = e.target;
                    cuentaIdSeleccionada = e.target.getAttribute('data-id');
                    cuentaActiva = e.target.getAttribute('data-activa') === 'true';
                    actualizarModal(cuentaActiva);
                }
            });
            function actualizarModal(esActiva) {
                const dialogTitle = document.getElementById('dialog-title');
                const dialogMessage = document.getElementById('dialog-message');
                const btnConfirmar = document.getElementById('btn-confirmar');
                const dialogIcon = document.getElementById('dialog-icon');
                const iconWarning = document.getElementById('icon-warning');
                const iconCheck = document.getElementById('icon-check');
                if (esActiva) {
                    // Configuración para DESACTIVAR
                    dialogTitle.textContent = 'Desactivar cuenta';
                    dialogMessage.textContent = '¿Seguro que desea desactivar esta cuenta?';
                    btnConfirmar.textContent = 'Desactivar';
                    btnConfirmar.className = 'inline-flex w-full justify-center rounded-md bg-red-600 hover:bg-red-500 px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto';
                    dialogIcon.className = 'mx-auto flex size-12 shrink-0 items-center justify-center rounded-full bg-red-100 sm:mx-0 sm:size-10';
                    iconWarning.classList.remove('hidden');
                    iconCheck.classList.add('hidden');
                } else {
                    // Configuración para ACTIVAR
                    dialogTitle.textContent = 'Activar cuenta';
                    dialogMessage.textContent = '¿Seguro que desea activar esta cuenta?';
                    btnConfirmar.textContent = 'Activar';
                    btnConfirmar.className = 'inline-flex w-full justify-center rounded-md bg-green-600 hover:bg-green-500 px-3 py-2 text-sm font-semibold text-white shadow-sm sm:ml-3 sm:w-auto';
                    dialogIcon.className = 'mx-auto flex size-12 shrink-0 items-center justify-center rounded-full bg-green-100 sm:mx-0 sm:size-10';
                    iconWarning.classList.add('hidden');
                    iconCheck.classList.remove('hidden');
                }
            }



            function desactivarAccount() {
                if (!cuentaIdSeleccionada || !botonActual) {
                    mostrarAlerta('No se ha seleccionado ninguna cuenta', 'error');
                    return;
                }

                const nuevoEstado = !cuentaActiva;
                fetch('/cuentas/desactivar-cuenta?id=' + cuentaIdSeleccionada, {
                    method: 'POST'
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Error en la petición');
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log(data);
                            // Actualizar el botón sin recargar la página
                            if (nuevoEstado) {
                                // Cambiar a ACTIVA
                                botonActual.className = 'bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600';
                                botonActual.textContent = 'Activa';
                                botonActual.setAttribute('data-activa', 'true');
                            } else {
                                // Cambiar a INACTIVA
                                botonActual.className = 'bg-gray-500 text-white text-sm py-1 px-3 rounded hover:bg-gray-600';
                                botonActual.textContent = 'Inactiva';
                                botonActual.setAttribute('data-activa', 'false');
                            }

                            // Mostrar alerta con el mensaje del backend
                            mostrarAlerta(data.message, 'success');
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            mostrarAlerta('Error al cambiar estado de la cuenta', 'error');
                        });
            }
        </script>

        <script>

            <c:if test="${transaccion != null}">
            mostrarAlerta("${transaccion.mensaje}</br> Saldo anterior: $${transaccion.saldoAnterior} </br> Saldo actual: $${transaccion.saldoNuevo}", 'success');
            </c:if>
            <c:if test="${message != null}">
                mostrarAlerta("${message.mensaje} ", 'error');
            </c:if>
        </script>

        <style>
            .alert-animation {
                animation: slideIn 0.3s ease-out;
                transition: opacity 0.3s, transform 0.3s;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        </style>
        <script>
            function toggleDetails() {
                const details = document.getElementById("movimientos");
                const arrow = document.getElementById('arrow-cuenta');
                if (details.classList.contains('active')) {
                    details.classList.remove('active');
                    arrow.classList.remove('rotate-180');
                } else {
                    details.classList.add('active');
                    arrow.classList.add('rotate-180');
                }
            }
        </script>
    </body>
</html>