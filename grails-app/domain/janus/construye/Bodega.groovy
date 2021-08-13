package janus.construye

class Bodega implements Serializable{
    Empresa empresa
    String nombre
    String descripcion
    String direccion
    String telefono
    String tipo /* T: para uso en transferencias */

        static auditable=[ignore:[]]
        static mapping = {
            table 'bdga'
            cache usage:'read-write', include:'non-lazy'
            id column:'bdga__id'
            id generator:'identity'
            version false
            columns {
                id column:'bdga__id'
                empresa column: 'empr__id'
                nombre column: 'bdganmbr'
                descripcion column: 'bdgadscr'
                direccion column: 'bdgadire'
                telefono column: 'bdgatelf'
                tipo column: 'bdgatipo'
            }
        }
        static constraints = {
            nombre(size:1..63, blank:false, nullable:false )
            descripcion(size:3..255, blank:true, nullable:true )
            direccion(size:3..255, blank:true, nullable:true )
            telefono(blank:true, nullable:true )
            tipo(blank:false, nullable:false )
        }
        String toString(){
            "${this.nombre}"
        }
}
