package construye

import janus.Item

class DetalleTransferencia {

    Transferencia transferencia
    Item item
    double cantidad
    double precioUnitario

    static auditable = true
    static mapping = {
        table 'dttr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dttr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dttr__id'
            transferencia column: 'trnf__id'
            item column: 'item__id'
            cantidad column: 'dttrcntd'
            precioUnitario column: 'dttrpcun'
        }
    }
    static constraints = {
        transferencia(blank: false, nullable: false, attributes: [title: 'transferencia'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precio unitario'])
    }
}
