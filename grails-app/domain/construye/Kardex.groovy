package construye

import janus.Item
import janus.construye.Bodega
import janus.construye.Consumo


class Kardex {

    Item item
    Adquisicion adquisicion
    Consumo consumo
    Transferencia transferencia
    Bodega bodega
    double cantidad
    double precioUnitario
    Date fecha
    double existencias
    String tipo

    static mapping = {
        table 'krdx'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'krdx__id'
        id generator: 'identity'
        version false

        columns {
            item column: 'item__id'
            adquisicion column: 'adqc__id'
            consumo column: 'cnsm__id'
            transferencia column: 'trnf__id'
            bodega column: 'bdga__id'
            cantidad column: 'krdxcntd'
            precioUnitario column: 'krdxpcun'
            fecha column: 'krdxfcha'
            existencias column: 'krdxexst'
            tipo column: 'krdxtipo'
        }
    }
    static constraints = {
        item(blank: false, nullable: false, attributes: [title: 'Item'])
        adquisicion(blank: true, nullable: true,attributes: [title: 'Adquisición'])
        consumo(blank: true, nullable: true,attributes: [title: 'Consumo'])
        transferencia(blank: true, nullable: true,attributes: [title: 'Transferencia'])
        bodega(blank: false, nullable: false, attributes: [title: 'Bodega'])
        cantidad(blank: false, nullable: false)
        precioUnitario(blank: false, nullable: false)
        existencias(blank: false, nullable: false)
        tipo(blank: false, nullable: false)
    }
}
