package construye

import janus.Canton
import janus.Composicion
import janus.Comunidad
import janus.Departamento
import janus.DepartamentoItem
import janus.Direccion
import janus.Grupo
import janus.Item
import janus.Obra
import janus.Parametros
import janus.Parroquia
import janus.Persona
import janus.PrecioRubrosItems
import janus.Rubro
import janus.SubgrupoItems
import janus.TipoItem
import janus.VolumenesObra
import janus.construye.Bodega
import janus.construye.Consumo
import janus.construye.Empresa
import org.springframework.dao.DataIntegrityViolationException

class ConsumoController extends janus.seguridad.Shield {

    def index() { }

    def buscadorService
    def dbConnectionService

    def consumo() {
        println "consumo params: $params"
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])
        def listaConsumo = [1: 'Obra', 2: 'Bodega', 3: 'Recibe (Apellido)', 4: 'Fecha']
        def listaObra = [1: 'Obra', 2: 'Código']
        def listaItems = [1: 'Nombre', 2: 'Código']
        def dpto = Departamento.findAllByPermisosIlike("APU")
        def recibe = Persona.findAllByDepartamentoInList(dpto)
        def consumo
        def items = []

//        println "depto "+dpto
        if (params.id) {
            consumo = Consumo.get(params.id)
        }

        if(consumo){
            items = DetalleConsumo.findAllByConsumo(consumo).sort{it.composicion.item.nombre}
        }

        [consumo: consumo, recibe: recibe, bodegas:bodegas, listaCnsm: listaConsumo, listaItems: listaItems,
         listaObra: listaObra, items: items ]
    }

    def save() {
        println "save consumo " + params
        def consumo
        def prsn = Persona.get(session.usuario.id)
        def fecha = new Date().parse('dd-MM-yyyy', params.fecha)
        def tipoConsumo = TipoConsumo.get(1)
        params.remove("obra")
        params.remove("fecha")
        if (params.id) {
            consumo = Consumo.get(params.id)
            consumo.properties = params
        } else {
            consumo = new Consumo(params)
        }

        consumo.fechaModificacion = new Date()
        consumo.empresa = prsn.empresa
        consumo.obra = Obra.get(params.obra__id)
        consumo.fecha = fecha
        consumo.observaciones = params.observaciones
        consumo.tipoConsumo = tipoConsumo

        println "fecha: $fecha --> ${consumo.fecha}"
        if (!consumo.save(flush: true)) {
            println "error " + consumo.errors
        }

        redirect(action: 'consumo', params: [id: consumo.id])
    } //save


    def listaConsumo() {
        println "listaConsumo" + params
        def datos;
        def listaConsumo = ['obranmbr', 'bdga.bdganmbr', 'prsnapll', 'cnsmfcha::text']

        def select = "select cnsm__id, obracdgo, obranmbr, cnsmfcha, cnsmetdo, bdganmbr, " +
                "prsnnmbr||' '||prsnapll recibe " +
                "from cnsm, obra, bdga, prsn rcbe "
        def txwh = "where obra.obra__id = cnsm.obra__id and bdga.bdga__id = cnsm.bdga__id and " +
                "rcbe.prsn__id = cnsm.prsnrcbe and cnsm.tpcs__id = 1 "
        def sqlTx = ""
        def bsca = listaConsumo[params.buscarPor.toInteger()-1]
        def ordn = listaConsumo[params.ordenar.toInteger()-1]

        txwh += " and $bsca ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
//        println "data: ${datos[0]}"
        [data: datos]
    }

    def listaObra() {
        println "listaObra" + params
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr " +
                "from obra "
        def txwh = "where obra.obra__id in (select obra__id from comp) "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger()-1]
        def ordn = listaObra[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo:params.consumo]
    }

    def listaObraRqsc() {
        println "listaObra" + params
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr " +
                "from obra "
        def txwh = "where obra.obra__id in (select obra__id from cnsm where tpcs__id = 1 and cnsmetdo = 'R') "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger()-1]
        def ordn = listaObra[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo:params.consumo]
    }

    def listaItem() {
        println "listaItem" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select * from rp_existencias(${params.grupo}, ${params.bdga}) rp, comp "
        def txwh = "where comp.item__id = rp.item__id and exstcntd > 0 and obra__id = ${params.obra} "
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%' "

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos[0]}"
        [data: datos]
    }

    def listaItemDvlc() {
        println "listaItemDvlc" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos
        def reqc = params.consumo
        def select = "select dtcs.comp__id, item.item__id, itemcdgo, itemnmbr, dtcscntd, dtcspcun, unddcdgo " +
                "from cnsm d, cnsm pdre, dtcs, comp, item, undd "
        def txwh = "where pdre.cnsm__id = d.cnsmpdre and d.cnsm__id = ${reqc} and item.item__id = comp.item__id and " +
                "comp.comp__id = dtcs.comp__id and dtcs.cnsm__id = pdre.cnsm__id and " +
                "undd.undd__id = item.undd__id and pdre.cnsmetdo = 'R' "
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

    def verificaItem(){
        println "verifica rubro "+params
        def comp = Composicion.get(params.id)
        def item = comp.item
        def respuesta = "<ul>"
//        println "vol... obras:  ${obras}"
        if(item?.codigo?.size()>0) {
            render "ok"
        } else {
            render "0"
        }
    }

    def guardarDetalleConsumo_ajax(){
//        println("params dt " + params)
        def detalle
        def composicion = Composicion.get(params.composicion)
        def consumo = Consumo.get(params.consumo)

        if(params.id){
            detalle = DetalleConsumo.get(params.id)
        }else{

            def detalles = DetalleConsumo.findAllByConsumo(consumo)

            if(detalles){
                if(composicion.item in detalles.composicion.item){
                    render "er_El item seleccionado ya se encuentra agregado"
                    return false;
                }else{
                    detalle = new DetalleConsumo()
                }
            }else{
                detalle = new DetalleConsumo()
            }
        }

        if(consumo?.padre){
            def det2 = DetalleConsumo.findByConsumoAndComposicion(consumo.padre, composicion)
//        println("cantidad original " + det2?.cantidad)

            if(params.cantidad.toDouble() > det2?.cantidad){
                render "er_La cantidad ingresada es mayor a " + det2?.cantidad
            }else{
                detalle.composicion = composicion
                detalle.consumo = consumo
                detalle.precioUnitario = params.precioUnitario.toDouble()
                detalle.cantidad = params.cantidad.toDouble()

                if(!detalle.save(flush:true)){
                    println("error al guardar el detalle de consumo " + errors)
                    render "no"
                }else{
                    render "ok"
                }
            }
        }else{
            detalle.composicion = composicion
            detalle.consumo = consumo
            detalle.precioUnitario = params.precioUnitario.toDouble()
            detalle.cantidad = params.cantidad.toDouble()

            if(!detalle.save(flush:true)){
                println("error al guardar el detalle de consumo " + errors)
                render "no"
            }else{
                render "ok"
            }
        }






    }

    def eliminarItem_ajax(){
//        println("params " + params)
        def item = DetalleConsumo.get(params.id)

        try{
            item.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el item " + item.errors)
            render "no"
        }
    }

    def registrar_ajax(){
        def consumo = Consumo.get(params.id)
        consumo.estado = 'R'
        if(!consumo.save(flush:true)){
            println("error al registrar el consumo/devolucion " + consumo.errors)
            render "no"
        }else{
            def sql = "select * from bdga_kardex(null, null, '${consumo?.id}', 1)"
            def cn = dbConnectionService.getConnection()
            cn.execute(sql);
            render "ok"
        }
    }

    def quitarRegistrar_ajax(){
        def consumo = Consumo.get(params.id)
        def existe = Consumo.findAllByPadre(consumo)

        if(existe){
            render "er"
        }else{
            consumo.estado = 'N'
            if(!consumo.save(flush:true)){
                println("error al desregistrar el consumo " + consumo.errors)
                render "no"
            }else{
                def sql = "select * from bdga_kardex(null, null, '${consumo?.id}', -1)"
                def cn = dbConnectionService.getConnection()
                cn.execute(sql);
                render "ok"
            }
        }

    }

    def devolucion(){
        println("Devoluciones " + params)
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])
        def listaConsumo = [1: 'Obra', 2: 'Bodega', 3: 'Recibe (Apellido)', 4: 'Fecha']
        def listaObra = [1: 'Obra', 2: 'Código']
        def listaItems = [1: 'Nombre', 2: 'Código']
        def dpto = Departamento.findAllByPermisosIlike("APU")
        def recibe = Persona.findAllByDepartamentoInList(dpto)
        def consumo
        def items = []

//        println "depto "+dpto
        if (params.id) {
            consumo = Consumo.get(params.id)
        }

        if(consumo){
            items = DetalleConsumo.findAllByConsumo(consumo).sort{it.composicion.item.nombre}
        }

        [consumo: consumo, recibe: recibe, bodegas:bodegas, listaCnsm: listaConsumo, listaItems: listaItems,
         listaObra: listaObra, items: items ]
    }


    def listaDevoluciones() {
        println "listaDev" + params
        def datos;
        def listaConsumo = ['obranmbr', 'bdga.bdganmbr', 'prsnapll', 'cnsmfcha::text']

        def select = "select cnsm__id, obracdgo, obranmbr, cnsmfcha, cnsmetdo, bdganmbr, " +
                "prsnnmbr||' '||prsnapll recibe " +
                "from cnsm, obra, bdga, prsn rcbe "
        def txwh = "where obra.obra__id = cnsm.obra__id and bdga.bdga__id = cnsm.bdga__id and " +
                "rcbe.prsn__id = cnsm.prsnrcbe and cnsm.tpcs__id = 2 "
        def sqlTx = ""
        def bsca = listaConsumo[params.buscarPor.toInteger()-1]
        def ordn = listaConsumo[params.ordenar.toInteger()-1]

        txwh += " and $bsca ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
//        println "data: ${datos[0]}"
        [data: datos]
    }

    def requisicion_ajax(){
        println("params requisicion_ajax " + params)
        def obra = Obra.get(params.id)
        def tipoConsumo = TipoConsumo.get(1)
        def requisiciones = Consumo.findAllByObraAndTipoConsumoAndEstado(obra, tipoConsumo, 'R')
        println("requisiciones " + requisiciones)
        def consumo = new Consumo()
        def items = []
        if(params.consumo){
            consumo = Consumo.get(params.consumo)
            items = DetalleConsumo.findAllByConsumo(consumo)
        }
        return[requisiciones: requisiciones, consumo: consumo, items:items]
    }

    def bodega_ajax(){
        println("params " + params)
        def requisicion
        def bodega
        if(params.id){
            requisicion = Consumo.get(params.id)
            bodega = requisicion.bodega
        }else{
            bodega = ''
        }
        return[bodega:bodega]
    }

    def guardarDevolucion_ajax(){
        println("params save dev " + params)
        def persona = Persona.get(session.usuario.id)
        def empresa = persona.empresa
        def devolucion
        def obra = Obra.get(params.obra__id)
        def fecha = new Date().parse('dd-MM-yyyy', params.fecha)
        def tipoConsumo = TipoConsumo.get(2)
        def bodega = Bodega.get(params.bodega)
        def padre = Consumo.get(params.requisicion_name)

        if(params.id){
            devolucion = Consumo.get(params.id)
        }else{
            devolucion = new Consumo()
            devolucion.estado = 'N'
            devolucion.empresa = empresa
            devolucion.tipoConsumo = tipoConsumo
        }

        devolucion.obra = obra
        devolucion.bodega = bodega
        devolucion.fecha = fecha
        devolucion.fechaModificacion = new Date()
        devolucion.padre = padre
        devolucion.recibe = Persona.get(params.recibe)
        devolucion.transporta = Persona.get(params.transporta)
        devolucion.observaciones = params.observaciones

        if(!devolucion.save(flush:true)){
            println("error al guardar la devolucion " + devolucion.errors)
            render "no"
        }else{
            render "ok_" + devolucion?.id
        }
    }


    def guardarRequisicion_ajax(){
//        println("params gur " + params)
        def consumo = Consumo.get(params.id)
        def requisicion = Consumo.get(params.req)

        consumo.padre = requisicion

        if(!consumo.save(flush:true)){
            println("error al guardar la requisicion " + consumo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def anularDevolucion() {
        def consumo = Consumo.get(params.id)
        def detalles = DetalleConsumo.findAllByConsumo(consumo)

        if(detalles?.size() == 0) {
            consumo.estado = 'A'
            consumo.save(flush: true)
            render "ok"
        }else{
            render "no"
        }
    } //anular
}
