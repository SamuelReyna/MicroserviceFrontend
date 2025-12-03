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
                            <a href="/"  class="text-gray-700 font-semibold">
                                Inicio
                            </a>
                        </li>
                    </ol>
                </nav>

                <div class="overflow-x-auto">

                    <div class="flex items-center justify-center">
                        <a href="/clientes" class="bg-gray-300 hover:bg-teal-200 text-gray-800 font-bold py-2 px-4 rounded-l">
                            Clientes
                        </a>
                        <a href="/cuentas" class="bg-gray-300 hover:bg-teal-200 text-gray-800 font-bold py-2 px-4 rounded-r">
                            Cuentas
                        </a>
                    </div>
                </div>

            </div>
        </div>

    </body>
</html>