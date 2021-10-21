package construye

import janus.Item
import janus.construye.Bodega

import java.text.DecimalFormat

/**
 * Controlador que muestra las pantallas de manejo de Retazo
 */
class RetazoController  {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def form_ajax(){
//        println("params f " + params)

        def existencias = params?.existencias?.toDouble()
        def bodega = Bodega.get(params.bodega)
        def item = Item.get(params.item)
        def retazosExistentes = Retazo.findAllByItemAndBodegaAndEstado(item,bodega,'A')

        def disponible

        if(existencias){
            disponible = existencias - (retazosExistentes.cantidad.sum() ?: 0)
        }else{
            disponible = 0
        }

        def d1 =  g.formatNumber(number:disponible, minFractionDigits: 2, maxFractionDigits: 2, format: "##,##0", locale: "ec")

        def retazoInstance

        if(params.id){
            retazoInstance = Retazo.get(params.id)
        }else{
            retazoInstance = new Retazo()
        }

        return [retazoInstance: retazoInstance, bodega: bodega, item: item, existencias: params.existencias, disponible: d1]
    }

    def saveRetazo_ajax(){
        println("params retazo " + params)

        def retazo
        def existencias = params?.ex?.toDouble()
        def bodega = Bodega.get(params.bodega)
        def item = Item.get(params.item)
        def retazosExistentes = Retazo.findAllByItemAndBodegaAndEstado(item,bodega,'A')

        def disponible

        if(existencias){
            disponible = existencias - (retazosExistentes.cantidad?.sum() ?: 0)
        }else{
            disponible = 0
        }

        def d1 =  g.formatNumber(number:disponible, minFractionDigits: 2, maxFractionDigits: 2, format: "##,##0", locale: "ec")

        if(params.cantidad?.toDouble() > 0){
            if(params.cantidad?.toDouble() > d1?.toDouble()){
                render "er_" + "La cantidad ingresada es mayor a la cantidad disponible: " +  d1
            }else{
                retazo = new Retazo()
                retazo.bodega = bodega
                retazo.item = item
                retazo.cantidad = params.cantidad?.toDouble()
                retazo.fecha = new Date()

                if(!retazo.save(flush:true)){
                    println("error al crear el retazo " + retazo.errors)
                    render "no"
                }else{
                    render "ok"
                }
            }

        }else{
            render "er_" + "No se puede crear un retazo con valor cero"
        }
    }

    def baja_ajax(){
        def retazo = Retazo.get(params.id)
        return[retazo: retazo]
    }

    def saveBaja_ajax(){
        def retazo = Retazo.get(params.id)
        def derivado

        def d1 =  g.formatNumber(number:retazo.cantidad, minFractionDigits: 2, maxFractionDigits: 2, format: "##,##0", locale: "ec")

        if(params.cantidad?.toDouble() > 0){
            if(params.cantidad?.toDouble() > d1?.toDouble()){
                render "er_" + "La cantidad ingresada es mayor a la cantidad disponible: " +  d1
            }else{

                if(params.cantidad?.toDouble() == d1?.toDouble()){
                    retazo.estado = 'N'
                    retazo.fechaFin = new Date()
                    retazo.save(flush: true)
                    render "ok"
                }else{
                    derivado = new Retazo()
                    derivado.bodega = retazo.bodega
                    derivado.item = retazo.item
                    derivado.cantidad = (d1?.toDouble() - params.cantidad?.toDouble())
                    derivado.fecha = new Date()

                    if(!derivado.save(flush:true)){
                        println("error al crear el retazo derivado " + retazo.errors)
                        render "no"
                    }else{
                        retazo.estado = 'N'
                        retazo.fechaFin = new Date()
                        retazo.save(flush: true)
                        render "ok"
                    }
                }
            }

        }else{
            render "er_" + "No se puede crear un retazo con valor cero"
        }

    }

}
