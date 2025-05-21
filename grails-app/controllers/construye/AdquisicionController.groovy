package construye

import janus.Item
import janus.Parametros
import janus.Persona
import janus.construye.Bodega
import janus.construye.Consumo
import janus.pac.Proveedor
import org.springframework.dao.DataIntegrityViolationException

/**
 * Controlador que muestra las pantallas de manejo de Adquisicion
 */
class AdquisicionController {
    def dbConnectionService

    def adquisicion(){

        def adquisicion
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])
        def listaAdqc = [1: 'Proveedor', 2: 'fecha', 3: 'Estado']
        def listaItems = [1: 'Nombre', 2: 'Código']
        def band = false

        if(params.id){
            adquisicion = Adquisicion.get(params.id)
        }else{

            def existen = Adquisicion.findAllByEstado('N')

            if(existen){
                adquisicion = existen[0]
                band = true
            }else{
                adquisicion = new Adquisicion()
            }
        }

        println "adqc: ${adquisicion?.id}"
        def detalles = []
        if(adquisicion?.id >= 0){
            println "...1"
            detalles = DetalleAdquisicion.findAllByAdquisicion(adquisicion).sort{it.item.nombre}
        }

        println "detalle: ${detalles.size()}"

        return[adquisicion: adquisicion, bodegas: bodegas, detalles:detalles, listaAdqc: listaAdqc, listaItems: listaItems, band: band]
    }

    def listaProveedor() {
        println ("proveedor params " + params)

        def crit = params.buscarPor == '1' ? 'nombre' : 'ruc'

        def proveedores = Proveedor.withCriteria {

            or {
                ilike(crit, "%" + params.criterio + "%")
            }

        }
        [proveedores: proveedores]
    }

    def save(){
        println("params save " + params)

        def usuario = Persona.get(session.usuario.id)
        def bodega = Bodega.get(params.bodega)
        def proveedor = Proveedor.get(params.proveedor)
        def fecha = new Date().parse('dd-MM-yyyy', params.fecha)
        def fechaPago = new Date().parse('dd-MM-yyyy', params.fechaPago)
        def adquisicion

        if(params.id){
            adquisicion = Adquisicion.get(params.id)
        }else{
            adquisicion = new Adquisicion()
            adquisicion.empresa = usuario.empresa
        }

        params.fecha = fecha
        params.fechaPago = fechaPago

        if(params.iva){
            params.iva = params.iva.replaceAll(',', '')
        }else{
            params.iva = 0
        }

        if(params.subtotal){
            params.subtotal = params.subtotal.replaceAll(',', '')
        }else{
            params.subtotal = 0
        }

        if(params.total){
            params.total = params.total.replaceAll(',', '')
        }else{
            params.total = 0
        }

        adquisicion.properties = params
        adquisicion.bodega = bodega
        adquisicion.proveedor = proveedor
        adquisicion.iva = params.iva.toDouble()
        adquisicion.subtotal = params.subtotal.toDouble()
        adquisicion.total = params.iva.toDouble() + params.subtotal.toDouble()

        if(!adquisicion.save(flush: true)){
            println("Error al guardar la adquisicion " + adquisicion.errors)
            render "no"
        }else{
            render "ok_" + adquisicion?.id
        }
    }

    def listaAdquisiciones(){
//        println("params " + params)
//        def crit = params.buscarPor == '1' ? 'nombre' : 'ruc'
//        def orden = params.ordernar == '1' ? 'nombre' : 'ruc'
//        def usuario = Persona.get(session.usuario.id)
//        def empresa = usuario.empresa
//        def adquisiciones = Adquisicion.withCriteria {
//            eq("empresa", empresa)
//            and{
//                proveedor{
//                    ilike(crit, "%" + params.criterio + "%")
//                    order(orden)
//                }
//            }
//        }
//        return[adquisiciones: adquisiciones]


        println "listaAdquisiciones" + params
        def datos;
        def listaAdqc = ['prvenmbr', 'adqcfcha', 'adqcetdo']

        def select = "select adqc__id, prvenmbr, adqcfcha, adqcfcpg, adqcetdo, bdganmbr, adqcobsr " +
                "from adqc, prve, bdga "
        def txwh = "where prve.prve__id = adqc.prve__id and bdga.bdga__id = adqc.bdga__id and " +
                "adqc__id >= 0 "
        def sqlTx = ""
        def bsca = listaAdqc[params.buscarPor.toInteger()-1]
        def ordn = listaAdqc[params.ordenar.toInteger()-1]

        txwh += " and $bsca ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by adqcfcha, ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
//        println "data: ${datos[0]}"
        [data: datos]

    }

    def guardarDetalleAdquisicion_ajax(){
//        println("params guardar " + params)
        def detalle
        def item = Item.get(params.item)
        def adquisicion = Adquisicion.get(params.adquisicion)

        if(params.id){
            detalle = DetalleAdquisicion.get(params.id)
        }else{
            detalle = new DetalleAdquisicion()
        }

        params.precioUnitario = params.precioUnitario.toDouble()
        params.item = item
        params.adquisicion = adquisicion
        params.subtotal = params.cantidad.toDouble() * params.precioUnitario.toDouble()
        params.cantidad = params.cantidad.toDouble()
        detalle.properties = params

        if(!detalle.save(flush:true)){
            println("error al guardar el detalle de adquisicion " + detalle.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def eliminarItem_ajax(){
//        println("params " + params)
        def item = DetalleAdquisicion.get(params.id)

        try{
            item.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el item " + item.errors)
            render "no"
        }
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

    def listaItem_old() {
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

    def anularAdquisicion() {

        def adquisicion = Adquisicion.get(params.id)
        if (!adquisicion) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Consumo con id " + params.id
            redirect(action: "list")
            return
        } else {
            adquisicion.estado = 'A'
            if(!adquisicion.save(flush: true)){
                println("error al anular la adquisicion " + adquisicion.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    } //anular

    def registrar_ajax(){
//        println("params rg " + params)
        def adquisicion = Adquisicion.get(params.id)
        def ivaParametros =  Parametros.get(1)?.iva?.toInteger() / 100
        def detalles = DetalleAdquisicion.findAllByAdquisicion(adquisicion)
        def totalDetalles = Math.round(detalles.subtotal.sum() * 100) / 100
        println("total detalles " + totalDetalles)
        println("iva parametros " + ivaParametros)
        def ivaDetalles = Math.round(totalDetalles/(1+ ivaParametros) * (ivaParametros) *100)/100
        def ivas = adquisicion.iva.toDouble()
        println "Total: ${adquisicion.total}, subtotal: ${adquisicion.subtotal}, iva: ${adquisicion.iva}, ivaDt: $ivaDetalles, totalDetalles: $totalDetalles"

        if(adquisicion.total != totalDetalles){
            render "er_El total de la adquisición es diferente del total de los items"
        }else{
            if(Math.abs(ivaDetalles - adquisicion.iva) <= 0.01){
                adquisicion.estado = 'R'
                if(!adquisicion.save(flush:true)){
                    println("error al registrar la adquisicion " + adquisicion.errors)
                    render "no"
                }else{
                    def sql = "select * from bdga_kardex('${adquisicion?.id}',null,null,1)"
                    def cn = dbConnectionService.getConnection()
                    cn.execute(sql);
                    render "ok"
                }
            }else{
                render "er_El iva de la adquisición no es igual al iva de los items"
            }
        }
    }

    def quitarRegistrar_ajax(){
        def adquisicion = Adquisicion.get(params.id)
        adquisicion.estado = 'N'

        if(!adquisicion.save(flush:true)){
            println("error al desregistrar la adquisicion " + adquisicion.errors )
            render "no"
        }else{
            def sql = "select * from bdga_kardex('${adquisicion?.id}', null, null, -1)"
            def cn = dbConnectionService.getConnection()
            cn.execute(sql);
            render "ok"
        }
    }

    def adquisicionInterna(){

        def adquisicion
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])
        def listaAdqc = [1: 'Proveedor', 2: 'fecha', 3: 'Estado']
        def listaItems = [1: 'Nombre', 2: 'Código']
        def band = false
        def proveedor = Proveedor.findByNombre("Consugez")

        if(params.id){
            adquisicion = Adquisicion.get(params.id)
        }else{

            def existen = Adquisicion.findAllByEstadoAndProveedorAndTipo("N", proveedor, 'E')

            if(existen){
                adquisicion = existen[0]
                band = true
            }else{
                adquisicion = new Adquisicion()
            }
        }

        println "adqc: ${adquisicion?.id}"
        def detalles = []
        if(adquisicion?.id >= 0){
            println "...1"
            detalles = DetalleAdquisicion.findAllByAdquisicion(adquisicion).sort{it.item.nombre}
        }

        println "detalle: ${detalles.size()}"

        return[adquisicion: adquisicion, bodegas: bodegas, detalles:detalles, listaAdqc: listaAdqc, listaItems: listaItems, band: band]
    }


}