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
        <script src="${pageContext.request.contextPath}/alertas.js"></script>
        <div id="alert-container" class="fixed top-4 right-4 z-50 space-y-2"></div>

        <script>
            <c:if test ="${messageSuccess != null}">
            mostrarAlerta("La cuenta ${messageSuccess.numeroCuenta} ha sido creada éxitosamente", 'success');
            </c:if>
            <c:if test ="${messageError != null}">
            mostrarAlerta("${messageError}", 'error');
            </c:if>
        </script>

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

                <dialog id="cuenta" aria-labelledby="dialog-title" class="fixed inset-0 m-0 size-auto max-h-none max-w-none overflow-y-auto bg-transparent p-0 backdrop:bg-transparent">
                    <el-dialog-backdrop class="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"></el-dialog-backdrop>
                    <div tabindex="0" class="flex min-h-full items-end justify-center p-4 text-center focus:outline focus:outline-0 sm:items-center sm:p-0">
                        <el-dialog-panel class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95">
                            <form:form id="form-cuenta" method="POST" modelAttribute="cuenta" 
                                       action="${pageContext.request.contextPath}/cuentas/add"
                                       enctype="multipart/form-data"
                                       class="space-y-4 mt-2">   


                                <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">

                                    <!-- Número de Cuenta -->
                                    <div class="mb-4">
                                        <label for="numeroCuenta" class="block text-sm font-medium text-gray-700 mb-1">
                                            Número de Cuenta
                                        </label>
                                        <input 
                                            type="text"
                                            id="numeroCuenta"
                                            name="numeroCuenta"
                                            maxlength="11"
                                            class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 shadow-sm 
                                            focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all"
                                            placeholder="Ej: ABC12345678"
                                            required
                                            />

                                        <!-- Mensaje de validación -->
                                        <div id="mensajeValidacion" class="mt-2 text-sm hidden">
                                            <p class="text-gray-600 mb-1">Formato requerido:</p>
                                            <ul class="space-y-1">
                                                <li id="validacionLetras" class="flex items-center">
                                                    <span class="w-5 h-5 mr-2">⭕</span>
                                                    <span>3 letras mayúsculas (A-Z)</span>
                                                </li>
                                                <li id="validacionNumeros" class="flex items-center">
                                                    <span class="w-5 h-5 mr-2">⭕</span>
                                                    <span>8 números (0-9)</span>
                                                </li>
                                                <li id="validacionTotal" class="flex items-center">
                                                    <span class="w-5 h-5 mr-2">⭕</span>
                                                    <span>Total: 11 caracteres</span>
                                                </li>
                                            </ul>
                                        </div>

                                        <!-- Mensaje de éxito -->
                                        <p id="mensajeExito" class="mt-2 text-sm text-green-600 font-medium hidden flex items-center">
                                            <svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                            </svg>
                                            Número de cuenta válido
                                        </p>
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
                                            <option value="CORRIENTE">Corriente</option>
                                            <option value="DÉBITO">Débito</option>
                                            <option value="AHORROS">Ahorro</option>
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
                                        id="btnSubmit"
                                        disabled
                                        class="w-full ml-1 bg-green-600 text-white rounded-md px-3 py-2 font-medium 
                                        hover:bg-green-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-all"
                                        >
                                        Crear Cuenta
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
                    <button command="show-modal" commandfor="cuenta" 
                            class="inline-flex items-center bg-teal-500 text-white text-sm py-1 px-3 rounded hover:bg-teal-600"                        >
                        Añadir
                    </button>
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
            const input = document.getElementById('numeroCuenta');
            const mensajeValidacion = document.getElementById('mensajeValidacion');
            const mensajeExito = document.getElementById('mensajeExito');
            const validacionLetras = document.getElementById('validacionLetras');
            const validacionNumeros = document.getElementById('validacionNumeros');
            const validacionTotal = document.getElementById('validacionTotal');
            const btnSubmit = document.getElementById('btnSubmit');

            // Expresión regular: 3 letras mayúsculas + 8 números
            const regexCompleto = /^[A-Z]{3}[0-9]{8}$/;
            const regexLetras = /^[A-Z]{3}/;
            const regexNumeros = /[0-9]{8}$/;

            function actualizarIcono(elemento, valido) {
                const icono = elemento.querySelector('span');
                if (valido) {
                    icono.textContent = '✅';
                    elemento.classList.remove('text-gray-600');
                    elemento.classList.add('text-green-600', 'font-medium');
                } else {
                    icono.textContent = '⭕';
                    elemento.classList.remove('text-green-600', 'font-medium');
                    elemento.classList.add('text-gray-600');
                }
            }

            function validarCuenta(valor) {
                // Mostrar mensaje de validación si hay texto
                if (valor.length > 0) {
                    mensajeValidacion.classList.remove('hidden');
                } else {
                    mensajeValidacion.classList.add('hidden');
                    mensajeExito.classList.add('hidden');
                    return;
                }

                // Validar cada criterio
                const tieneLetras = regexLetras.test(valor);
                const tieneNumeros = regexNumeros.test(valor) && valor.length === 11;
                const longitudCorrecta = valor.length === 11;
                const esValido = regexCompleto.test(valor);

                actualizarIcono(validacionLetras, tieneLetras);
                actualizarIcono(validacionNumeros, tieneNumeros);
                actualizarIcono(validacionTotal, longitudCorrecta);

                // Cambiar borde del input
                if (esValido) {
                    input.classList.remove('border-gray-300', 'border-red-500');
                    input.classList.add('border-green-500');
                    mensajeExito.classList.remove('hidden');
                    mensajeValidacion.classList.add('hidden');
                    btnSubmit.disabled = false;
                } else {
                    input.classList.remove('border-green-500');
                    if (valor.length > 0) {
                        input.classList.add('border-red-500');
                    } else {
                        input.classList.add('border-gray-300');
                    }
                    mensajeExito.classList.add('hidden');
                    btnSubmit.disabled = true;
                }

                return esValido;
            }

            // Validar en tiempo real
            input.addEventListener('input', function (e) {
                let valor = e.target.value.toUpperCase();

                // Forzar formato: solo letras al inicio y números después
                valor = valor.replace(/[^A-Z0-9]/g, '');

                e.target.value = valor;
                validarCuenta(valor);
            });

            // Convertir a mayúsculas automáticamente
            input.addEventListener('keyup', function (e) {
                e.target.value = e.target.value.toUpperCase();
            });

            // Validar al enviar
            document.getElementById('cuentaForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const numeroCuenta = input.value;

                if (validarCuenta(numeroCuenta)) {
                    mostarAlerta('✅ Cuenta válida: ' + numeroCuenta, 'success');

                    // Aquí puedes enviar los datos al backend
                    console.log('Número de cuenta válido:', numeroCuenta);
                } else {
                    mostrarAlerta('❌ Número de cuenta inválido. Debe tener 3 letras mayúsculas seguidas de 8 números.', 'warning');
                }
            });
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