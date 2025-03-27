package construye

import janus.Composicion
import janus.Item
import janus.construye.Consumo

class DetalleConsumo {

    Consumo consumo
    Composicion composicion
    Item item
    double cantidad
    double precioUnitario

    static auditable = true
    static mapping = {
        table 'dtcs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtcs__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtcs__id'
            consumo column: 'cnsm__id'
            item column: 'item__id'
            composicion column: 'comp__id'
            cantidad column: 'dtcscntd'
            precioUnitario column: 'dtcspcun'
        }
    }
    static constraints = {
        consumo(blank: true, nullable: true, attributes: [title: 'consumo'])
        item(blank: false, nullable: false, attributes: [title: 'consumo'])
        composicion(blank: true, nullable: true, attributes: [title: 'composicion'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precio unitario'])
    }
}
