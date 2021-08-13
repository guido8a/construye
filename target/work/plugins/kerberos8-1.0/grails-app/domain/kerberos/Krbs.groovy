package kerberos

class Krbs implements Serializable {
    int    usuario
    String login
    String dirIP
    int    prfl
//    String perfil
    String accion
    String controlador
    int    registro
    String dominio
    String tabla
    String actual
//    String anterior
    Date   fecha
    String operacion

    static auditable = false

    static mapping = {
        table 'audt'
        cache usage:'read-only', include:'non-lazy'
        id generator:'identity'
        version false
        columns {
            id column: 'audt__id'

            usuario column:'usro__id'
            login column:'usrologn'
            dirIP column:'audtdrip'
            prfl column:'prfl__id'
//            perfil column:'prfldscr'

            accion column: 'audtaccn'
            controlador column: 'audtctrl'
            registro column: 'audtrgid'
            dominio column:'audtdomn'
            tabla column:'audttbla'
//            campo column:'audtcmpo'

            actual column:'audtactl'
//            anterior column:'audtante'
            fecha column:'audtfcha'
            operacion column: 'audtoprc'
        }
    }

    static constraints = {
        usuario(blank:false, nullable:false)
        login(blank:false, nullable:false)
        dirIP(blank:false, nullable:false)
        prfl(blank:false, nullable:false)
//        perfil(blank:false, nullable:false)

        accion(blank:false, nullable:false)
        controlador(blank:false, nullable:false)
        registro(blank:false, nullable:false)
        dominio(blank:false, nullable:false)
        tabla(blank:false, nullable:false)

        actual(blank:true,nullable:true)
//        anterior(blank:true,nullable:true)
        fecha(blank:true, nullable:true)
        operacion(blank:false, nullable:false)
    }

}
