package janus

import janus.pac.CrngEjecucionObra
import janus.pac.CronogramaContratado
import janus.pac.CronogramaEjecucion
import janus.pac.PeriodoEjecucion

class ContratoService {

    def dbConnectionService
    def preciosService

    def creaCrngEjecNuevo(id) {
        def contrato = Contrato.get(id)

        if (!contrato) {
            flash.message = "No se encontró el contrato"
            flash.clase = "alert-error"
            return "error"
        }
        def obra = contrato.obra
        if (!obra) {
            flash.message = "No se encontró la obra"
            flash.clase = "alert-error"
            return "error"
        }
        if (!obra.fechaInicio) {
            flash.message = "La obra no tiene fecha de inicio. Por favor solucione el problema. " + obra.id
            flash.clase = "alert-error"
            return "error"
        }

        def prej
        def continua = true
        def fcin
        def fcfn
        def fcfm
        def fcha
        def parcial = 0.0
        def parcial1 = 0.0
        def parcial2 = 0.0
        def vlor
        def precio2 = 0.0
        def porcentaje2 = 0.0
        def cantidad2 = 0.0
        def prej2
        def vol2

        def detalle = VolumenContrato.findAllByObra(obra, [sort: "volumenOrden"])
        def periodos = CronogramaEjecucion.executeQuery("select max(periodo) from CronogramaContratado where contrato = :c", [c: contrato])
        def hayPrej = PeriodoEjecucion.findAllByContrato(contrato)
        println "periodos: $periodos --- hayPrej: $hayPrej"

        if (!hayPrej) {
            fcin = obra.fechaInicio
            for (pr in (1..periodos[0])) {
                def dias = (pr - 1) * 30 //+ (crono.periodo - 1)
                def prdo = 0
//                println "crear periodo... pr: $pr, dias: $dias, plazo: ${contrato.plazo} fcha: ${fcha}"

                if ((dias + 30) > contrato.plazo) {
                    prdo = contrato.plazo - dias
                } else {
                    prdo = 30
                }

                fcin = fcha ? fcha + 1 : obra.fechaInicio
                fcfn = fcin + (prdo - 1).toInteger()      // 30 - 1 para contar el dia inicial
                fcfm = preciosService.ultimoDiaDelMes(fcin)
//                println "--------- fcfm: ${fcfm} fcfn: ${fcfn}"
                if (fcfm < fcfn) {   /** sobrepasa el mes --> 2 periodos **/
                    prej = PeriodoEjecucion.findByContratoAndFechaInicioAndFechaFin(contrato, fcin, fcfm)
                    if (!prej) {
                        prej = new PeriodoEjecucion()
                        prej.contrato = contrato
                        prej.obra = obra
                        prej.fechaInicio = fcin
                        prej.fechaFin = fcfm
                        prej.numero = pr
                        prej.tipo = 'P'
                        if (!prej.save(flush: true)) {
                            flash.message = "No se pudo crear prej"
                            println "Error al crear prej*******: " + prej.errors
                        } else {
//                            println "se ha creado el prej: ${pr} para ${fcin} a ${fcfn}"
//                            flash.message = "Prej actualizado exitosamente"
                        }
                    }

                    fcin = fcfm + 1
                    fcha = fcfn
                    prej = PeriodoEjecucion.findByContratoAndFechaInicioAndFechaFin(contrato, fcin, fcfn)
                    if (!prej) {
                        prej = new PeriodoEjecucion()
                        prej.contrato = contrato
                        prej.obra = obra
                        prej.fechaInicio = fcin
                        prej.fechaFin = fcfn
                        prej.numero = pr
                        prej.tipo = 'P'
                        if (!prej.save(flush: true)) {
                            flash.message = "No se pudo crear prej"
                            println "Error al crear prej*******: " + prej.errors
                        } else {
//                            println "se ha creado el prej: ${pr} para ${fcin} a ${fcfn}"
//                            flash.message = "Prej actualizado exitosamente"
                        }
                    }
                } else {
                    prej = PeriodoEjecucion.findByContratoAndFechaInicioAndFechaFin(contrato, fcin, fcfn)
                    if (!prej) {
                        prej = new PeriodoEjecucion()
                        prej.contrato = contrato
                        prej.obra = obra
                        prej.fechaInicio = fcin
                        prej.fechaFin = fcfn
                        prej.numero = pr
                        prej.tipo = 'P'
                        if (!prej.save(flush: true)) {
                            flash.message = "No se pudo crear prej"
                            println "Error al crear prej*******: " + prej.errors
                        } else {
//                            println "se ha creado el prej: ${pr} para ${fcin} a ${fcfn}"
//                            flash.message = "Prej actualizado exitosamente"
                        }
                    }
                    fcha = fcfn
                }
            }
        }

        def cronogramas = CrngEjecucionObra.countByVolumenObraInList(detalle)
//        println "datos de cronograma $cronogramas"

        if (cronogramas == 0) {
//            println "no hay datos de cronograma ... inicia cargado"
            detalle.each { vol ->
                def cronoCntr = CronogramaContratado.findAllByVolumenContrato(vol, [sort: 'periodo'])
                cronoCntr.each { crono ->

//                    vlor = CronogramaContrato.executeQuery("select sum(precio), sum(porcentaje), sum(cantidad)  from CronogramaContrato where contrato = :c and periodo = :p", [c: contrato, p: crono.periodo])
                    vlor = CronogramaContratado.findByContratoAndVolumenContratoAndPeriodo(contrato, vol, crono.periodo)
                    prej = PeriodoEjecucion.findAllByContratoAndNumero(contrato, crono.periodo)
                    /** ingresar la proporcion en los prej existentes conform el número de días **/
//                    println "valores cronograma: ${vlor}, prej: $prej"
                    def prco = 0.0
                    def pcnt = 0.0
                    def cntd = 0.0
                    def dias = 0
                    def mes = 30
                    def ultimo = contrato.plazo % 30 > 0 ? contrato.plazo % 30 : 30
                    prej.each { pe ->
                        /** se debe definir cuantos dias tiene el periodo actual **/
                        if (ultimo != 30) {
                            dias += (pe.fechaFin - pe.fechaInicio + 1)
                            if ((prco == 0) && (contrato.plazo - 30 * (crono.periodo - 1)) <= ultimo) {
                                mes = ultimo
                            } else {
                                mes = 30
                            }
                            println "dias: $dias, restan: ${contrato.plazo - 30 * (crono.periodo - 1)}, mes = $mes, ultimo: $ultimo"
                        }

                        if (prco > 0) {
                            prco = vlor.precio - prco
                            pcnt = vlor.porcentaje - pcnt
                            cntd = vlor.cantidad - cntd
                        } else {
                            prco = Math.round(vlor.precio / mes * (pe.fechaFin - pe.fechaInicio + 1) * 100) / 100
                            pcnt = Math.round(vlor.porcentaje / mes * (pe.fechaFin - pe.fechaInicio + 1) * 100) / 100
                            cntd = Math.round(vlor.cantidad / mes * (pe.fechaFin - pe.fechaInicio + 1) * 100) / 100
                        }
//                        println "crear crej con: ${vol.id}, ${pe.numero}, $prco, $pcnt, $cntd"
                        def cronoEjecucion = new CrngEjecucionObra([
                                volumenObra: vol,
                                periodo    : pe,
                                precio     : prco,
                                porcentaje : pcnt,
                                cantidad   : cntd
                        ])
                        if (!cronoEjecucion.save(flush: true)) {
                            println "Error al guardar el crono ejecucion del crono " + crono.id
                            println cronoEjecucion.errors
                        } else {
//                            println "ok " + crono.id + "  =>  " + cronoEjecucion.id
                        }
                    }

                } //cronogramaContrato.each
            } //detalles.each
            /** una vez cargado el cronograma ejecuta la creacion de periods mensuales, lo cual puede asimilarse dentro de PREJ **/
//            params.cntr = contrato?.id
            actualizaPrej(contrato.id)  /** pone para cada prej los valores de cronograma **/
        } //if cronogramas == 0

//        println "finalizado creaCrngEjec"
        return "creado"
    }


    def actualizaPrej(cntr_id) {
        /** en base a prej ingresa o actualiza dato en prej **/
//        println "actualizaPrej params: $params"
        def cntr = Contrato.get(cntr_id)
        def cn = dbConnectionService.getConnection()
        def prej = PeriodoEjecucion.findAllByContratoAndTipoNotEqual(cntr, 'S')
        def vlor
        def cmpl = Contrato.findByPadre(cntr)
        def sql = "update prej set prejcrpa = (select coalesce(sum(creoprco),0) from creo " +
                "where creo.prej__id = prej.prej__id) where cntr__id = ${cntr.id} and prejtipo <> 'S'"
        cn.execute(sql.toString())

        sql = "update prej set prejcntr = (select coalesce(sum(creoprco),0) from creo " +
                "where creo.prej__id = prej.prej__id and vocr__id in (select vocr__id from vocr " +
                "where cntr__id = ${cntr.id} and cntrcmpl is null)) where cntr__id = ${cntr.id} and prejtipo <> 'S'"
        def cnta = cn.executeUpdate(sql.toString())
        if (cmpl) {
            sql = "update prej set prejcmpl = (select coalesce(sum(creoprco),0) from creo " +
                    "where creo.prej__id = prej.prej__id and vocr__id in (select vocr__id from vocr " +
                    "where cntr__id = ${cntr.id} and cntrcmpl is not null)) where cntr__id = ${cntr.id} and " +
                    "prejtipo <> 'S'"
//            println "--> prejcmpl $sql"
            cn.execute(sql.toString())
        }

        if (cnta > 0) {
            return "Se actualizador ${cnta} registros en períodos de ejecución"
        } else {
            return "No se pudo actualizar los períodos de ejecución"
        }
    }


}
