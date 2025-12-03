
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

                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <c:if test ="${cuenta != null}">

                            <thead >
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
                                <tr class="border-b border-gray-300 hover:bg-teal-50">
                                    <td class="py-3 px-4 text-gray-600 font-medium">Nombre del Titular</td>
                                    <td class="py-3 px-4 text-gray-700">${cuenta.nombreTitular}</td>
                                </tr>
                                <tr>                          
                                    <td class="py-3 px-4 text-gray-600 font-medium"></td>
                                    <td class="py-3 px-4">
                                        <button id="movimientosBtn"
                                                class="inline-flex items-center gap-2 bg-teal-500 hover:bg-teal-600 text-white text-sm py-2 px-4 rounded transition-all duration-200 transform hover:scale-105" 
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
                                <div class="flex items-center justify-between bg-white border-l-4 ">
                                    Sin movimientos
                                </div>
                            </c:if>

                        </table>
                    </div>
                </div>
            </div>
        </div>
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