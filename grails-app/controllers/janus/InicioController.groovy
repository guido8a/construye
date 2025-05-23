package janus

import janus.construye.Empresa
import janus.seguridad.Prfl

//import com.linuxense.javadbf.DBFField
//import com.linuxense.javadbf.DBFReader
//
//import com.linuxense.javadbf.*

class InicioController extends janus.seguridad.Shield {
    def dbConnectionService
    def oferentesService

    def index() {
        def cn = dbConnectionService.getConnection()
        def prms = []
        def acciones = "'rubroPrincipal', 'registroObra', 'registrarPac', 'verContrato', 'consumo'"
        def tx = "select accnnmbr from prms, accn where prfl__id = " + Prfl.findByNombre(session.perfil.toString()).id +
                " and accn.accn__id = prms.accn__id and accnnmbr in (${acciones})"
//        println "sql: $tx"
        cn.eachRow(tx) { d ->
            prms << d.accnnmbr
        }
        cn.close()
//        def empr = Parametros.get(1)
        def usuario = session.usuario.id
        def prsn = Persona.get(session.usuario.id)

        println "Empresa: ${prsn.empresa?.sigla}"
//        println "prms: $prms"

        return [prms: prms, empr: prsn.empresa]
    }


    def inicio() {
        redirect(action: "index")
    }

    def parametros = {

    }

    def arbol() {

    }

    def manualObras = {

    }

    def variables() {
        def paux = Parametros.get(1);
        def par = Parametros.list()
        def total1 = (paux?.indiceCostosIndirectosObra ?: 0) + (paux?.administracion ?: 0) + (paux?.indiceAlquiler ?: 0) +
                (paux?.indiceCostosIndirectosVehiculos ?: 0) + (paux?.indiceCostosIndirectosTimbresProvinciales ?: 0) +
                (paux?.indiceCostosIndirectosPromocion ?: 0) + (paux?.indiceCostosIndirectosGarantias ?: 0) +
                (paux?.indiceSeguros ?: 0) + (paux?.indiceCostosIndirectosCostosFinancieros ?: 0) +
                (paux?.indiceSeguridad ?: 0)
//        def total2 = (obra?.indiceCampo ?: 0) + (obra?.indiceCostosIndirectosCostosFinancieros ?: 0) + (obra?.indiceCostosIndirectosGarantias ?: 0) + (obra?.indiceCampamento ?: 0)
        def total3 = (total1 ?: 0) + (paux?.indiceUtilidad ?: 0)

//        def total1 = (paux?.indiceAlquiler ?: 0) + (paux?.administracion ?: 0) + (paux?.indiceCostosIndirectosMantenimiento ?: 0) + (paux?.indiceProfesionales ?: 0) + (paux?.indiceSeguros ?: 0)  + (paux?.indiceSeguridad ?: 0)
//        def total2 = (paux?.indiceCampo ?: 0) + (paux?.indiceCostosIndirectosCostosFinancieros ?: 0) + (paux?.indiceCostosIndirectosGarantias ?: 0) + (paux?.indiceCampamento ?: 0)
//        def total3 = (total1 ?:0 ) + (total2 ?: 0) + (paux?.impreso ?: 0) + (paux?.indiceUtilidad ?: 0)

        paux.totales = total3
        paux.save(flush: true)

        return [paux: paux, par: par, totalCentral: total1, totalObra: total3]
    }

    /** carga datos desde un CSV - utf-8: si ya existe lo actualiza
     * */
    def leeCSV_lr() {
//        println ">>leeCSV.."
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def inserta
        def directorio
        def tipo = 'prueba'

        if (grails.util.Environment.getCurrent().name == 'development') {
            directorio = '/home/guido/proyectos/losRios/data/'
        } else {
            directorio = '/home/obras/data/'
        }

        if (tipo == 'prueba') { //botón: Cargar datos Minutos
            procesa = 5
        } else {
            procesa = 100000000000
        }

        def nmbr = ""
        def arch = ""
        def cuenta = 0
        new File(directorio).traverse(type: groovy.io.FileType.FILES, nameFilter: ~/.*\.csv/) { ar ->
            nmbr = ar.toString() - directorio
            arch = nmbr.substring(nmbr.lastIndexOf("/") + 1)

            /*** procesa las 5 primeras líneas del archivo  **/
            def line
            cont = 0
            repetidos = 0
            ar.withReader('UTF-8') { reader ->
                print "Cargando datos desde: $ar "
                while ((line = reader.readLine()) != null) {
                    if (cuenta < procesa) {
//                        println "${line}"

                        rgst = line.split(',')
                        rgst = rgst*.trim()
//                        println "***** $rgst"

                        inserta = cargaData(rgst)
                        cont += inserta.insertados
                        repetidos += inserta.repetidos

                        if (rgst.size() > 2 && rgst[-2] != 0) cuenta++  /* se cuentan sólo si hay valores */

                    }
                }
//                if(true) {
                if (crea_log) {
                    print " --- file: ${arch} "
                    archivoSubido(arch, cont, repetidos)
                }
//                println "--> cont: $cont, repetidos: $repetidos"

            }
            println "---> archivo: ${ar.toString()} --> cont: $cont, repetidos: $repetidos"
        }
//        return "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
        render "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
    }


    def cargaData(rgst) {
        def errores = ""
//        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def cn = dbConnectionService.getConnection()
        def sqlParr = ""
        def sql = ""
        def parr = 0

//        println "\n inicia cargado de datos para $rgst"
        cnta = 0
        if (rgst[1].toString().size() > 0) {
            sqlParr = "select parr__id from parr where parrcdgo = '${rgst[0]}'"
//            println "sqlParr: $sqlParr"
            parr = cn.rows(sqlParr.toString())[0]?.parr__id
            sql = "select count(*) nada from cmnd where parr__id = ${parr} and cmndnmbr = '${rgst[1]}'"
            cnta = cn.rows(sql.toString())[0]?.nada
            if (parr && (cnta == 0)) {
                sql = "insert into cmnd (cmnd__id, parr__id, cmndnmbr) values(default, ${parr}, '${rgst[1]}') "
//                        "on conflict (parr__id, cmndnmbr) DO NOTHING"

            }
//            println "sql: $sql"

            try {
                cn.execute(sql.toString())
                if (cn.updateCount > 0) {
                    insertados++
                }
            } catch (Exception ex) {
                repetidos++
                println "Error al insertar $ex"
            }

        }
        cnta++
        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    /** carga datos desde un CSV - utf-8 * */
    def leeCSV() {
        println ">>leeItems.."
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def inserta
        def fcha
        def tipo = 'prod'

        if (tipo == 'prueba') { //botón: Cargar datos Minutos
            procesa = 5
        } else {
            procesa = 100000000000
        }

        def arch = new File('/home/guido/proyectos/venta-servicios/data/items.csv')
        def cuenta = 0
        def line
        arch.withReader { reader ->
            while ((line = reader.readLine()) != null) {
                if (cuenta > 0 && cuenta < procesa) {

                    rgst = line.split('\t')
                    rgst = rgst*.trim()

                    inserta = cargaItems(rgst)
                    cont += inserta.insertados
                    repetidos += inserta.repetidos

                    cuenta++
                } else {
                    cuenta++
                }
            }
            println "---> archivo: ${arch.toString()} --> cont: $cont, repetidos: $repetidos"
            render "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
        }
    }

    def cargaItems(rgst) {
        def errores = ""
        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def cn = dbConnectionService.getConnection()
        def sqlsbgr = ""
        def sql = ""
        def grpo = 0, sbgr = 0, dprt = 0, undd = 0, item = 0, cdgo = ""
        def fcha = ""
        def id = 0
        def resp = 0

        println "\n inicia cargado de datos para $rgst"
        cnta = 0
        if (rgst[1].toString().size() > 0) {
            grpo = rgst[0] == 'M' ? '1' : rgst[0] == 'MO' ? '2' : '3'
            undd = rgst[5] == 'u' ? '22' : rgst[5] == 'm' ? '12' : '6'
            sqlsbgr = "select sbgr__id from sbgr where grpo__id = $grpo and sbgrcdgo ilike '${rgst[1].toString().trim()}'"
            println "sqlSbgr: $sqlsbgr"
            sbgr = cn.rows(sqlsbgr.toString())[0]?.sbgr__id

            println "grpo: $grpo, sbgr: $sbgr"
            if (sbgr) {
                cdgo = "${rgst[1].toString().trim()}.${rgst[2].toString().trim()}.${completa(rgst[3].toString().trim())}"
                sqlsbgr = "select dprt__id from dprt where sbgr__id = $sbgr and dprtcdgo ilike '%${rgst[2]}%'"
                dprt = cn.rows(sqlsbgr.toString())[0]?.dprt__id
                println "sqlsbgr: $sqlsbgr"
                println "dprt: ${rgst[2]} --> dprt__id: ${dprt}"

                if (dprt) {
                    sqlsbgr = "insert into item(item__id, undd__id, tpit__id, dprt__id, itemcdgo, itemnmbr," +
                            "itempeso, itemtrps, itemtrvl, itemrndm, tpls__id) " +
                            "values (default, ${undd}, 1, ${dprt}, '${cdgo}', '${rgst[4].toString().trim()}', " +
                            "0,0,0,0, 1) returning item__id"
                    println "--> $sqlsbgr"
                    cn.eachRow(sqlsbgr.toString()) { d ->
                        item = d.item__id
                    }
                    println "item --> $item"
                }
            }

            rgst[6] = rgst[6] ?: ''
            println "precio: ${rgst[6]}, ${rgst[6]?.size()}"
            if (rgst[6]?.size() > 2) {
                sql = "select count(*) nada from rbpc where item__id = ${item}"
                cnta = cn.rows(sql.toString())[0]?.nada
                println "sql ---> ${sql}"
                def lgar = (grpo == '1' ? 2 : 4)
                if (item && (cnta == 0)) {
                    /* crea la precio */
                    sql = "insert into rbpc (rbpc__id, item__id, lgar__id, rbpcfcha, rbpcpcun, rbpcfcin, " +
                            "rbpcrgst) " +
                            "values(default, ${item}, ${lgar}, '1-may-2021', ${rgst[6]}, '1-may-2021', 'N') " +
                            "returning rbpc__id"
                    println "sql ---> ${sql}"

                    try {
                        cn.eachRow(sql.toString()) { d ->
                            id = d.rbpc__id
                            insertados++
                        }
                    } catch (Exception ex) {
                        repetidos++
//                    println "Error taller $ex"
                        println "Error rbpc ${rgst[6]}"
//                    println "sql: $sql"
                    }
                }
            }
        }

        cnta++
        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    def completa(tx) {
        def ln = tx.size()
        if(ln < 4) {
            return '0' * (3 - ln) + tx
        } else {
            return tx
        }
    }

    /** carga datos de existencia CSV - utf-8 * */
    def leeExstCSV() {
        println ">>leeExst.."
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def inserta
        def fcha
        def tipo = 'prod'

        if (tipo == 'prueba') { //botón: Cargar datos Minutos
            procesa = 5
        } else {
            procesa = 100000000000
        }

        def arch = new File('/home/guido/proyectos/venta-servicios/data/existencias_cngz.csv')
        def cuenta = 0
        def line
        arch.withReader { reader ->
            while ((line = reader.readLine()) != null) {
                if (cuenta > 0 && cuenta < procesa) {

                    rgst = line.split('\t')
                    rgst = rgst*.trim()

                    inserta = cargaExst(rgst)
                    cont += inserta.insertados
                    repetidos += inserta.repetidos

                    cuenta++
                } else {
                    cuenta++
                }
            }
            println "---> archivo: ${arch.toString()} --> cont: $cont, repetidos: $repetidos"
            render "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
        }
    }

    def cargaExst(rgst) {
        def errores = ""
        def insertados = 0
        def repetidos = 0
        def cn = dbConnectionService.getConnection()
        def sbtt = 0
        def sql = "", sql1, sql2
        def id = 0, cdgo = '', dscr = '', pcun = 0, undd = 0, cnta = 1, items = 0, retazos = 0, cntd = 0.0
        def fcha = '2021-11-27'

        println "\n inicia cargado de exst para $rgst"
        if (rgst[2].toString().size() > 0) {  //existencias > 0
            cdgo = rgst[3].toString().trim()
            cn.eachRow("select undd__id from undd where unddcdgo = '${cdgo}'".toString()) { d ->
                undd = d.undd__id ?: 0
            }
            undd = undd ?: 22
            println "undd__id: $undd  --> ${undd}"

            cn.eachRow("select max(substr(itemcdgo,6,4)::integer)+1 cnta " +
                    "from item where itemcdgo ilike 'EXST-%'".toString()) { d ->
                cnta = d.cnta ?: 1
            }
            println "cuenta: ${cnta}"

            cdgo = rgst[1].toString().trim()
            dscr = rgst[2].toString().trim()
            if ((cdgo.toString().size() > 0)||(dscr.toString().size() > 0)) {
                cn.eachRow("select item__id from item where itemcdgo = '${cdgo}'".toString()) { d ->
                    id = d.item__id ?: 0
                }
                println "------id: $id"
                if(!id) {
                    println "+++++------id: $id"

                    cn.eachRow("select item__id from item where itemnmbr ilike '${dscr}'".toString()) { d ->
                        id = d.item__id ?: 0
                    }
                }
                println "------id: $id"
            }
            if(!id){
                println "insertar el item: ${rgst[2].toString().trim()}"
                sql1 = "insert into item(item__id, undd__id, tpit__id, dprt__id, itemcdgo, itemnmbr," +
                        "itempeso, itemtrps, itemtrvl, itemrndm, tpls__id) " +
                        "values (default, ${undd}, 1, 469, 'EXST-${completa(cnta.toString())}', '${rgst[2].toString().trim()}', " +
                        "0,0,0,0, 1) returning item__id"
                try {
                    cn.eachRow(sql1.toString()) { d ->
                        if (d.item__id > 0) items++
                        id = d.item__id
                    }
                } catch (Exception ex) {
                    repetidos++
                    println "Error dtad ${rgst[0]}"
                }

            }
            if (!rgst[4]) {
                pcun = null
                cn.eachRow("select rbpcpcun from rbpc where item__id = ${id} and rbpcfcha = " +
                        "(select max(rbpcfcha) from rbpc pc where pc.item__id = rbpc.item__id)".toString()) { d ->
                    pcun = d.rbpcpcun
                }
            }
            pcun = rgst[4] ? rgst[4] : pcun?:0.0001

            println "item__id: $id, pcun: $pcun"
            println "sqlitem: $sql1"

            sbtt = pcun.toDouble() * rgst[6].toDouble()
            if(id){
                sql = "insert into dtad(dtad__id, adqc__id, item__id, dtadcntd, dtadpcun, dtadsbtt) " +
                        "values (default, 0, ${id}, ${rgst[31]}, ${pcun}, ${sbtt}) returning dtad__id"
                println "--> $sql"

                for(i in 6..30) {
                    cntd = rgst[i].toDouble()
                    if(cntd > 0){
                        sql2 = "insert into rtzo(rtzo__id, bdga__id, rtzocntd, rtzoetdo, rtzofcha, item__id) " +
                                "values (default, 1, ${cntd}, 'N', '${fcha}', ${id}) returning rtzo__id"
                        println "rtzo --> $sql"
                        try {
                            cn.eachRow(sql2.toString()) { d ->
                                if (d.rtzo__id > 0) retazos++
                            }
                        } catch (Exception ex) {
                            println "Error dtad ${rgst[0]}"
                        }
                    }
                }

                try {
                    cn.eachRow(sql.toString()) { d ->
                        if (d.dtad__id > 0) insertados++
                    }
                } catch (Exception ex) {
                    repetidos++
                    println "Error dtad ${rgst[0]}"
                }
            }
        }
        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }


}                                                                                                          /**/
