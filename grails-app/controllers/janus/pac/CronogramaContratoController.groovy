package janus.pac

import janus.*
import janus.ejecucion.PeriodosInec
import janus.ejecucion.ValorIndice
import jxl.Cell
import jxl.CellType
import jxl.NumberCell
import jxl.Sheet
import jxl.Workbook
import jxl.WorkbookSettings
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException

class CronogramaContratoController extends janus.seguridad.Shield {

    def preciosService
    def arreglosService
    def dbConnectionService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def fixCrono() {
        def contrato = Contrato.get(params.id)
        def res = arreglosService.fixCronoContrato(contrato)
        render res
    }

    def index() {
        def contrato = Contrato.get(params.id)
        def cn = dbConnectionService.getConnection()
        def cn2 = dbConnectionService.getConnection()
        if (!contrato) {
            flash.message = "No se encontró el contrato"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }
        def obraOld = contrato?.oferta?.concurso?.obra
        println "oblraOld... $obraOld"
        if (!obraOld) {
            flash.message = "No se encontró la obra"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }


//        def existente = VolumenContrato.findByContrato(contrato)?.refresh()
//        println("ex " + existente)


        def obra = Obra.findByCodigo(obraOld.codigo+"-OF")
        if(!obra) {
            obra = obraOld
        }
        //solo copia si esta vacio el cronograma del contrato
        def cronoCntr = CronogramaContrato.countByContrato(contrato)
        def detalle = VolumenesObra.findAllByObra(obra, [sort: "orden"])

        def plazoDiasContrato = contrato.plazo
        def plazoMesesContrato = Math.ceil(plazoDiasContrato / 30);

        def plazoObra = obra.plazoEjecucionMeses + (obra.plazoEjecucionDias > 0 ? 1 : 0)

//        println plazoDiasContrato + "/30 = " + plazoMesesContrato
//        println "plazoMesesContrato: " + plazoMesesContrato + "    plazoObra: " + plazoObra

        if (cronoCntr == 0) {
            detalle.each { vol ->
//            def resto = 100
                def c = Cronograma.findAllByVolumenObra(vol)
                def resto = c.sum { it.porcentaje }
                c.eachWithIndex { crono, cont ->
                    if (cont < plazoMesesContrato) {
                        if (CronogramaContrato.countByVolumenObraAndPeriodo(crono.volumenObra, crono.periodo) == 0) {
                            def cronoContrato = new CronogramaContrato()
                            cronoContrato.properties = crono.properties
                            def pf, cf, df
//                        println "resto... " + resto
                            if (cont < c.size() - 1) {
                                pf = Math.floor(crono.porcentaje)
                                resto -= pf
                            } else {
                                pf = resto
                                resto -= pf
                            }
//                        println "resto... " + resto
                            cf = (pf * cronoContrato.cantidad) / crono.porcentaje
                            df = (pf * cronoContrato.precio) / crono.porcentaje

                            cronoContrato.porcentaje = pf
                            cronoContrato.cantidad = cf
                            cronoContrato.precio = df

                            if (!cronoContrato.save(flush: true)) {
                                println "Error al guardar el crono contrato del crono " + crono.id
                                println cronoContrato.errors
                            }

                        } else {
                            def pf = Math.floor(crono.porcentaje)
                            resto -= pf
                        }
                    }
                }
            }
            if (plazoMesesContrato > plazoObra) {
                ((plazoObra + 1)..plazoMesesContrato).each { extra ->
                    detalle.each { vol ->
                        def cronogramaCon = new CronogramaContrato([
                                contrato: contrato,
                                volumenObra: vol,
                                periodo: extra,
                                precio: 0,
                                porcentaje: 0,
                                cantidad: 0,
                        ])
                        if (!cronogramaCon.save(flush: true)) {
                            println "Error al guardar el crono contrato extra " + extra
                            println cronogramaCon.errors
                        }
                    }
                }
            }
        }

        def subpres = VolumenesObra.findAllByObra(obra, [sort: "orden"]).subPresupuesto.unique()

        def subpre = params.subpre
        if (!subpre) {
            subpre = subpres[0].id
        }

        if (subpre != "-1") {
//            detalle = VolumenesObra.findAllByObraAndSubPresupuesto(obra, SubPresupuesto.get(subpre), [sort: "orden"])
            detalle = VolumenContrato.findAllByContratoAndObraAndSubPresupuesto(contrato, obra, SubPresupuesto.get(subpre),
                    [sort: "volumenOrden"])
        } else {
//            detalle =  VolumenesObra.findAllByObra(obra, [sort: 'orden'])
            detalle =  VolumenContrato.findAllByContratoAndObra(contrato, obra, [sort: 'volumenOrden'])
        }

        def precios = [:]
        def indirecto = obra.totales / 100

        detalle.each {
            it.refresh()
            def res = preciosService.rbro_pcun_v2_item(obra.id, it.subPresupuesto.id, it.item.id)
            precios.put(it.id.toString(), res)

        }

        return [detalle: detalle, precios: precios, obra: obra, contrato: contrato, subpres: subpres, subpre: subpre]
    }




    def nuevoCronograma () {
//        println "nuevoCronograma: $params"
        def contrato = Contrato.get(params.id).refresh()
        def cn = dbConnectionService.getConnection()
        if (!contrato) {
            flash.message = "No se encontró el contrato"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }
        def obraOld = contrato?.oferta?.concurso?.obra
        if (!obraOld) {
            flash.message = "No se encontró la obra"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }


        def sql2 = "select * from vocr where cntr__id = ${contrato?.id}"
        def ex = cn.rows(sql2.toString())

        if(!ex || ex == ''){
            def sqlCopia = "insert into vocr(sbpr__id, cntr__id, obra__id, item__id, vocrcntd, vocrordn, vocrpcun, vocrsbtt, vocrrtcr, vocrcncp)\n" +
                    "select sbpr__id, ${contrato?.id}, ${contrato?.obra?.id}, item__id, vlobcntd, vlobordn, vlobpcun, vlobsbtt, vlobrtcr, 0 \n" +
                    "from vlob where obra__id = ${contrato?.obra?.id}"
            println "sql: $sqlCopia"
            cn.execute(sqlCopia.toString());
            cn.close()
        }


        def obra = Obra.findByCodigo(obraOld.codigo+"-OF")
        if(!obra) {
            obra = obraOld
        }
        //solo copia si esta vacio el cronograma del contrato
        def cronoCntr = CronogramaContratado.countByContrato(contrato)
        println "cronoCntr: ${cronoCntr}, obra: ${obra.id}"
        def detalle = VolumenContrato.findAllByObra(obra, [sort: "volumenOrden"])
        println "detalle: ${detalle.size()}"
//        def detalleV = VolumenesObra.findAllByObra(obra, [sort: "orden"])
        def plazoDiasContrato = contrato.plazo
        def plazoMesesContrato = Math.ceil(plazoDiasContrato / 30);
        def plazoObra = obra.plazoEjecucionMeses + (obra.plazoEjecucionDias > 0 ? 1 : 0)

        println "meses: ${plazoMesesContrato}, dias: ${plazoDiasContrato},cronoCntr: $cronoCntr "
//        println "cronoCntr: $cronoCntr, detalle: ${detalle.size()}"

        if (cronoCntr == 0) {
            detalle.each { vol ->
//                def c = CronogramaContratado.findAllByVolumenContrato(vol)
//                println "buscar: ${vol.item.id}, ${vol.volumenOrden}, ${vol.obra.id}"
                def c = Cronograma.findAllByVolumenObra(VolumenesObra.findByItemAndObraAndOrdenAndObra(vol.item, vol.obra, vol.volumenOrden, vol.obra))
                def resto = c.sum { it.porcentaje }
//                println "....1 ${c.size()}"
                c.eachWithIndex { crono, cont ->
//                    println "procesa: $crono, $cont  plazo: $plazoMesesContrato"
//                    if (cont < plazoMesesContrato) {
//                        println "....2"
                    if (CronogramaContratado.countByPeriodoAndVolumenContrato(crono.periodo, vol) == 0) {
//                            println "....3"
                        def cronogramaContratado = new CronogramaContratado()
//                            cronogramaContratado.properties = crono.properties
                        cronogramaContratado.volumenContrato = vol
                        cronogramaContratado.contrato = contrato
                        cronogramaContratado.periodo = crono.periodo
                        cronogramaContratado.cantidad = crono.cantidad
                        cronogramaContratado.precio = crono.precio
                        cronogramaContratado.porcentaje = crono.porcentaje
                        cronogramaContratado.precio = crono.precio

//                            def pf, cf, df
//                        println "resto... " + resto
//                            if (cont < c.size() - 1) {
//                                pf = Math.floor(crono.porcentaje)
//                                resto -= pf
//                            } else {
//                                pf = resto
//                                resto -= pf
//                            }
//                        println "resto... " + resto
//                            cf = (pf * cronogramaContratado.cantidad) / crono.porcentaje
//                            df = (pf * cronogramaContratado.precio) / crono.porcentaje

//                            cronogramaContratado.porcentaje = pf
//                            cronogramaContratado.cantidad = cf?.toDouble()
//                            cronogramaContratado.precio = df?.toDouble()

                        if (!cronogramaContratado.save(flush: true)) {
                            println "Error al guardar el crono contrato del crono " + crono.id
                            println cronogramaContratado.errors
                        }

//                        }
//                        else {
//                            def pf = Math.floor(crono.porcentaje)
//                            resto -= pf
//                        }
                    }
                }
            }
            if (plazoMesesContrato > plazoObra) {
                ((plazoObra + 1)..plazoMesesContrato).each { extra ->
                    detalle.each { vol ->
                        def cronogramaCon = new CronogramaContratado([
                                contrato: contrato,
                                volumenContrato: vol,
                                periodo: extra,
                                precio: 0,
                                porcentaje: 0,
                                cantidad: 0,
                        ])
                        if (!cronogramaCon.save(flush: true)) {
                            println "Error al guardar el crono contrato extra " + extra
                            println cronogramaCon.errors
                        }
                    }
                }
            }
        }


        def subpres = VolumenContrato.findAllByObra(obra, [sort: "volumenOrden"]).subPresupuesto.unique()

        def subpre = params.subpre
        if (!subpre) {
            subpre = subpres[0].id
        }

        if (subpre != "-1") {
            detalle =  VolumenContrato.findAllByObraAndSubPresupuesto(obra, SubPresupuesto.get(subpre), [sort:'volumenOrden'])
        } else {
            detalle =  VolumenContrato.findAllByObra(obra, [sort: 'volumenOrden'])
        }

        def precios = [:]
//        def indirecto = obra.totales / 100

        println "detalle: $detalle"
        detalle.each {
//            it.refresh()
//            def res = preciosService.rbro_pcun_v2_item(obra.id, it.subPresupuesto.id, it.item.id)
            def res = it.volumenPrecio * it.volumenCantidad
//            println "---- res: $res"
            precios.put(it.id.toString(), res)
        }

        return [detalle: detalle, precios: precios, obra: obra, contrato: contrato, subpres: subpres, subpre: subpre]
    }


    def index_bck() {

//        if (!params.id) {
//            params.id = "5"
//        }

        def contrato = Contrato.get(params.id)
        if (!contrato) {
            flash.message = "No se encontró el contrato"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }
        def obra = contrato?.oferta?.concurso?.obra
        if (!obra) {
            flash.message = "No se encontró la obra"
            flash.clase = "alert-error"
            redirect(controller: 'contrato', action: "registroContrato", params: [contrato: params.id])
            return
        }

        //copia el cronograma de la obra a la tabla cronograma contrato (crng)
        /**
         * TODO: esto hay q cambiar cuando haya el modulo de oferente ganador:
         *  no se deberia copiar el cronograma de la obra sino del oferente ganador
         */

        //solo copia si esta vacio el cronograma del contrato
        def cronoCntr = CronogramaContrato.countByContrato(contrato)
        def detalle = VolumenesObra.findAllByObra(obra, [sort: "orden"])

        def plazoDiasContrato = contrato.plazo
        def plazoMesesContrato = Math.ceil(plazoDiasContrato / 30);

        def plazoObra = obra.plazoEjecucionMeses + (obra.plazoEjecucionDias > 0 ? 1 : 0)

//        println plazoDiasContrato + "/30 = " + plazoMesesContrato
//        println "plazoMesesContrato: " + plazoMesesContrato + "    plazoObra: " + plazoObra

        if (cronoCntr == 0) {
            detalle.each { vol ->
//            def resto = 100
                def c = Cronograma.findAllByVolumenObra(vol)
                def resto = c.sum { it.porcentaje }
                c.eachWithIndex { crono, cont ->
                    if (cont < plazoMesesContrato) {
                        if (CronogramaContrato.countByVolumenObraAndPeriodo(crono.volumenObra, crono.periodo) == 0) {
                            def cronoContrato = new CronogramaContrato()
                            cronoContrato.properties = crono.properties
                            def pf, cf, df
//                        println "resto... " + resto
                            if (cont < c.size() - 1) {
                                pf = Math.floor(crono.porcentaje)
                                resto -= pf
                            } else {
                                pf = resto
                                resto -= pf
                            }
//                        println "resto... " + resto
                            cf = (pf * cronoContrato.cantidad) / crono.porcentaje
                            df = (pf * cronoContrato.precio) / crono.porcentaje

                            cronoContrato.porcentaje = pf
                            cronoContrato.cantidad = cf
                            cronoContrato.precio = df

//                        println "arreglando los decimales:::::"
//                        println "porcentaje: " + crono.porcentaje + " --> " + cronoContrato.porcentaje
//                        println "cantidad: " + crono.cantidad + " --> " + cronoContrato.cantidad
//                        println "precio: " + crono.precio + " --> " + cronoContrato.precio

                            cronoContrato.contrato = contrato

                            if (!cronoContrato.save(flush: true)) {
                                println "Error al guardar el crono contrato del crono " + crono.id
                                println cronoContrato.errors
                            }/* else {
                    println "ok " + crono.id + "  =>  " + cronoContrato.id

                }*/
                        } else {
//                        println "no guarda, solo actualiza el porcentaje"
//                        println "resto... " + resto
                            def pf = Math.floor(crono.porcentaje)
                            resto -= pf
//                        println "resto... " + resto
                        }
                    }
                }
            }
            if (plazoMesesContrato > plazoObra) {
//                println ">>>AQUI"
                ((plazoObra + 1)..plazoMesesContrato).each { extra ->
                    detalle.each { vol ->
                        def cronoContrato = new CronogramaContrato([
                                contrato: contrato,
                                volumenObra: vol,
                                periodo: extra,
                                precio: 0,
                                porcentaje: 0,
                                cantidad: 0,
                        ])
                        if (!cronoContrato.save(flush: true)) {
                            println "Error al guardar el crono contrato extra " + extra
                            println cronoContrato.errors
                        }
                    }
                }
            }
        }

        def precios = [:]
        def indirecto = obra.totales / 100

        preciosService.ac_rbroObra(obra.id)

        detalle.each {
            def res = preciosService.precioUnitarioVolumenObraSinOrderBy("sum(parcial)+sum(parcial_t) precio ", obra.id, it.item.id)
            precios.put(it.id.toString(), (res["precio"][0] + res["precio"][0] * indirecto).toDouble().round(2))
        }

        return [detalle: detalle, precios: precios, obra: obra, contrato: contrato]

    } //index

    def saveCrono_ajax() {
//        println ">>>>>>>>>>>>>>>>>"
//        println params
        def saved = ""
        def ok = ""
        if (params.crono.class == java.lang.String) {
            params.crono = [params.crono]
        }
        def contrato = Contrato.get(params.cont.toLong())
        params.crono.each { str ->
            def parts = str.split("_")
//            println parts
            def per = parts[1].toString().toInteger()
            def vol = VolumenesObra.get(parts[0].toString().toLong())
            /*
            VolumenesObra volumenObra
            Integer periodo
            Double precio
            Double porcentaje
            Double cantidad
             */
            def cont = true
            def crono = CronogramaContrato.findAllByVolumenObraAndPeriodo(vol, per)
            if (crono.size() == 1) {
                crono = crono[0]
            } else if (crono.size() == 0) {
                crono = new CronogramaContrato()
                crono.contrato = contrato
            } else {
//                println "WTF MAS DE UN CRONOGRAMA volumen obra " + vol.id + " periodo " + per + " hay " + crono.size()
                cont = false
            }

            if (cont) {
                crono.volumenObra = vol
                crono.periodo = per
                crono.precio = parts[2].toString().toDouble()
                crono.porcentaje = parts[3].toString().toDouble()
                crono.cantidad = parts[4].toString().toDouble()
                if (crono.save(flush: true)) {
                    saved += parts[1] + ":" + crono.id + ";"
                    ok = "OK"
                } else {
                    ok = "NO"
                    println crono.errors
                }
            }
        }
        render ok + "_" + saved
    }

    def deleteRubro_ajax() {
        def ok = 0, no = 0
        def vol = VolumenesObra.get(params.id)
        CronogramaContrato.findAllByVolumenObra(vol).each { cr ->
            try {
                cr.delete(flush: true)
                ok++
            } catch (DataIntegrityViolationException e) {
                no++
            }
        }
        render "ok:" + ok + "_no:" + no
    }

    def deleteCronograma_ajax() {
        def ok = 0, no = 0
        def obra = Obra.get(params.obra)
        VolumenesObra.findAllByObra(obra, [sort: "orden"]).each { vo ->
            CronogramaContrato.findAllByVolumenObra(vo).each { cr ->
                try {
                    cr.delete(flush: true)
                    ok++
                } catch (DataIntegrityViolationException e) {
                    no++
                }
            }

        }
        render "ok:" + ok + "_no:" + no
    }

    def graficos2() {
//        println("params " + params)
        def obra = Obra.get(params.obra)
        def contrato = Contrato.get(params.contrato)
        return [params: params, contrato: contrato, obra: obra, nuevo: params.nuevo]
    }


    def saveCronoNuevo_ajax () {
//        println("params " + params)
        def saved = ""
        def ok = ""
        if (params.crono.class == java.lang.String) {
            params.crono = [params.crono]
        }
        def contrato = Contrato.get(params.cont.toLong())
        params.crono.each { str ->
            def parts = str.split("_")
            def per = parts[1].toString().toInteger()
            def vol = VolumenContrato.get(parts[0].toString().toLong())
            def cont = true
            def crono = CronogramaContratado.findAllByVolumenContratoAndPeriodo(vol, per)
            if (crono.size() == 1) {
                crono = crono[0]
            } else if (crono.size() == 0) {
                crono = new CronogramaContratado()
                crono.contrato = contrato
            } else {
                println "error" + vol.id + " periodo " + per + " hay " + crono.size()
                cont = false
            }

            if (cont) {
                crono.volumenContrato = vol
                crono.periodo = per
                crono.precio = parts[2].toString().toDouble()
                crono.porcentaje = parts[3].toString().toDouble()
                crono.cantidad = parts[4].toString().toDouble()
                if (crono.save(flush: true)) {
                    saved += parts[1] + ":" + crono.id + ";"
                    ok = "OK"
                } else {
                    ok = "NO"
                    println crono.errors
                }
            }
        }
        render ok + "_" + saved

    }

    def deleteRubroNuevo_ajax () {
//        println("params borrar " + params)
        def ok = 0, no = 0
        def vol = VolumenContrato.get(params.id)
        CronogramaContratado.findAllByVolumenContrato(vol).each { cr ->
            try {
                cr.delete(flush: true)
                ok++
            } catch (DataIntegrityViolationException e) {
                no++
            }
        }
        render "ok:" + ok + "_no:" + no
    }

    def deleteCronogramaNuevo_ajax () {
//        println("params " + params)
        def ok = 0, no = 0
        def obra = Obra.get(params.obra)
        VolumenContrato.findAllByObra(obra, [sort: "volumenOrden"]).each { vo ->
            CronogramaContratado.findAllByVolumenContrato(vo).each { cr ->
                try {
                    cr.delete(flush: true)
                    ok++
                } catch (DataIntegrityViolationException e) {
                    no++
                }
            }

        }
        render "ok:" + ok + "_no:" + no
    }

    def modificarCantidad_ajax (){
//        println("params " + params)
        def volumen = VolumenContrato.get(params.id)
        def cantidadActual = volumen.volumenCantidad
        def cantidadComp = volumen.cantidadComplementaria
        def cantidad = cantidadActual.toDouble() + cantidadComp.toDouble()
        return[volumen: volumen, cantidad: cantidad]
    }

    def guardarCantidad_ajax () {
        println("params " + params)
        def volumen = VolumenContrato.get(params.id)
        def cantidadComplementaria = params.volumenCantidad.toDouble()
        def cantidadActual = volumen.volumenCantidad + volumen.cantidadComplementaria
        def cantidadNueva = cantidadActual + cantidadComplementaria
        def nuevoTotal = cantidadNueva.toDouble() * volumen.volumenPrecio

        println("cantidad " + cantidadNueva)
        println("total " + nuevoTotal)

        volumen.cantidadComplementaria = cantidadComplementaria.toDouble()
        volumen.volumenSubtotal = nuevoTotal.toDouble()

        println("--> " +  volumen.cantidadComplementaria )
        println("--> " +  volumen.volumenSubtotal )

        try{
            volumen.save(flush: true)
            println("- " + volumen.volumenSubtotal)
            render "ok"
        }catch (DataIntegrityViolationException e){
            println("error al modificar la cantidad complementaria " + e)
            render "no"
        }

    }


    def editarVocr() {
        println "--> $params"
        def sbpr = []
        def sql = "select distinct sbpr__id from vocr where cntr__id = ${params.id}"
        def cn = dbConnectionService.getConnection()
        cn.eachRow(sql.toString()) { d ->
            sbpr.add( SubPresupuesto.get(d.sbpr__id) )
        }
        [subpresupuestos: sbpr, cntr: params.id]
    }

    def tablaValores() {
        def cn = dbConnectionService.getConnection()
        def cn1 = dbConnectionService.getConnection()
        def suma = 0
        def totl = ""
        println params

        def sqlTx = "select vocr__id id, vocrordn, itemnmbr, unddcdgo, vocrcntd::numeric(14,2), vocrpcun, vocrsbtt " +
                "from vocr, item, undd " +
                "where item.item__id = vocr.item__id and undd.undd__id = item.undd__id and " +
                "cntr__id = ${params.cntr} "
        if(params.sbpr != '0') {
            sqlTx += "and sbpr__id = ${params.sbpr} order by vocrordn"
        } else {
            sqlTx += "order by vocrordn"
        }

        def txValor = ""
        def editar = ""
        println sqlTx

        def html = "<table class=\"table table-bordered table-striped table-hover table-condensed\" id=\"tablaPrecios\">"
        html += "<thead>"
        html += "<tr>"
//        html += "<th>Id</th>"
        html += "<th>Orden</th>"
        html += "<th>Nombre del Indice</th>"
        html += "<th>Cantidad</th>"
        html += "<th>Precio</th>"
        html += "<th>Parcial</th>"

        def body = ""
        cn.eachRow(sqlTx.toString()) { d ->
            body += "<tr>"
//            body += "<td>${d.id}</td>"
            body += "<td>${d.vocrordn}</td>"
            body += "<td>${d.itemnmbr}</td>"

            def sbtt = ""
            editar = "editable"
            sbtt = g.formatNumber(number: d.vocrsbtt, maxFractionDigits: 2, minFractionDigits: 2, format: "##,##0", locale: "ec")
/*
                body += "<td class='${editar} number' data-original='${d.vocrcntd}' data-cmpo='vocrcntd' " +
                        "data-id='${d.id}' data-valor='${d.vocrcntd}'>" + d.vocrcntd + '</td>'
*/
            body += "<td style='text-align:right'>${d.vocrcntd}</td>"
            body += "<td class='${editar} number' data-original='${d.vocrpcun}' data-cmpo='vocrpcun' " +
                    "data-id='${d.id}' data-valor='${d.vocrpcun}'>" + d.vocrpcun + '</td>'
            body += "<td style='text-align:center' id=tt${d.id}>${sbtt}</td>"

            suma += d.vocrsbtt
        }
        html += "</tr>"
        html += "</thead>"
        html += "<tbody>"
        //println html

        cn.close()
        cn1.close()
        html += body

        totl = g.formatNumber(number: suma, maxFractionDigits: 2, minFractionDigits: 2, format: "##,##0", locale: "ec")
        html += "<tr style='font-weight: bolder' class='text-info'><td colspan='4'>Total</td><td>${totl}</td></tr>"

        html += "</tbody>"
        html += "</table>"
        //println html
        [html: html]
    }


    def actualizaVlin() {
        println "actualizaVlin: " + params
//        println("clase " + params?.item?.class)
        //formato de id:###/new _ prin _ indc _ valor
        if(params?.item?.class == java.lang.String) {
            params?.item = [params?.item]
        }

        def oks = "", nos = ""

        params.item.each {
//            println "Procesa: " + it

            def vlor = it.split("_")
            println "vlor: ${vlor}"
            def vocr = VolumenContrato.get(vlor[0].toInteger())

            if(vlor[1] == 'vocrcntd') {
                vocr.volumenCantidad = vlor[2].toDouble()
                println "cantidad: ${vocr.item.nombre} --> ${vlor[2]}"
            } else {
                vocr.volumenPrecio = vlor[2].toDouble()
                println "precio: ${vocr.item.nombre} --> ${vlor[2]}"
            }

            vocr.volumenSubtotal = vocr.volumenCantidad * vocr.volumenPrecio

            if (!vocr.save(flush: true)) {
                println "error: " + vlor
                if (nos != "") {
                    nos += ","
                }
                nos += "#" + vlor[0]
            } else {
                if (oks != "") {
                    oks += ","
                }
                oks += "#" + vlor[0]
            }
        }

        render "ok"
    }

    def corrigeCrcr() {
        def cn = dbConnectionService.getConnection()
        def suma = 0
        def totl = ""
        println params

        def sql = "update crcr set crcrprco = crcrprct * (select vocrsbtt/100 from vocr " +
                "where vocr.vocr__id = crcr.vocr__id) "
        cn.execute(sql.toString())

        sql = "update crcr set crcrcntd = crcrprct * (select vocrcntd/100 from vocr " +
                "where vocr.vocr__id = crcr.vocr__id) "
        cn.execute(sql.toString())

        sql = "select * from corrige_crcr(${params.id})"
        cn.execute(sql.toString())

        flash.message = "Cronograma corregido.."
        def url = "/contrato/registroContrato?contrato=" + params.id

        redirect( url: url)
    }

    def cantidadObra() {
        println "cantidadObra: $params"

        def sql = "select vocr__id id, vocrordn, itemnmbr, unddcdgo, vocrcntd::numeric(14,2), vocrpcun, vocrsbtt " +
                "from vocr, item, undd " +
                "where item.item__id = vocr.item__id and undd.undd__id = item.undd__id and " +
                "cntr__id = ${params.id} order by vocrordn "
        println sql

        def cn = dbConnectionService.getConnection()

        def res = cn.rows(sql.toString())

//        println("--->>" + res)
        def errores = ""
        if (res.size() != 0) {

            //excel
            WorkbookSettings workbookSettings = new WorkbookSettings()
            workbookSettings.locale = Locale.default

            def file = File.createTempFile('myExcelDocument', '.xls')
            file.deleteOnExit()
            WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

            WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
            WritableCellFormat formatXls = new WritableCellFormat(font)

            def row = 0
            WritableSheet sheet = workbook.createSheet('Composicion', 0)

            WritableFont times16font = new WritableFont(WritableFont.ARIAL, 11, WritableFont.BOLD, false);
            WritableCellFormat times16format = new WritableCellFormat(times16font);
            sheet.setColumnView(0, 10)
            sheet.setColumnView(1, 10)
            sheet.setColumnView(2, 60)
            sheet.setColumnView(3, 8)
            sheet.setColumnView(4, 15)
            sheet.setColumnView(5, 15)
            sheet.setColumnView(6, 15)
            sheet.setColumnView(7, 20)

            def label
            def number
            def fila = 1;
            def ultimaFila

            label = new jxl.write.Label(0, 0, "CODIGO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(1, 0, "NUMERO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(2, 0, "RUBRO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(3, 0, "UNIDAD", times16format); sheet.addCell(label);
            label = new jxl.write.Label(4, 0, "CANTIDAD", times16format); sheet.addCell(label);
            label = new jxl.write.Label(5, 0, "P.UNITARIO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(6, 0, "SUBTOTAL", times16format); sheet.addCell(label);
            label = new jxl.write.Label(7, 0, "PRECIO CONST.", times16format); sheet.addCell(label);

            res.each {
                label = new jxl.write.Label(0, fila, it?.id.toString()); sheet.addCell(label);
                label = new jxl.write.Label(1, fila, it?.vocrordn.toString()); sheet.addCell(label);
                label = new jxl.write.Label(2, fila, it?.itemnmbr.toString()); sheet.addCell(label);
                label = new jxl.write.Label(3, fila, it?.unddcdgo ? it?.unddcdgo.toString() : ""); sheet.addCell(label);
                number = new jxl.write.Number(4, fila, it?.vocrcntd.toDouble() ?: 0); sheet.addCell(number);
                number = new jxl.write.Number(5, fila, it?.vocrpcun.toDouble().round(6) ?: 0); sheet.addCell(number);
                number = new jxl.write.Number(6, fila, it?.vocrsbtt.toDouble() ?: 0); sheet.addCell(number);
                number = new jxl.write.Number(7, fila,0); sheet.addCell(number);

                fila++

                ultimaFila = fila
            }

            workbook.write();
            workbook.close();
            def output = response.getOutputStream()
            def header = "attachment; filename=" + "valorContratado.xls";
            response.setContentType("application/octet-stream")
            response.setHeader("Content-Disposition", header);
            output.write(file.getBytes());
        } else {
            flash.message = "Ha ocurrido un error!"
            redirect(action: "errores")
        }
    }

    def subirExcel () {
//        println("params se " + params)
        def contrato = Contrato.get(params.id)
        return[contrato:contrato]
    }

    def uploadFile() {
        def obra = Obra.get(params.id)
        def path = servletContext.getRealPath("/") + "xlsContratos/"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
//                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                fileName = "xlsContratado_" + new Date().format("yyyyMMdd_HHmmss")

                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path

                //procesar excel
                def htmlInfo = "", errores = "", doneHtml = "", done = 0
                def file = new File(pathFile)

                WorkbookSettings ws = new WorkbookSettings();
                ws.setLocale(new Locale("en", "EN"));
                ws.setEncoding("Cp1252");
//                ws.setEncoding("Cp1252");
//                Workbook workbook = Workbook.getWorkbook(file, ws)
                Workbook workbook = Workbook.getWorkbook(file)
                workbook.getNumberOfSheets().times { sheet ->
                    if (sheet == 0) {
                        Sheet s = workbook.getSheet(sheet)
                        if (!s.getSettings().isHidden()) {
//                            println s.getName() + "  " + sheet
                            htmlInfo += "<h2>Hoja " + (sheet + 1) + ": " + s.getName() + "</h2>"
                            Cell[] row = null
                            s.getRows().times { j ->
                                def ok = true
//                                if (j > 19) {
//                                println ">>>>>>>>>>>>>>>" + (j + 1)
                                row = s.getRow(j)
                                println row*.getContents()
//                                println row.length
                                if (row.length >= 8) {
                                    def cod = row[0].getContents()
                                    def numero = row[1].getContents()
                                    def rubro = row[2].getContents()
                                    def unidad = row[3].getContents()
                                    def cantidad = row[4].getContents()
                                    def punitario = row[5].getContents()
                                    def subtotal = row[6].getContents()
                                    def precioConst = row[7].getContents()

//                                    NumberCell nc = (NumberCell) row[7]
//                                    println "--> ${nc.getValue()}"

//                                    println "\t\tcod:" + cod + "\tnumero:" + numero + "\trubro:" + rubro + "\tunidad:" + unidad
//                                    println "\t\tcantidad:" + cantidad + "\tpunitario:" + punitario + "\tsub:" + subtotal + "\tnuevo:" + precioConst

                                    if (cod != "CODIGO") {
                                        cantidad = cantidad.replaceAll(",",".")
                                        precioConst = precioConst.replaceAll(",",".")
//                                        println("cantidad " + cantidad)
//                                        println("-->" + Math.round(cantidad.toDouble() * 100) / 100)
                                        def vc = VolumenContrato.get(cod)
//
                                        if(!vc){
                                            errores += "<li>No se encontró volumen contrato con id ${cod} (linea: ${j + 1})</li>"
                                            println "No se encontró volumen contrato con id ${cod}"
                                            ok = false
                                        }else{

                                            if(!precioConst){
                                                precioConst = 0
                                            }

                                            if(!cantidad){
                                                cantidad = 0
                                            }
                                            println "precio: ${precioConst.toDouble()}"
                                            vc.volumenPrecio = precioConst.toDouble()
                                            vc.volumenCantidad = Math.round(cantidad.toDouble() * 100) / 100
                                            vc.volumenSubtotal = precioConst.toDouble() * (Math.round(cantidad.toDouble() * 10000) / 10000)
                                        }

                                        if(!vc.save(flush:true)){
                                            println "No se pudo guardar valor contrato con id ${vc.id}: " + vc.errors
                                            errores += "<li>Ha ocurrido un error al guardar los valores para ${rubro} (l. ${j + 1})</li>"
                                        }else{
                                            done++
//                                            println "Modificado vocr: ${vc.id}"
                                            doneHtml += "<li>Se ha modificado los valores para el item ${rubro}</li>"
                                        }
                                    }
                                } //row ! empty
//                                }//row > 7 (fila 9 + )
                            } //rows.each
                        } //sheet ! hidden
                    }//solo sheet 0
                } //sheets.each
                if (done > 0) {
                    doneHtml = "<div class='alert alert-success'>Se han ingresado correctamente " + done + " registros</div>"
                }

                def str = doneHtml
                str += htmlInfo
                if (errores != "") {
                    str += "<ol>" + errores + "</ol>"
                }
//                str += doneHtml

                flash.message = str

                println "DONE!!"
                redirect(action: "mensajeUploadContrato", id: params.id)
            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'formArchivo')
            }
        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'subirExcel')
//            println "NO FILE"
        }
    }

    def subeArchivo() {
        def obra = Obra.get(params.id)
        def path = servletContext.getRealPath("/") + "xlsContratos/"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xlsx") {
                fileName = "xlsContratado_" + new Date().format("yyyyMMdd_HHmmss")
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path

                //procesar excel
                def htmlInfo = "", errores = "", doneHtml = "", done = 0
                def file = new File(pathFile)

                InputStream ExcelFileToRead = new FileInputStream(pathFile);
                XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);

                XSSFSheet sheet1 = wb.getSheetAt(0);
                XSSFRow rowd;
                XSSFCell cell;

                Iterator rows = sheet1.rowIterator();
                while (rows.hasNext()) {
                    rowd = (XSSFRow) rows.next()
                    Iterator cells = rowd.cellIterator()

                    def rgst = []
                    while (cells.hasNext()) {
                        cell = (XSSFCell) cells.next()
//                        println "cell: ${cell}"
                        if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                            if (cell.toString().contains('-')) {
                                rgst.add(cell.getDateCellValue())
                            } else
                                rgst.add(cell.getNumericCellValue())
                        } else {
                            rgst.add(cell.getStringCellValue())
                        }
                    }
//                    println "--> $rgst"

                    def cod = rgst[0]
                    def rubro = rgst[2]
                    def cantidad = rgst[4]
                    def precioConst = rgst[7]

                    if (cod != "CODIGO") {
                        def vc = VolumenContrato.get(cod)
//
                        if(!vc){
                            errores += "<li>No se encontró volumen contrato con id ${cod} (linea: ${j + 1})</li>"
                            println "No se encontró volumen contrato con id ${cod}"
                            ok = false
                        }else{

                            if(!precioConst){
                                precioConst = 0
                            }

                            if(!cantidad){
                                cantidad = 0
                            }
//                            println "precio: ${precioConst.toDouble()}"
                            vc.volumenPrecio = precioConst.toDouble()
                            vc.volumenCantidad = Math.round(cantidad.toDouble() * 100) / 100
                            vc.volumenSubtotal = precioConst.toDouble() * (Math.round(cantidad.toDouble() * 10000) / 10000)
                        }

                        if(!vc.save(flush:true)){
                            println "No se pudo guardar valor contrato con id ${vc.id}: " + vc.errors
                            errores += "<li>Ha ocurrido un error al guardar los valores para ${rubro} (l. ${j + 1})</li>"
                        }else{
                            done++
//                                            println "Modificado vocr: ${vc.id}"
                            doneHtml += "<li>Se ha modificado los valores para el item ${rubro}</li>"
                        }
                    }


                } //sheet ! hidden

                if (done > 0) {
                    doneHtml = "<div class='alert alert-success'>Se han ingresado correctamente " + done + " registros</div>"
                }

                def str = doneHtml
                str += htmlInfo
                if (errores != "") {
                    str += "<ol>" + errores + "</ol>"
                }
//                str += doneHtml

                flash.message = str

                println "DONE!!"
                redirect(action: "mensajeUploadContrato", id: params.id)
            } else {
                flash.message = "Seleccione un archivo Excel xlsx para procesar (archivos xls deben ser convertidos a xlsx primero)"
                redirect(action: 'subirExcel')
            }
        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'subirExcel')
//            println "NO FILE"
        }
    }

    def mensajeUploadContrato() {
        def contrato = Contrato.get(params.id)
        return[contrato:contrato]
    }

    def excelCronograma() {
        println "cantidadObra: $params"

        def sql = "select vocr__id id, vocrordn, itemnmbr, unddcdgo, vocrcntd::numeric(14,2), vocrpcun, vocrsbtt " +
                "from vocr, item, undd " +
                "where item.item__id = vocr.item__id and undd.undd__id = item.undd__id and " +
                "cntr__id = ${params.id} order by vocrordn "

        def cn = dbConnectionService.getConnection()
        def res = cn.rows(sql.toString())

        def periodos = CronogramaContratado.findAllByIdIsNotNull().periodo.max()

        def errores = ""
        if (res.size() != 0) {

            //excel
            WorkbookSettings workbookSettings = new WorkbookSettings()
            workbookSettings.locale = Locale.default

            def file = File.createTempFile('myExcelDocument', '.xls')
            file.deleteOnExit()
            WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

            WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
            WritableCellFormat formatXls = new WritableCellFormat(font)

            def row = 0
            WritableSheet sheet = workbook.createSheet('Cronograma', 0)

            WritableFont times12font = new WritableFont(WritableFont.ARIAL, 11, WritableFont.BOLD, false);
            WritableCellFormat times16format = new WritableCellFormat(times12font);
            sheet.setColumnView(0, 10)
            sheet.setColumnView(1, 10)
            sheet.setColumnView(2, 60)
            sheet.setColumnView(3, 8)
            sheet.setColumnView(4, 15)
            sheet.setColumnView(5, 15)
            sheet.setColumnView(6, 15)
            periodos.times {
                sheet.setColumnView(it+7, 15)
            }

            def label
            def number
            def fila = 1
            def columna = 7
            def ultimaFila

            label = new jxl.write.Label(0, 0, "CODIGO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(1, 0, "NUMERO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(2, 0, "RUBRO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(3, 0, "UNIDAD", times16format); sheet.addCell(label);
            label = new jxl.write.Label(4, 0, "CANTIDAD", times16format); sheet.addCell(label);
            label = new jxl.write.Label(5, 0, "P.UNITARIO", times16format); sheet.addCell(label);
            label = new jxl.write.Label(6, 0, "SUBTOTAL", times16format); sheet.addCell(label);

            while (columna < (7 + periodos)) {
                label = new jxl.write.Label(columna, 0, "Periodo ${columna - 6}", times16format); sheet.addCell(label)
                columna++
            }

            res.each {
                def columna2 = 7
                label = new jxl.write.Label(0, fila, it?.id.toString()); sheet.addCell(label);
                label = new jxl.write.Label(1, fila, it?.vocrordn.toString()); sheet.addCell(label);
                label = new jxl.write.Label(2, fila, it?.itemnmbr.toString()); sheet.addCell(label);
                label = new jxl.write.Label(3, fila, it?.unddcdgo ? it?.unddcdgo.toString() : ""); sheet.addCell(label);
                number = new jxl.write.Number(4, fila, it?.vocrcntd.toDouble() ?: 0); sheet.addCell(number);
                number = new jxl.write.Number(5, fila, it?.vocrpcun.toDouble().round(6) ?: 0); sheet.addCell(number);
                number = new jxl.write.Number(6, fila, it?.vocrsbtt.toDouble() ?: 0); sheet.addCell(number);
                while (columna2 < (7 + periodos)) {
                    def periodoCrono = CronogramaContratado.findByVolumenContratoAndPeriodo(VolumenContrato.get(it.id), (columna2 - 6))
                    number = new jxl.write.Number(columna2, fila, periodoCrono?.precio ?: 0); sheet.addCell(number);
                    columna2++
                }

                fila++
                ultimaFila = fila
            }

            workbook.write();
            workbook.close();
            def output = response.getOutputStream()
            def header = "attachment; filename=" + "excelCronograma.xls";
            response.setContentType("application/octet-stream")
            response.setHeader("Content-Disposition", header);
            output.write(file.getBytes());
        } else {
            flash.message = "Ha ocurrido un error!"
            redirect(action: "errores")
        }
    }

    def subirExcelCronograma(){
        def contrato = Contrato.get(params.id)
        return[contrato:contrato]
    }

    def mensajeUploadCronograma() {
        def contrato = Contrato.get(params.id)
        return[contrato:contrato]
    }

    def uploadFileCronograma() {
        def obra = Obra.get(params.id)
        def periodos = CronogramaContratado.findAllByIdIsNotNull().periodo.max()

        def path = servletContext.getRealPath("/") + "xlsCronograma/"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (ext == "xls") {
//                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                fileName = "xlsCronograma_" + new Date().format("yyyyMMdd_HHmmss")

                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def i = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + i + "." + ext
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path

                //procesar excel
                def htmlInfo = "", errores = "", doneHtml = "", done = 0
                def file = new File(pathFile)
                Workbook workbook = Workbook.getWorkbook(file)

                workbook.getNumberOfSheets().times { sheet ->
                    if (sheet == 0) {
                        Sheet s = workbook.getSheet(sheet)
                        if (!s.getSettings().isHidden()) {
//                            println s.getName() + "  " + sheet
                            htmlInfo += "<h2>Hoja " + (sheet + 1) + ": " + s.getName() + "</h2>"
                            Cell[] row = null
                            s.getRows().times { j ->
                                def ok = true
                                row = s.getRow(j)
                                if (row.length >= periodos) {
                                    def cod = row[0].getContents()
                                    def numero = row[1].getContents()
                                    def rubro = row[2].getContents()
                                    def unidad = row[3].getContents()
                                    def cantidad = row[4].getContents()
                                    def punitario = row[5].getContents()
                                    def subtotal = row[6].getContents().replaceAll(',', '.')

                                    if (cod != "CODIGO") {
                                        cantidad = cantidad.replaceAll(",",".")

                                        def vc = VolumenContrato.get(cod)

                                        if(!vc){
                                            errores += "<li>No se encontró volumen contrato con id ${cod} (l. ${j + 1})</li>"
                                            println "No se encontró volumen contrato con id ${cod}"
                                            ok = false
                                        } else {
                                            def valorPeriodo = 0
                                            def columna = 7
                                            def porcentajeCrono = 0
                                            def cantidadCrono = 0

                                            while (columna < (7 + periodos)) {
//                                                println "*** ${row[columna].getContents()}"
                                                def periodoCrono = CronogramaContratado.findByVolumenContratoAndPeriodo(vc, (columna - 6))
                                                valorPeriodo = row[columna].getContents()
                                                valorPeriodo = valorPeriodo? valorPeriodo.replaceAll(",",".") : null
                                                valorPeriodo = valorPeriodo? valorPeriodo.toDouble() : 0

                                                if(valorPeriodo > 0){
//                                                    println "id: $cod --> $valorPeriodo --> prdo: ${periodoCrono?.periodo}"
                                                    if(subtotal?.toDouble() != 0){
                                                        porcentajeCrono = ((Math.round(valorPeriodo.toDouble() * 100) / 100) / subtotal.toDouble()*100)
                                                        cantidadCrono = (porcentajeCrono * (Math.round(cantidad.toDouble() * 100) / 100)) / 100
                                                        if(!periodoCrono) {
                                                            periodoCrono = new CronogramaContratado()
                                                        }
                                                        periodoCrono.contrato = vc.contrato
                                                        periodoCrono.volumenContrato = vc
                                                        periodoCrono.periodo = (columna - 6)
                                                        periodoCrono.porcentaje = porcentajeCrono
                                                        periodoCrono.cantidad = cantidadCrono
                                                        periodoCrono.precio = valorPeriodo
                                                        if(!periodoCrono.save(flush:true)){
                                                            println "No se pudo guardar valor del cronograma con id ${periodoCrono.id}: " + periodoCrono.errors
                                                            errores += "<li>Ha ocurrido un error al guardar los valores para ${rubro} (l. ${j + 1})</li>"
                                                        }else{
                                                            done++
//                                                            println "Modificado vocr: ${periodoCrono.id}"
                                                            doneHtml += "<li>Se ha modificado los valores para el item ${rubro}</li>"
                                                        }

                                                    }
                                                } else if(periodoCrono){  //se elimina si existía antes
                                                    periodoCrono.delete(flush: true)
                                                }

                                                columna++
                                            }

                                        }
                                    }
                                } //row ! empty
                            } //rows.each
                        } //sheet ! hidden
                    }//solo sheet 0
                } //sheets.each
                if (done > 0) {
                    doneHtml = "<div class='alert alert-success'>Se han ingresado correctamente " + done + " registros</div>"
                }

                def str = doneHtml

                str += htmlInfo

                if (errores != "") {
                    str += "<ol>" + errores + "</ol>"
                }
//                str += doneHtml

                flash.message = str
                println "DONE!!"
                redirect(action: "mensajeUploadCronograma", id: params.id)
            } else {
                flash.message = "Seleccione un archivo Excel xls para procesar (archivos xlsx deben ser convertidos a xls primero)"
                redirect(action: 'formArchivo')
            }
        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'subirExcel')
        }
    }

} //fin controller
