package com.example.demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("clientes")
public class ClienteController {

    @GetMapping("/buscar")
    public String Inicio(Model model) {
        return "buscarCuenta";
    }

    @GetMapping
    public String Clientes() {
        return "clientes";
    }
}
