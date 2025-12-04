<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Clientes</title>
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
                                                       class="inline-block bg-teal-500 hover:bg-teal-600 text-white text-sm py-2 px-4 rounded transition-all duration-200 transform">
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
    </body>
</html>