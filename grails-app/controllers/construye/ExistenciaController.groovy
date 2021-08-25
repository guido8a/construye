package construye

import janus.construye.Bodega

class ExistenciaController {
    def dbConnectionService

    def index() {
        def listaItems = [1: 'Nombre', 2: 'Código']
        def bodegas = Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])

        [bodegas:bodegas, listaItems: listaItems]
    }

    def listaExst() {
        println "listaExst" + params
        def listaItems = ['itemnmbr', 'itemcdgo']
        def datos;
        def select = "select * from rp_existencias(${params.grupo}, ${params.bdga}) "
        def txwh = "where exstcntd > 0 "
        def sqlTx = ""
        def bsca = listaItems[params.buscarPor.toInteger()-1]
        def ordn = listaItems[params.ordenar.toInteger()-1]
        txwh += " and $bsca ilike '%${params.criterio}%' "

        sqlTx = "${select} ${txwh} order by ${ordn} limit 100 ".toString()
        println "sql: $sqlTx"

        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
//        println "data: ${datos[0]}"
        [data: datos]
    }


}
