package construye

class TipoConsumo implements Serializable {
//    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'tpcs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpcs__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpcs__id'
            descripcion column: 'tpcsdscr'
        }
    }
    static constraints = {
//        codigo(size: 1..1, blank: false, attributes: [title: 'numero'])
        descripcion(size: 1..20, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}