package janus.construye

import janus.Persona
import org.springframework.dao.DataIntegrityViolationException
import janus.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Bodega
 */
class BodegaController {

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
            def c = Bodega.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                            ilike("descripcion", "%" + params.search + "%")  
                            ilike("direccion", "%" + params.search + "%")  
                            ilike("nombre", "%" + params.search + "%")  
                            ilike("telefono", "%" + params.search + "%")  
                            ilike("tipo", "%" + params.search + "%")  
                }
            }
        } else {
            list = Bodega.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return bodegaInstanceList: la lista de elementos filtrados, bodegaInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def persona = Persona.get(session.usuario.id)
        def empresa = Empresa.get(persona.empresa.id)
        def bodegas = Bodega.findAllByEmpresa(empresa).sort{it.nombre}
        return[bodegas:bodegas, empresa:empresa]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return bodegaInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if(params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if(!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
            return [bodegaInstance: bodegaInstance]
        } else {
            render "ERROR*No se encontró Bodega."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     * @return bodegaInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def persona = Persona.get(session.usuario.id)
        def empresa = Empresa.get(persona.empresa.id)
        def bodegaInstance = new Bodega()
        if(params.id) {
            bodegaInstance = Bodega.get(params.id)
            if(!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
        }
        bodegaInstance.properties = params
        return [bodegaInstance: bodegaInstance, empresa: empresa]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */

    def save_ajax() {

      def bodega
        if (params.id) {
            bodega = Bodega.get(params.id)
            if (!bodega) {
                flash.clase = "alert-error"
                flash.message = "No se encontró la bodega"
                redirect(action: 'list')
                return
            }//no existe el objeto
            bodega.properties = params
        }//es edit
        else {
            bodega = new Bodega()
            bodega.properties = params
        } //es create
        if (!bodega.save(flush: true)) {
            flash.clase = "alert-error"
            println("error al guardar la bodega " + bodega.errors)
            def str = "<h4>No se pudo guardar la bodega </h4>"
//            str += "<ul>"
//            bodega.errors.allErrors.each { err ->
//                def msg = err.defaultMessage
//                err.arguments.eachWithIndex {  arg, i ->
//                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
//                }
//                str += "<li>" + msg + "</li>"
//            }
//            str += "</ul>"

            flash.message = str
            redirect(action: 'list')
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente la bodega: " + bodega.nombre
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente la bodega: " + bodega.nombre
        }
        redirect(action: 'list')
    } //save

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete() {
        def bodega = Bodega.get(params.id)
        if (!bodega) {
            flash.clase = "alert-error"
            flash.message = "No se encontró la bodega"
            redirect(action: "list")
            return
        }

        try {
            bodega.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente la bodega: " + bodega.nombre
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar la bodega "
            redirect(action: "list")
        }
    } //delete
}
