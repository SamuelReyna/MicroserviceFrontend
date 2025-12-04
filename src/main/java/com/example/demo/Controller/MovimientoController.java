package com.example.demo.Controller;

import com.example.demo.Model.Movimiento;
import com.example.demo.Model.Transaccion;
import com.example.demo.Utils.Util;
import java.io.IOException;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.DefaultResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("movimiento")
public class MovimientoController {

    public MovimientoController(com.example.demo.Utils.Util util) {
        this.util = util;
    }

    private final Util util;

    @PostMapping("/deposito/{idCuenta}")
    public String Deposito(RedirectAttributes redirectAttributes, @ModelAttribute("movimiento") Movimiento movimiento, @PathVariable("idCuenta") int idCuenta) {

        RestTemplate restTemplate = new RestTemplate();

        restTemplate.setErrorHandler(new DefaultResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) throws IOException {
                return false;
            }
        });
        HttpEntity<Movimiento> entity = new HttpEntity<>(movimiento);
        ResponseEntity<Transaccion> responseEntity
                = restTemplate.exchange(util.url + "/api/cuenta/" + idCuenta + "/depositos",
                        HttpMethod.POST,
                        entity,
                        new ParameterizedTypeReference<Transaccion>() {
                });
        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {
            redirectAttributes.addFlashAttribute("transaccion", responseEntity.getBody());
        } else {
            redirectAttributes.addFlashAttribute("message", responseEntity.getBody());
        }
        return "redirect:/cuentas/detalles/" + idCuenta;
    }

    @PostMapping("/retiro/{idCuenta}")
    public String Retiro(RedirectAttributes redirectAttributes,
            @ModelAttribute("movimiento") Movimiento movimiento,
            @PathVariable("idCuenta") int idCuenta) {

        RestTemplate restTemplate = new RestTemplate();

        // Configurar para que NO lance excepciones en 4xx/5xx
        restTemplate.setErrorHandler(new DefaultResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) throws IOException {
                return false;
            }
        });

        HttpEntity<Movimiento> entity = new HttpEntity<>(movimiento);
        ResponseEntity<Transaccion> responseEntity = restTemplate.exchange(
                util.url + "/api/cuenta/" + idCuenta + "/retiros",
                HttpMethod.POST,
                entity,
                new ParameterizedTypeReference<Transaccion>() {
        }
        );

        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {
            redirectAttributes.addFlashAttribute("transaccion", responseEntity.getBody());
        } else if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(400)) {
            redirectAttributes.addFlashAttribute("message", responseEntity.getBody());
        }

        return "redirect:/cuentas/detalles/" + idCuenta;
    }
}
