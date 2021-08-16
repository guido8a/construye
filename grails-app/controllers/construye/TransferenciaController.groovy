package construye

import janus.Item
import janus.Persona
import janus.construye.Bodega


/**
 * Controlador que muestra las pantallas de manejo de Transferencia
 */
class TransferenciaController {

    def dbConnectionService

    def transferencia(){

        def transferencia
        def bodegasSale = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])
        def bodegasRecibe = Bodega.findAllByTipo('T',[sort: 'nombre'])
        def listaTransferencia = [1: 'Bodega Sale', 2: 'Bodega Recibe', 3: 'Fecha']
        def listaItems = [1: 'Nombre', 2: 'Código']
        def detallesTransferencia = []

        if(params.id){
            transferencia = Transferencia.get(params.id)
        }else{
            transferencia = new Transferencia()
        }

        if(transferencia?.id){
            detallesTransferencia = DetalleTransferencia.findAllByTransferencia(transferencia).sort{it.item.nombre}
        }


        return[transferencia:transferencia, bodegaSale: bodegasSale, bodegaRecibe: bodegasRecibe, listaTransferencia: listaTransferencia, listaItems: listaItems , detalles: detallesTransferencia]
    }

    def save(){
        println("params sav " + params)
        def transferencia
        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def bodegaSale = Bodega.get(params.sale)
        def bodegaRecibe = Bodega.get(params.recibe)
        def fecha = new Date().parse('dd-MM-yyyy', params.fecha)

        if(params.id){
            transferencia = Transferencia.get(params.id)
        }else{
            transferencia = new Transferencia()
            transferencia.empresa = empresa
            transferencia.estado = 'N'
        }

        transferencia.recibe = bodegaRecibe
        transferencia.sale = bodegaSale
        transferencia.fecha = fecha
        transferencia.observaciones = params.observaciones

        if(!transferencia.save(flush:true)){
            println("error al guardar la transferencia " + transferencia.errors)
            render "no"
        }else{
            render "ok_" + transferencia?.id
        }
    }

    def listaTransferencia(){

//        println("params buscar tr " + params)

        def crit = params.buscarPor == '1' ? 'sale' : 'recibe'

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def transferencias = Transferencia.withCriteria {
            eq("empresa", empresa)
            and{
                if(params.buscarPor == '1'){
                    sale{
                        ilike("descripcion", "%" + params.criterio + "%")
                    }
                }else{
                    recibe{
                        ilike("descripcion", "%" + params.criterio + "%")
                    }
                }

            }
            order("fecha")
        }

        return[transferencias: transferencias]
    }

    def listaItem() {
        println "listaItem" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select item.item__id, itemcdgo, itemnmbr, unddcdgo " +
                "from item, undd, dprt, sbgr "
        def txwh = "where tpit__id = 1 and undd.undd__id = item.undd__id and dprt.dprt__id = item.dprt__id and " +
                "sbgr.sbgr__id = dprt.sbgr__id "
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%' and grpo__id = ${params.grupo}"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos[0]}"
        [data: datos]
    }

    def guardarDetalleTransferencia_ajax(){
        println("params gdt " + params)
        def transferencia = Transferencia.get(params.transferencia)
        def item = Item.get(params.item)
        def detalleTransferencia

        if(params.id){
            detalleTransferencia = DetalleTransferencia.get(params.id)
        }else{
            detalleTransferencia = new DetalleTransferencia()
        }

        detalleTransferencia.item =  item
        detalleTransferencia.transferencia = transferencia
        detalleTransferencia.precioUnitario = params.precioUnitario.toDouble()
        detalleTransferencia.cantidad = params.cantidad.toDouble()

        if(!detalleTransferencia.save(flush:true)){
            println("error al guardar el detalle de transferencia " + detalleTransferencia.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def eliminarItem_ajax(){
        println("params borrar item " + params)
        def detalle = DetalleTransferencia.get(params.id)

        try{
            detalle.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el detalle de transferencia " + detalle.errors)
            render "no"
        }
    }

    def quitarRegistrar_ajax(){
        def transferencia = Transferencia.get(params.id)
        transferencia.estado = 'N'

        if(!transferencia.save(flush:true)){
            println("error al desregistrar la trasnferencia " + transferencia.errors)
            render "no"
        }else{
            def sql = "select * from bdga_kardex(null,'${transferencia?.id}',null,-1)"
            def cn = dbConnectionService.getConnection()
            cn.execute(sql);
            render "ok"
        }
    }

    def registrar_ajax(){
        def transferencia = Transferencia.get(params.id)
        transferencia.estado = 'R'

        def sql = "select * from bdga_kardex(null,'${transferencia?.id}',null,1)"
        def cn = dbConnectionService.getConnection()
        cn.execute(sql);

        if(!transferencia.save(flush:true)){
            println("error al registrar la trasnferencia " + transferencia.errors)
            render "no"
        }else{
            render "ok"
        }
    }

}
