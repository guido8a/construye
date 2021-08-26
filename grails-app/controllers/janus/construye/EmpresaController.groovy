package janus.construye

import janus.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Empresa
 */
class EmpresaController extends Shield {

    def list(){
        def empresas = Empresa.list([sort: 'nombre'])
        def empresaInstanceCount = empresas.size()
        return[empresaInstanceList: empresas, empresaInstanceCount: empresaInstanceCount]
    }

    def form_ajax(){

        def empresaInstance

        if(params.id){
            empresaInstance = Empresa.get(params.id)
        }else{
            empresaInstance = new Empresa()
        }

        return[empresaInstance: empresaInstance]
    }

    def show_ajax(){
        def empresaInstance

        if(params.id){
            empresaInstance = Empresa.get(params.id)
        }else{
            empresaInstance = new Empresa()
        }

        return[empresaInstance: empresaInstance]
    }

    def saveEmpresa_ajax(){
        println("params " + params)
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        if(params.lugar){
            params?.lugar = params?.lugar?.toUpperCase()
        }

        empresa.properties = params

        if(!empresa.save(flush:true)){
            println("error al guardar la empresa " + empresa.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def eliminarEmpresa_ajax(){

        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la empresa " + empresa.errors)
            render "no"
        }
    }


}
