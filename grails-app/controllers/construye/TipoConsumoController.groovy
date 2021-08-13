package construye

import janus.TipoItem
import org.springframework.dao.DataIntegrityViolationException

/**
 * Controlador que muestra las pantallas de manejo de TipoConsumo
 */
class TipoConsumoController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action:"list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if(all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if(params.search) {
            def c = TipoConsumo.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                            ilike("codigo", "%" + params.search + "%")  
                            ilike("descripcion", "%" + params.search + "%")  
                }
            }
        } else {
            list = TipoConsumo.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return tipoConsumoInstanceList: la lista de elementos filtrados, tipoConsumoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def tipoConsumoInstanceList = getList(params, false)
        def tipoConsumoInstanceCount = getList(params, true).size()
        return [tipoConsumoInstanceList: tipoConsumoInstanceList, tipoConsumoInstanceCount: tipoConsumoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return tipoConsumoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if(params.id) {
            def tipoConsumoInstance = TipoConsumo.get(params.id)
            if(!tipoConsumoInstance) {
                render "ERROR*No se encontró TipoConsumo."
                return
            }
            return [tipoConsumoInstance: tipoConsumoInstance]
        } else {
            render "ERROR*No se encontró TipoConsumo."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     * @return tipoConsumoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def tipoConsumoInstance = new TipoConsumo()
        if(params.id) {
            tipoConsumoInstance = TipoConsumo.get(params.id)
            if(!tipoConsumoInstance) {
                render "ERROR*No se encontró TipoConsumo."
                return
            }
        }
        tipoConsumoInstance.properties = params
        return [tipoConsumoInstance: tipoConsumoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {


        params.codigo = params.codigo.toUpperCase();

        def existe = TipoConsumo.findByCodigo(params.codigo)

        def tipoConsumoInstance
        if (params.id) {
            tipoConsumoInstance = TipoConsumo.get(params.id)
            if (!tipoConsumoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró el tipo de consumo con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            tipoConsumoInstance.properties = params
        }//es edit
        else {
            if(!existe){
                tipoConsumoInstance = new TipoConsumo(params)
            }else{
                flash.clase = "alert-error"
                flash.message = "No se pudo guardar el tipo de consumo, el código ya existe!!"
                redirect(action: 'list')
                return
            }

        } //es create
        if (!tipoConsumoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Tipo de Consumo:  " + (tipoConsumoInstance.id ? tipoConsumoInstance.id : "") + "</h4>"

            str += "<ul>"
            tipoConsumoInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex {  arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list')
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Tipo de Consumo: " + tipoConsumoInstance.descripcion
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Tipo de Consumo: " + tipoConsumoInstance.descripcion
        }
        redirect(action: 'list')
    } //save

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if(params.id) {
            def tipoConsumoInstance = TipoConsumo.get(params.id)
            if (!tipoConsumoInstance) {
                render "ERROR*No se encontró TipoConsumo."
                return
            }
            try {
                tipoConsumoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoConsumo exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoConsumo"
                return
            }
        } else {
            render "ERROR*No se encontró TipoConsumo."
            return
        }
    } //delete para eliminar via ajax
    
            /**
             * Acción llamada con ajax que valida que no se duplique la propiedad codigo
             * @render boolean que indica si se puede o no utilizar el valor recibido
             */
            def validar_unique_codigo_ajax() {
                params.codigo = params.codigo.toString().trim()
                if (params.id) {
                    def obj = TipoConsumo.get(params.id)
                    if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                        render true
                        return
                    } else {
                        render TipoConsumo.countByCodigoIlike(params.codigo) == 0
                        return
                    }
                } else {
                    render TipoConsumo.countByCodigoIlike(params.codigo) == 0
                    return
                }
            }


    def delete() {
        def tipoConsumoInstance = TipoConsumo.get(params.id)
        if (!tipoConsumoInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Tipo de Consumo con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            tipoConsumoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Tipo de Consumo " + tipoConsumoInstance.descripcion
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar el tipo de Consumo " + (tipoConsumoInstance.id ? tipoConsumoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
            
}
