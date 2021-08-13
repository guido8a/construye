<%=packageName ? "package ${packageName}" : ''%>

import org.springframework.dao.DataIntegrityViolationException
import <%=packageName.split("\\.")[0]%>.seguridad.Shield
<% props = domainClass.properties %>

/**
 * Controlador que muestra las pantallas de manejo de ${className}
 */
class ${className}Controller extends Shield {

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
            def c = ${className}.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    <% for (p in props) {
                        if(p.type == String && !p.name.contains("pass")) { %>
                            ilike("${p.name}", "%" + params.search + "%")  <% } } %>
                }
            }
        } else {
            list = ${className}.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return ${propertyName}List: la lista de elementos filtrados, ${propertyName}Count: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def ${propertyName}List = getList(params, false)
        def ${propertyName}Count = getList(params, true).size()
        return [${propertyName}List: ${propertyName}List, ${propertyName}Count: ${propertyName}Count]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return ${propertyName} el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if(params.id) {
            def ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
            return [${propertyName}: ${propertyName}]
        } else {
            render "ERROR*No se encontró ${className}."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     * @return ${propertyName} el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def ${propertyName} = new ${className}()
        if(params.id) {
            ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
        }
        ${propertyName}.properties = params
        return [${propertyName}: ${propertyName}]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def ${propertyName} = new ${className}()
        if(params.id) {
            ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
        }
        ${propertyName}.properties = params
        if(!${propertyName}.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar ${className}: " + renderErrors(bean: ${propertyName})
            return
        }
        render "SUCCESS*\${params.id ? 'Actualización' : 'Creación'} de ${className} exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if(params.id) {
            def ${propertyName} = ${className}.get(params.id)
            if (!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
            try {
                ${propertyName}.delete(flush: true)
                render "SUCCESS*Eliminación de ${className} exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar ${className}"
                return
            }
        } else {
            render "ERROR*No se encontró ${className}."
            return
        }
    } //delete para eliminar via ajax
    <% for (p in props) {
        unique = p.name.contains('codigo') || p.name.contains('login') || p.name.contains('mail') || p.name.contains('email')
        if(unique) { %>
            /**
             * Acción llamada con ajax que valida que no se duplique la propiedad ${p.name}
             * @render boolean que indica si se puede o no utilizar el valor recibido
             */
            def validar_unique_${p.name}_ajax() {
                params.${p.name} = params.${p.name}.toString().trim()
                if (params.id) {
                    def obj = ${className}.get(params.id)
                    if (obj.${p.name}.toLowerCase() == params.${p.name}.toLowerCase()) {
                        render true
                        return
                    } else {
                        render ${className}.countBy${p.name.capitalize()}Ilike(params.${p.name}) == 0
                        return
                    }
                } else {
                    render ${className}.countBy${p.name.capitalize()}Ilike(params.${p.name}) == 0
                    return
                }
            }
            <% }
    }
    %>
}
