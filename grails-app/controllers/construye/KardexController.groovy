package construye

import janus.Item

/**
 * Controlador que muestra las pantallas de manejo de Kardex
 */
class KardexController {

    def dbConnectionService

    def list(){

    }

    def tabla_ajax(){
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select * from rp_existencias(${params.grupo}, 1) "
        def txwh = "where exstcntd is not null "
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%' "

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, grupo: params.grupo, bodega: params.bdga]
    }

    def infoKardex_ajax(){
        def item = Item.get(params.id)
        return [item: item]
    }

    def tablaKardex_ajax(){
        def item = Item.get(params.id)
        def kardexs = Kardex.findAllByItem(item)
        return [kardexs: kardexs]
    }
    
}
