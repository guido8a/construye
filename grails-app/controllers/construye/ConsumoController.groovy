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
        params.remove("obra")
        params.remove("fecha")
        if (params.id) {
            consumo = Consumo.get(params.id)
            consumo.properties = params
            consumo.fechaModificacion = new Date()
        } else {
            consumo = new Consumo(params)
        }

        consumo.empresa = prsn.empresa
        consumo.obra = Obra.get(params.obra__id)
        consumo.fecha = fecha

        println "fecha: $fecha --> ${consumo.fecha}"
        if (!consumo.save(flush: true)) {
            println "error " + consumo.errors
        }

        redirect(action: 'consumo', params: [id: consumo.id])
    } //save

    def borrarConsumo() {
        println "borrar consumo "+params
        def consumo = Consumo.get(params.id)
        def detalle = []
        if (!consumo) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Consumo con id " + params.id
            redirect(action: "list")
            return
        } else {
            println "detalle: ${detalle?.size()}"
            if (detalle?.size() == 0) {
                consumo.estado = 'A'
                consumo.save(flush: true)
                render "ok"
                return
            }
        }
    } //anular

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
        println "data: ${datos[0]}"
        [data: datos, tipo: params.tipo]
    }

    def listaItem() {
        println "listaItem" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select comp__id, item.item__id, itemcdgo, itemnmbr, compcntd, compprco, unddcdgo " +
                "from comp, item, undd "
        def txwh = "where item.item__id = comp.item__id and obra__id = 8 and " +
                "undd.undd__id = item.undd__id "
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
            detalle = new DetalleConsumo()
        }

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
            println("error al registrar el consumo " + consumo.errors)
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
        def obra = Obra.get(params.id)
        def tipoConsumo = TipoConsumo.get(1)
        def requisiciones = Consumo.findAllByObraAndTipoConsumo(obra, tipoConsumo)
        return[requisiciones: requisiciones]
    }

    def bodega_ajax(){
        println("params " + params)
        def requisicion = Consumo.get(params.id)
        def bodega = requisicion.bodega
        return[bodega:bodega]
    }
}
