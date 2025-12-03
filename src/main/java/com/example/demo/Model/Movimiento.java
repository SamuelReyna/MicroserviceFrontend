package com.example.demo.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.springframework.format.annotation.DateTimeFormat;

public class Movimiento {

    private int id;
    private String tipo;
    private Double monto;
    private String descripcion;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime fecha;

    public Movimiento(int id, String tipo, Double monto, String descripcion, LocalDateTime fecha) {
        this.id = id;
        this.tipo = tipo;
        this.monto = monto;
        this.descripcion = descripcion;
        this.fecha = fecha;
    }

    public Movimiento() {
    }

    public int getId() {
        return id;
    }

    public String getFechaFormateada() {
        if (fecha != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            return fecha.format(formatter);
        }
        return "";
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Double getMonto() {
        return monto;
    }

    public void setMonto(Double monto) {
        this.monto = monto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }
}
