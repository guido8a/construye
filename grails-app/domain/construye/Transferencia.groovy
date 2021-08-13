package construye

import janus.construye.Bodega
import janus.construye.Empresa

class Transferencia {

    Empresa empresa
    Bodega sale
    Bodega recibe
    Date fecha
    String estado
    String observaciones

    static auditable = true
    static mapping = {
        table 'trnf'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'trnf__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'trnf__id'
            empresa column: 'empr__id'
            sale column: 'bdga__id'
            recibe column: 'bdgarcbe'
            fecha column: 'trnffcha'
            estado column: 'trnfetdo'
            observaciones column: 'trnfobsr'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false, attributes: [title: 'empresa'])
        sale(blank: false, nullable: false, attributes: [title: 'sale'])
        recibe(blank: false, nullable: false, attributes: [title: 'recibe'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
        estado(blank: false, nullable: false, attributes: [title: 'estado'])
        observaciones(size: 0..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
    }
}
