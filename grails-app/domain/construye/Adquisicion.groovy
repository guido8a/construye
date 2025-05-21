package construye

import janus.pac.Proveedor
import janus.construye.Bodega
import janus.construye.Empresa

class Adquisicion {

    Bodega bodega
    Proveedor proveedor
    Empresa empresa
    Date fecha
    String estado
    Date fechaPago
    String observaciones
    double subtotal
    double iva
    double total
    String  tipo

    static auditable = true
    static mapping = {
        table 'adqc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'adqc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'adqc__id'
            bodega column: 'bdga__id'
            proveedor column: 'prve__id'
            empresa column: 'empr__id'
            fecha column: 'adqcfcha'
            estado column: 'adqcetdo'
            fechaPago column: 'adqcfcpg'
            observaciones column: 'adqcobsr'
            subtotal column: 'adqcsbtt'
            iva column: 'adqc_iva'
            total column: 'adqctotl'
            tipo column: 'adqctipo'
        }
    }
    static constraints = {
        bodega(blank: false, nullable: false, attributes: [title: 'bodega'])
        proveedor(blank: false, nullable: false, attributes: [title: 'precio venta'])
        empresa(blank: false, nullable: false, attributes: [title: 'empresa'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        fechaPago(blank: true, nullable: true, attributes: [title: 'fecha pago'])
        observaciones(size: 0..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        subtotal(blank: true, nullable: true, attributes: [title: 'fecha pago'])
        iva(blank: true, nullable: true, attributes: [title: 'fecha pago'])
        total(blank: true, nullable: true, attributes: [title: 'fecha pago'])
        tipo(blank: true, nullable: true)
    }
}
