package com.example.demo.Model;

public class Transaccion {

    private int id;
    private Cuenta cuenta;
    private Double saldoAnterior;
    private Double saldoNuevo;
    private String operacion;
    private String mensaje;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cuenta getCuenta() {
        return cuenta;
    }

    public void setCuenta(Cuenta cuenta) {
        this.cuenta = cuenta;
    }

    public Double getSaldoAnterior() {
        return saldoAnterior;
    }

    public void setSaldoAnterior(Double saldoAnterior) {
        this.saldoAnterior = saldoAnterior;
    }

    public Double getSaldoNuevo() {
        return saldoNuevo;
    }

    public void setSaldoNuevo(Double saldoNuevo) {
        this.saldoNuevo = saldoNuevo;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Transaccion(int id, Cuenta cuenta, Double saldoAnterior, Double saldoNuevo, String operacion, String mensaje) {
        this.id = id;
        this.cuenta = cuenta;
        this.saldoAnterior = saldoAnterior;
        this.saldoNuevo = saldoNuevo;
        this.operacion = operacion;
        this.mensaje = mensaje;
    }

    public Transaccion() {
    }

}
