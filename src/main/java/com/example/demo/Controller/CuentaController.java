package com.example.demo.Controller;

import com.example.demo.Model.CrearCuenta;
import com.example.demo.Model.Cuenta;
import com.example.demo.Model.Movimiento;
import com.example.demo.Utils.Util;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("cuentas")
public class CuentaController {

    private final Util util;

    public CuentaController(Util util) {
        this.util = util;
    }

    @GetMapping
    public String ListAccounts(Model model, @RequestParam(name = "tipo", required = false) String tipo, @RequestParam(name = "activa", required = false) Boolean activa) {
        String url = util.url + "/api/cuenta";
        if (tipo != null && activa == null) {
            url = url + "?tipo=" + tipo;
        }
        if (tipo == null && activa != null) {
            url = url + "?activa=" + activa;
        }
        if (tipo != null && activa != null) {
            url = url + "?tipo=" + tipo + "&activa=" + activa;
        }
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<List<Cuenta>> responseEntity
                = restTemplate.exchange(url,
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

    @GetMapping("/list")
    public ResponseEntity<List<Cuenta>> cuentas(@RequestParam(name = "tipo", required = false) String tipo, @RequestParam(name = "activa", required = false) Boolean activa) {

        try {
            RestTemplate restTemplate = new RestTemplate();
            String url = util.url + "/api/cuenta";
            if (tipo != null && activa == null) {
                url = url + "?tipo=" + tipo;
            }
            if (tipo == null && activa != null) {
                url = url + "?activa=" + activa;
            }
            if (tipo != null && activa != null) {
                url = url + "?tipo=" + tipo + "&activa=" + activa;
            }

            ResponseEntity<List<Cuenta>> responseEntity
                    = restTemplate.exchange(url,
                            HttpMethod.GET,
                            HttpEntity.EMPTY,
                            new ParameterizedTypeReference<List<Cuenta>>() {
                    });
            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    @GetMapping("/detalles/{id}")
    public String DetallesAccount(Model model,
            @PathVariable("id") int idCuenta,
            @RequestParam(name = "fechaInicio", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate fechaInicio,
            @RequestParam(name = "fechaFin", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate fechaFin
    ) {

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Cuenta> responseEntity
                = restTemplate.exchange(util.url + "/api/cuenta/" + idCuenta,
                        HttpMethod.GET,
                        HttpEntity.EMPTY,
                        new ParameterizedTypeReference<Cuenta>() {
                });

        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {

            String url = util.url + "/api/cuenta/" + idCuenta + "/movimientos";
            if (fechaInicio != null && fechaFin != null) {
                if (fechaFin.isBefore(fechaInicio)) {
                    fechaFin = null;
                    fechaInicio = null;
                }
            }

            if (fechaInicio != null && fechaFin == null) {
                url = url + "?fechaInicio=" + fechaInicio;
            }
            if (fechaFin != null && fechaInicio == null) {
                url = url + "?fechaFin=" + fechaFin;
            }
            if (fechaInicio != null && fechaFin != null) {
                url = url + "?fechaInicio=" + fechaInicio + "&fechaFin=" + fechaFin;
            }

            Cuenta cuenta = responseEntity.getBody();
            ResponseEntity<List<Movimiento>> responseMovimiento
                    = restTemplate.exchange(url,
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

    @PostMapping("/desactivar-cuenta")
    public ResponseEntity DesactivarCuenta(
            @RequestParam(name = "id", required = true) int id
    ) {

        RestTemplate restTemplate = new RestTemplate();

        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpComponentsClientHttpRequestFactory requestFactory
                = new HttpComponentsClientHttpRequestFactory(httpClient);

        restTemplate.setRequestFactory(requestFactory);

        try {
            ResponseEntity<Map> responseEntity
                    = restTemplate.exchange(
                            util.url + "/api/cuenta/" + id + "/desactivar",
                            HttpMethod.PATCH,
                            HttpEntity.EMPTY,
                            Map.class);

            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getLocalizedMessage());
        }
    }

    @PostMapping("/add")
    public String Add(@ModelAttribute("cuenta") CrearCuenta cuenta, RedirectAttributes redirectAttributes) {
        RestTemplate restTemplate
                = new RestTemplate();
        HttpEntity<CrearCuenta> entity = new HttpEntity<>(cuenta);

        ResponseEntity<Cuenta> responseEntity
                = restTemplate.exchange(util.url + "/api/cuenta", HttpMethod.POST,
                        entity,
                        new ParameterizedTypeReference<Cuenta>() {
                });

        if (responseEntity.getStatusCode() == HttpStatusCode.valueOf(200)) {
            redirectAttributes.addFlashAttribute("message", "Cuenta creada exitosamente");
        } else {
            redirectAttributes.addFlashAttribute("message", "Algo salió mal, intentalo nuevamente");
        }
        return "redirect:/cuentas";
    }

}
