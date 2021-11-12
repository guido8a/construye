package construye

import janus.Item
import janus.construye.Bodega

class ExistenciaController {
    def dbConnectionService

    def index() {
        def listaItems = [1: 'Nombre', 2: 'Código']
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])

        [bodegas:bodegas, listaItems: listaItems]
    }

    def listaExst() {
//        println "listaExst" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select * from rp_existencias(${params.grupo}, ${params.bdga}) "
        def txwh = "where exstcntd > 0 "
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%' "

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
//        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
//        println "data: ${datos[0]}"
        [data: datos, grupo: params.grupo, bodega: params.bdga]
    }

    def retazo(){
//        println("params " + params)
        def item = Item.get(params.id)
        def bodega = Bodega.get(params.bdga.toInteger())
        def select = "select * from rp_existencias(${params.grp.toInteger()}, ${params.bdga.toInteger()}) where item__id = ${item?.id}"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(select)

//        println("datos " + datos[0])

        def retazos = Retazo.findAllByItemAndBodegaAndEstado(item, bodega, 'A').sort{it.fecha}

        return[retazos: retazos, datos: datos[0], bodega: bodega, item: item]
    }

    def precio_ajax(){
        def kardex = Kardex.get(params.id)
        return[kardex:kardex]
    }

    def guardarPrecio_ajax(){
        println("---> " + params)
        def kardex = Kardex.get(params.id)

        kardex.precioUnitario = params.precio.toDouble()
        kardex.precioCosto = params.precio.toDouble()

        if(!kardex.save(flush:true)){
            println("error al guardar el precio unitario en kardex " + kardex.errors)
            render "no"
        }else{
            render "ok"
        }
    }


}
