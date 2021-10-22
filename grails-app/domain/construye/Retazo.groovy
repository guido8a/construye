package construye

import janus.Item
import janus.construye.Bodega

class Retazo {

    Retazo padre
    Bodega bodega
    Item item
    double cantidad
    Date fecha
    String estado = 'A'
    Date fechaFin

    static auditable = true
    static mapping = {
        table 'rtzo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rtzo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rtzo__id'
            padre column: 'rtzopdre'
            bodega column: 'bdga__id'
            item column: 'item__id'
            fecha column: 'rtzofcha'
            cantidad column: 'rtzocntd'
            estado column: 'rtzoetdo'
            fechaFin column: 'rtzofcfn'
        }
    }
    static constraints = {
        padre(blank: true, nullable: true, attributes: [title: 'padre'])
        bodega(blank: false, nullable: false, attributes: [title: 'bodega'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fecha fin'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
        estado(blank: false, nullable: false, attributes: [title: 'estado'])
    }
}
