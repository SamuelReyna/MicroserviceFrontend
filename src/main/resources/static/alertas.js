function mostrarAlerta(mensaje, tipo) {
    const alertContainer = document.getElementById('alert-container');

    const config = {
        success: {
            bgHeader: 'bg-green-500',
            borderColor: 'border-green-400',
            bgBody: 'bg-green-100',
            textColor: 'text-green-700',
            titulo: 'Éxito'
        },
        error: {
            bgHeader: 'bg-red-500',
            borderColor: 'border-red-400',
            bgBody: 'bg-red-100',
            textColor: 'text-red-700',
            titulo: 'Error'
        },
        warning: {
            bgHeader: 'bg-yellow-500',
            borderColor: 'border-yellow-400',
            bgBody: 'bg-yellow-100',
            textColor: 'text-yellow-700',
            titulo: 'Advertencia'
        }
    };

    const alertConfig = config[tipo] || config.success;

    const alert = document.createElement('div');
    alert.className = 'alert-animation';
    alert.innerHTML = `
       <div role="alert" class="w-96 shadow-lg">
           <div class="${alertConfig.bgHeader} text-white font-bold rounded-t px-4 py-2">
                ${alertConfig.titulo}
           </div>
           <div class="border border-t-0 ${alertConfig.borderColor} rounded-b ${alertConfig.bgBody} px-4 py-3 ${alertConfig.textColor}">
               <p>${mensaje}</p>
           </div>
       </div>
    `;

    alertContainer.appendChild(alert);

    setTimeout(() => {
        alert.style.opacity = '0';
        alert.style.transform = 'translateX(100%)';
        setTimeout(() => alert.remove(), 300);
    }, 5000);
}


