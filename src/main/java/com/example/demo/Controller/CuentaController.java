package com.example.demo.Controller;

import com.example.demo.Model.Cuenta;
import com.example.demo.Model.Movimiento;
import com.example.demo.Utils.Util;
import java.util.List;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("cuentas")
public class CuentaController {

    private final Util util;

    public CuentaController(Util util) {
        this.util = util;
    }

    @GetMapping
    public String ListAccounts(Model model) {

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<List<Cuenta>> responseEntity
                = restTemplate.exchange(util.url + "/api/cuenta",
                        HttpMethod.GET,
                        HttpEntity.EMPTY,
                        new ParameterizedTypeReference<List<Cuenta>>() {
                });

        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {
            List<Cuenta> cuentas = responseEntity.getBody();
            model.addAttribute("cuentas", cuentas);
        } else {
            model.addAttribute("cuentas", null);

        }

        return "cuentas";
    }

    @GetMapping("/detalles/{id}")
    public String DetallesAccount(Model model, @PathVariable("id") int idCuenta) {

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Cuenta> responseEntity
                = restTemplate.exchange(util.url + "/api/cuenta/" + idCuenta,
                        HttpMethod.GET,
                        HttpEntity.EMPTY,
                        new ParameterizedTypeReference<Cuenta>() {
                });

        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {
            Cuenta cuenta = responseEntity.getBody();
            ResponseEntity<List<Movimiento>> responseMovimiento
                    = restTemplate.exchange(util.url + "/api/cuenta/" + idCuenta + "/movimientos",
                            HttpMethod.GET,
                            HttpEntity.EMPTY,
                            new ParameterizedTypeReference<List<Movimiento>>() {
                    });
            if (responseMovimiento.getStatusCode() == HttpStatusCode.valueOf(200)) {
                List<Movimiento> movimientos = responseMovimiento.getBody();
                model.addAttribute("movimientos", movimientos);
            } else {
                model.addAttribute("movimientos", null);
            }

            model.addAttribute("cuenta", cuenta);
        } else {
            model.addAttribute("cuenta", null);
        }
        return "detalles";
    }

}
