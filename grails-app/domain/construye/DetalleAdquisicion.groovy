package construye

import janus.Item

class DetalleAdquisicion {

    Adquisicion adquisicion
    Item item
    double cantidad
    double precioUnitario
    double subtotal
    String lugar

    static auditable = true
    static mapping = {
        table 'dtad'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtad__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtad__id'
            adquisicion column: 'adqc__id'
            item column: 'item__id'
            cantidad column: 'dtadcntd'
            precioUnitario column: 'dtadpcun'
            subtotal column: 'dtadsbtt'
            lugar column: 'dtadlgar'
        }
    }
    static constraints = {
        adquisicion(blank: false, nullable: false, attributes: [title: 'adquisicion'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precio unitario'])
        subtotal(blank: false, nullable: false, attributes: [title: 'subtotal'])
        lugar(size: 0..63, blank: true, nullable: true, attributes: [title: 'lugar'])
    }


}
