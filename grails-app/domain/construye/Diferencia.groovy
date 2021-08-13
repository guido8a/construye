package construye

import janus.Item
import janus.construye.Bodega

class Diferencia {

    Bodega bodega
    Item item
    Date fecha
    double cantidad

    static auditable = true
    static mapping = {
        table 'diff'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'diff__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'diff__id'
            bodega column: 'bdga__id'
            item column: 'item__id'
            fecha column: 'difffcha'
            cantidad column: 'diffcntd'
        }
    }
    static constraints = {
        bodega(blank: false, nullable: false, attributes: [title: 'bodega'])
        item(blank: false, nullable: false, attributes: [title: 'item'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
        cantidad(blank: false, nullable: false, attributes: [title: 'cantidad'])
    }
}
