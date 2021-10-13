package janus

import janus.pac.TipoProcedimiento

import java.awt.List

class VolumenObraController extends janus.seguridad.Shield {

    def buscadorService
    def preciosService
    def dbConnectionService

    def volObra() {

        def grupoFiltrado = Grupo.findAllByCodigoNotIlikeAndCodigoNotIlikeAndCodigoNotIlike('1', '2', '3');
        def subpreFiltrado = []
        def var
//        println "grupo "+grupoFiltrado.id
//        def grupos = Grupo.list([sort: "descripcion"])
        subpreFiltrado = SubPresupuesto.findAllByGrupo(grupoFiltrado[0],[sort:"descripcion"])
//        println("-->>" + subpreFiltrado)

        def usuario = session.usuario.id
        def persona = Persona.get(usuario)
        def direccion = Direccion.get(persona?.departamento?.direccion?.id)
        def grupo = Grupo.findAllByDireccion(direccion)
//
//        println("direccion:" + direccion)
//        println("grupo:" + grupo)

        def subPresupuesto1 = SubPresupuesto.findAllByGrupoInList(grupo)

        def obra = Obra.get(params.id)
        def volumenes = VolumenesObra.findAllByObra(obra)

//        def personasPRSP = Persona.findAllByDepartamento(Departamento.findByCodigo('PRSP'))
//        def responsableObra = obra?.responsableObra?.id
        def duenoObra = 0

        duenoObra = esDuenoObra(obra)? 1 : 0

        def valorMenorCuantia = TipoProcedimiento.findBySigla("MCD")?.techo?:  210000
        def valorLicitacion = TipoProcedimiento.findBySigla("LICO")?.minimo?: 30000000

        def campos = ["codigo": ["Código", "string"], "nombre": ["Descripción", "string"]]
//        println "subs "+subpreFiltrado.descripcion

        [obra: obra, volumenes: volumenes, campos: campos, subPresupuesto1: subPresupuesto1, grupoFiltrado: grupoFiltrado,
         subpreFiltrado: subpreFiltrado, grupos: grupoFiltrado, persona: persona, vmc: valorMenorCuantia, duenoObra: duenoObra,
         valorLicitacion: valorLicitacion]
    }

    def cargarSubpres() {
//        println("params" + params)
        def grupo = Grupo.get(params.grupo)
        def subs = SubPresupuesto.findAllByGrupo(grupo,[sort:"descripcion"])
        [subs: subs]
    }

    def setMontoObra() {
        def tot = params.monto
        try {
            tot = tot.toDouble()
        } catch (e) {
            tot = 0
        }
        def obra = Obra.get(params.obra)
        if (obra.valor != tot) {
            obra.valor = tot
            obra.save(flush: true)
        }

        // actualiza el rendimiento de rubros transporte TR%
        /** existe el peligro de que este rubro sea actualizado en otra obra mientras se procesa la obra actual **/
        preciosService.ac_transporteDesalojo(obra.id)

        render "ok"
    }

    def cargaCombosEditar() {
        def sub = SubPresupuesto.get(params.id)
        def grupo = sub?.grupo
        def subs = SubPresupuesto.findAllByGrupo(grupo,[sort:"descripcion"])
        [subs: subs, sub: sub]
    }

    def buscarRubroCodigo() {

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def rubro = Item.findByCodigoAndEmpresaAndTipoItem(params.codigo?.trim()?.toUpperCase(), empresa, TipoItem.get(2))
        if (rubro) {
            render "" + rubro.id + "&&" + rubro.tipoLista?.id + "&&" + rubro.nombre + "&&" + rubro.unidad?.codigo
        } else {
            render "-1"
        }
    }

    def addItem() {
        println "addItem " + params
        def obra = Obra.get(params.obra)
        def rubro = Item.findByCodigoIlike(params.cod)

        def sbpr = SubPresupuesto.get(params.sub)
        def volumen
        def msg = ""

        def existe

        if (params.id) {
            volumen = VolumenesObra.get(params.id)
            existe = VolumenesObra.findAllByObraAndItemAndSubPresupuestoAndIdNotEqual(obra, rubro, sbpr, volumen.id)
            println("existe " + existe)

        }else {

            volumen = new VolumenesObra()
            existe = VolumenesObra.findAllByObraAndItemAndSubPresupuesto(obra, rubro, sbpr)

//            def v = VolumenesObra.findAll("from VolumenesObra where obra=${obra?.id} and item=${rubro?.id} and subPresupuesto=${sbpr?.id}")
//            if (v.size() > 0) {
//                v = v.pop()
//                if (params.override == "1") {
//                    v.cantidad += params.cantidad.toDouble()
//                    v.save(flush: true)
//                    redirect(action: "tabla", params: [obra: obra.id, sub: v.subPresupuesto.id, ord: 1])
//                    return
//                } else {
//                    msg = "error"
//                    render msg
//                    return
//                }
//            }

        }



        if(existe){
            render "er_El item ${rubro?.codigo + " - " + rubro?.nombre} ya existe dentro del volumen de obra"
        }else{
            volumen.cantidad = params.cantidad.toDouble()
            volumen.orden = params.orden.toInteger()
            volumen.subPresupuesto = SubPresupuesto.get(params.sub)
            volumen.obra = obra
            volumen.item = rubro
            volumen.descripcion = params.dscr

            if (!volumen.save(flush: true)) {
                println "error volumen obra " + volumen.errors
                render "error"
            } else {
                preciosService.actualizaOrden(volumen, "insert")
                render "ok"
//                redirect(action: "tabla", params: [obra: obra.id, sub: volumen.subPresupuesto.id, ord: 1])
            }
        }

    }

    def copiarItem() {

        println "copiarItem "+params
        def obra = Obra.get(params.obra)
        def rubro = Item.get(params.rubro)
        def sbprDest = SubPresupuesto.get(params.subDest)
        def sbpr = SubPresupuesto.get(params.sub)

        def itemVolumen = VolumenesObra.findByItemAndSubPresupuesto(rubro, sbpr)
        def itemVolumenDest = VolumenesObra.findByItemAndSubPresupuestoAndObra(rubro, sbprDest, obra)

        def volumen
        def volu = VolumenesObra.list()
        def errores = ''

        if (params.id)
            volumen = VolumenesObra.get(params.id)
        else {
            if (itemVolumenDest) {
                render "er_No se puede copiar el rubro " + rubro.nombre
                return

            } else {
                volumen = VolumenesObra.findByObraAndItemAndSubPresupuesto(obra, rubro, sbprDest)
                if (volumen == null)
                    volumen = new VolumenesObra()
            }
        }

        if(params.canti){
            volumen.cantidad = params.canti.toDouble()
        }else{
            volumen.cantidad = itemVolumen.cantidad.toDouble()
        }

        volumen.orden = (volu.orden.size().toInteger()) + 1
        volumen.subPresupuesto = SubPresupuesto.get(params.subDest)
        volumen.obra = obra
        volumen.item = rubro
        if (!volumen.save(flush: true)) {
            println("Error al copiar los rubros " + volumen.errors)
            render "no_Error al copiar los rubros"
        } else {
            preciosService.actualizaOrden(volumen, "insert")
            render "ok"
        }
    }

    /** carga tabla de detalle de volúmenes de obra **/
    def tabla() {
//        println "params tabla Vlob--->>>> "+params
        def usuario = session.usuario.id
        def persona = Persona.get(usuario)
        def direccion = Direccion.get(persona?.departamento?.direccion?.id)
        def grupo = Grupo.findAllByDireccion(direccion)
        def subPresupuesto1 = SubPresupuesto.findAllByGrupoInList(grupo)
        def obra = Obra.get(params.obra)

        def duenoObra = 0
        def valores
        def orden

        if (params.ord == '1') {
            orden = 'asc'
        } else {
            orden = 'desc'
        }

        // actualiza el rendimiento de rubros transporte TR% si la obra no está registrada y herr. menor
        if(obra.estado != 'R') {
            println "actualiza desalojo y herramienta menor"
            preciosService.ac_transporteDesalojo(obra.id)
            preciosService.ac_rbroObra(obra.id)
        }

        if (params.sub && params.sub != "-1") {
            valores = preciosService.rbro_pcun_v5(obra.id, params.sub, orden)
        } else {
            valores = preciosService.rbro_pcun_v4(obra.id, orden)
        }
//        println("-->>" + valores)

        def subPres = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()

        def estado = obra.estado

        duenoObra = esDuenoObra(obra)? 1 : 0

        [subPres: subPres, subPre: params.sub, obra: obra, valores: valores,
         subPresupuesto1: subPresupuesto1, estado: estado, msg: params.msg, persona: persona, duenoObra: duenoObra]
    }

    def esDuenoObra(obra) {
//
        def dueno = false
        def funcionElab = Funcion.findByCodigo('E')
        def personasPRSP = PersonaRol.findAllByFuncionAndPersonaInList(funcionElab, Persona.findAllByDepartamento(Departamento.findByCodigo('PRSP')))
        def responsableRol = PersonaRol.findByPersonaAndFuncion(obra?.responsableObra, funcionElab)
//
//        if(responsableRol) {
////            println personasPRSP
//            dueno = personasPRSP.contains(responsableRol) && session.usuario.departamento.codigo == 'PRSP'
//        }

//        println "responsable" + responsableRol + " dueño " + dueno
//                dueno = session.usuario.departamento.id == obra?.responsableObra?.departamento?.id || dueno

        if (responsableRol) {
//            println "..................."
            println "${obra?.responsableObra?.departamento?.id} ==== ${Persona.get(session.usuario.id).departamento?.id}"
//            println "${Persona.get(session.usuario.id)}"
/*
            if (obra?.responsableObra?.departamento?.direccion?.id == Persona.get(session.usuario.id).departamento?.direccion?.id) {
                dueno = true
            } else {
                dueno = personasPRSP.contains(responsableRol) && session.usuario.departamento.codigo == 'PRSP'
            }
*/
            if (personasPRSP.contains(responsableRol) && session.usuario.departamento.codigo == 'PRSP') {
                dueno = true
            } else if (obra?.responsableObra?.departamento?.direccion?.id == Persona.get(session.usuario.id).departamento?.direccion?.id) {
                dueno = true
            }
        }


//        println(" usuarioDep " + Persona.get(session.usuario.id).departamento?.direccion?.id + " respDep " + obra?.responsableObra?.departamento?.direccion?.id + " dueño " + dueno)

//        println ">>>>responsable" + responsableRol + " dueño " + dueno + " usuario " + session.usuario.departamento.id + " respDep " + obra?.responsableObra?.departamento?.id
//        println ">>>>responsable" + responsableRol + " dueño " + dueno + " usuario " + Persona.get(session.usuario.id).departamento?.direccion?.id + " respDep " + obra?.responsableObra?.departamento?.direccion?.id

        dueno
    }


    def eliminarRubro() {
        println "elm rubro " + params
        def vol = VolumenesObra.get(params.id)
        def obra = vol.obra
        def orden = vol.orden
        def msg = ""
        def cronos = Cronograma.findAllByVolumenObra(vol)

        cronos.each { c ->
            if (c.porcentaje == 0) {
                c.delete(flush: true)
            } else {
                msg = "Error no se puede borrar el rubro porque esta presente en el cronograma con un valor diferente de cero."
                render"no"
            }
        }

        try {
            if (msg == "") {
                preciosService.actualizaOrden(vol, "delete")
                vol.delete(flush: true)
                render "ok"
            }
        } catch (e) {
            println "error al borrar el rubro desde vol obra " + e
            msg = "no"
        }
//        redirect(action: "tabla", params: [obra: obra.id, sub: vol.subPresupuesto.id, ord: 1, msg: msg])
    }

    def copiarRubros() {
        def obra = Obra.get(params.obra)
        def volumenes = VolumenesObra.findAllByObra(obra, [sort:"descripcion"])

        return [obra: obra, volumenes: volumenes, origen: volumenes.subPresupuesto.unique()]
    }

    def tablaCopiarRubro() {
        def usuario = session.usuario.id
        def persona = Persona.get(usuario)
        def empresa = persona.empresa
        def direccion = Direccion.get(persona?.departamento?.direccion?.id)
        def grupo = Grupo.findAllByDireccion(direccion)
        def obra = Obra.get(params.obra)
        def valores

//        if (params.sub && params.sub != "null") {
        valores = preciosService.rbro_pcun_v3(obra.id, params.sub)
//        } else {
//            valores = preciosService.rbro_pcun_v2(obra.id)
//        }


        def subPres = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()
        def subPresupuesto1 = SubPresupuesto.findAllByGrupoInList(subPres.grupo, [sort: 'descripcion'])
//        println "subPresupuesto1: ${subPresupuesto1.size()}, grupo: ${subPres.grupo}, sub: ${subPres.id}"

        def precios = [:]
        def fecha = obra.fechaPreciosRubros
        def dsps = obra.distanciaPeso
        def dsvl = obra.distanciaVolumen
        def lugar = obra.lugar
        def prch = 0
        def prvl = 0
        def indirecto = obra.totales / 100

        preciosService.ac_rbroObra(obra.id)
        [precios: precios, subPres: subPres, subPre: params.sub, obra: obra, precioVol: prch, precioChof: prvl,
         indirectos: indirecto * 100, valores: valores, subPresupuesto1: subPresupuesto1, grupo: grupo]
    }


    def buscaRubro() {

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def listaTitulos = ["Código", "Descripción", "Unidad"]
        def listaCampos = ["codigo", "nombre", "unidad"]
        def funciones = [null, null]
        def url = g.createLink(action: "buscaRubro", controller: "rubro")
        def funcionJs = "function(){"
        funcionJs += '$("#modal-rubro").modal("hide");'
        funcionJs += '$("#item_id").val($(this).attr("regId"));$("#item_codigo").val($(this).attr("prop_codigo"));$("#item_nombre").val($(this).attr("prop_nombre"))'
        funcionJs += '}'
        def numRegistros = 20
        def extras = " and empr__id =${empresa?.id} and tipoItem = 2 and codigo not like 'H%' and aprobado = 'R' "  // no lista los que inician con H
        if (!params.reporte) {
            def lista = buscadorService.buscar(Item, "Item", "excluyente", params, true, extras) /* Dominio, nombre del dominio , excluyente o incluyente ,params tal cual llegan de la interfaz del buscador, ignore case */
            lista.pop()
            render(view: '../tablaBuscadorColDer', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista, funciones: funciones, url: url, controller: "llamada", numRegistros: numRegistros, funcionJs: funcionJs])
        } else {
//            println "entro reporte"
            /*De esto solo cambiar el dominio, el parametro tabla, el paramtero titulo y el tamaño de las columnas (anchos)*/
            session.dominio = Item
            session.funciones = funciones
            def anchos = [20, 80] /*el ancho de las columnas en porcentajes... solo enteros*/
            redirect(controller: "reportes", action: "reporteBuscador", params: [listaCampos: listaCampos, listaTitulos: listaTitulos, tabla: "Item", orden: params.orden, ordenado: params.ordenado, criterios: params.criterios, operadores: params.operadores, campos: params.campos, titulo: "Rubros", anchos: anchos, extras: extras, landscape: true])
        }
    }

    def eliminarSubpre () {
        println("params eliminar sub " + params)
        def subpresupuesto = SubPresupuesto.get(params.sub)
        def obra = Obra.get(params.obra)
        def volumenes = VolumenesObra.findAllBySubPresupuestoAndObra(subpresupuesto, obra)
//        println("vols " + volumenes)
        def cronogramas = Cronograma.findAllByVolumenObraInList(volumenes)
        def errores = 0

        if(cronogramas){
//            println("Existe vlob en crono")
            render "NO_No se puede borrar el subpresupuesto, uno o mas rubros ya se encuentran en el cronograma!"
        }else{
            volumenes.each {v->
                if(!v.delete(flush:true)){
                    errores += v.errors.getErrorCount()
                }
            }
            println("errores " + errores)
            if(errores == 0){
                render "OK_Subpresupuesto borrado correctamente"
            }else{
                render "NO_Error al borrar el subpresupuesto"
            }
        }
    }

    def destino_ajax(){

//        println("params " + params)

        def destinos = []

        if(params.origen && params.origen != ''){
            def origen = SubPresupuesto.get(params.origen)
            def obra = Obra.get(params.obra)
            def subPres = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()
            destinos = SubPresupuesto.findAllByGrupoInListAndIdNotInList(subPres.grupo, [origen.id], [sort: "descripcion"])
        }
        return[destinos: destinos]
    }

    def copiarRubrosObra(){
        def obra = Obra.get(params.id)
        def destinos = SubPresupuesto.findAllByIdGreaterThan(0, [sort: "descripcion"])
        return[obra:obra, destinos: destinos]
    }

    def tablaCopiarRubroObra(){

//        println("params tcr " + params)

        def obraActual = Obra.get(params.obraActual)
        def usuario = session.usuario.id
        def persona = Persona.get(usuario)
        def direccion = Direccion.get(persona?.departamento?.direccion?.id)
        def grupo = Grupo.findAllByDireccion(direccion)
        def obra = Obra.get(params.obra)
        def valores

        valores = preciosService.rbro_pcun_v3(obra.id, params.sub)

        def subPres = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()
        def subPresupuesto1 = SubPresupuesto.findAllByGrupoInList(subPres.grupo, [sort: 'descripcion'])

        def precios = [:]
        def prch = 0
        def prvl = 0
        def indirecto = obra.totales / 100

        preciosService.ac_rbroObra(obra.id)
        [precios: precios, subPres: subPres, subPre: params.sub, obra: obra, precioVol: prch, precioChof: prvl,
         indirectos: indirecto * 100, valores: valores, subPresupuesto1: subPresupuesto1, grupo: grupo, obraActual: obraActual]
    }

    def listaObras() {
        println("lista de obras " + params)
        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def obra = Obra.get(params.obra)
        def listaObra = ['obranmbr', 'obracdgo']
        def datos;
        def select = "select obra.obra__id, obracdgo, obranmbr from obra, vlob "
        def txwh = "where vlob.obra__id = obra.obra__id and obra.empr__id = ${empresa?.id} and " +
                "obra.obra__id != ${obra?.id} "
        def sqlTx = ""
        def bsca = listaObra[params.buscarPor.toInteger()-1]
        def ordn = listaObra[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} group by obra.obra__id, obracdgo, obranmbr order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos}"
        [data: datos, tipo: params.tipo, consumo:params.consumo, obra: obra]
    }

    def subOrigen_ajax(){
        println("params so " + params)
        def obra = Obra.get(params.obra)
        def origenes = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()
        println("origenes " + origenes)
        return[origen: origenes]
    }

    def copiarRubro() {

//        println("params copiar rubro " + params)

        def errores = []
        def copiados = []
        def existe = []
        def noExiste = []

        def obra = Obra.get(params.obra)
        def rubro
        def volumenOriginal
        def sbprDest = SubPresupuesto.get(params.destino)
        def existentes = VolumenesObra.findAllByObraAndSubPresupuesto(obra, sbprDest, [sort: "orden"])
        def nuevoVolumen

        if(params.tamano.toInteger() > 1){
            params."selec[]".each{
                volumenOriginal = VolumenesObra.get(it)
                rubro = volumenOriginal.item
                if(VolumenesObra.findByItemAndSubPresupuestoAndObra(rubro, sbprDest, obra)){
                    existe.add(volumenOriginal.item.nombre)
                }else{
                    noExiste.add(volumenOriginal.id)
                }
            }
        }else{
            volumenOriginal = VolumenesObra.get( params."selec[]")
            rubro = volumenOriginal.item
            if(VolumenesObra.findByItemAndSubPresupuestoAndObra(rubro, sbprDest, obra)){
                existe.add(volumenOriginal.item.nombre)
            }else{
                noExiste.add(volumenOriginal.id)
            }
        }

//        println("Existe " + existe)
//        println("no existe " + noExiste)

        noExiste.each{ e->
            def volumen = VolumenesObra.get(e.toInteger())
            nuevoVolumen = new VolumenesObra()
            nuevoVolumen.item = volumen.item
            nuevoVolumen.obra = obra
            nuevoVolumen.cantidad = volumen.cantidad
            nuevoVolumen.subPresupuesto = sbprDest
            nuevoVolumen.orden = existentes ? (existentes?.last()?.orden + 1) : 1

            if(!nuevoVolumen.save(flush: true)){
                println("error al grabar el nuevo volumen de obra " + nuevoVolumen.errors)
                errores.add(volumen.item.nombre)
            }else{
                copiados.add(volumen.item.nombre)
            }
        }

        def vlob = VolumenesObra.findByObra(obra)
        preciosService.actualizaOrden(vlob, "insert")

        render "_" + (copiados?.size() > 0 ? copiados.join('<br>') : 0)  + "_" + (existe?.size() > 0 ? existe.join("<br>") : 0) + "_" + (errores?.size() > 0 ? errores.join("<br>") : 0)
    }


    def listaItem() {
        println "listaItem" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select item.item__id, itemcdgo, itemnmbr, unddcdgo " +
                "from item, undd "
        def txwh = "where tpit__id = 2 and undd.undd__id = item.undd__id and itemaprb = 'R'"
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
//        txwh += " and $bsca ilike '%${params.criterio}%' and grpo__id = ${params.grupo}"
        txwh += " and $bsca ilike '%${params.criterio}%' "

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println "data: ${datos[0]}"
        [data: datos]
    }


}
