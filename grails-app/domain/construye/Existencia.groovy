package construye

import janus.Item
import janus.construye.Bodega

class Existencia {

    Bodega bodega
    Item item
    double cantidad
    Date fecha
    double inicial
    double precioUnitario

    static auditable = true
    static mapping = {
        table 'exst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'exst__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'exst__id'
            bodega column: 'bdga__id'
            item column: 'item__id'
            cantidad column: 'exstfcha'
            inicial column: 'exst_ini'
            precioUnitario column: 'exstpcun'
        }
    }
    static constraints = {
        bodega(blank: false, nullable: false, attributes: [title: 'bodega'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        inicial(blank: false, nullable: false, attributes: [title: 'inicial'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'precio unitario'])
    }
}
