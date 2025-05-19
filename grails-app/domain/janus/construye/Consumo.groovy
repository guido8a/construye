package janus.construye

import construye.TipoConsumo
import janus.Obra
import janus.Persona

class Consumo implements Serializable{
    Empresa empresa
    Obra obra
    Bodega bodega
    TipoConsumo tipoConsumo
    Persona transporta
    Persona recibe
    Consumo padre
    Date fecha
    Date fechaModificacion
    String estado
    String observaciones
    String descripcion
    Persona aprueba

        static auditable=[ignore:[]]
        static mapping = {
            table 'cnsm'
            cache usage:'read-write', include:'non-lazy'
            id column:'cnsm__id'
            id generator:'identity'
            version false
            columns {
                id column:'cnsm__id'
                empresa column: 'empr__id'
                obra column: 'obra__id'
                bodega column: 'bdga__id'
                tipoConsumo column: 'tpcs__id'
                transporta column: 'prsntrnp'
                recibe column: 'prsnrcbe'
                padre column: 'cnsmpdre'
                fecha column: 'cnsmfcha'
                fechaModificacion column: 'cnsmfcmd'
                estado column: 'cnsmetdo'
                observaciones column: 'cnsmobsr'
                descripcion column: 'cnsmdscr'
                aprueba column: 'prsnaprb'
            }
        }
        static constraints = {
            fecha(blank:false, nullable:false )
            fechaModificacion(blank:true, nullable:true )
            padre(blank:true, nullable:true )
            estado(blank:false, nullable:false )
            observaciones(blank:true, nullable:true )
            descripcion(blank:true, nullable:true )
        }
        String toString(){
            "${this.bodega.nombre} (${this.fecha})"
        }
}
