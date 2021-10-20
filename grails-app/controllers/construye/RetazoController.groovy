package construye

/**
 * Controlador que muestra las pantallas de manejo de Retazo
 */
class RetazoController  {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def form_ajax(){
        def retazoInstance

        if(params.id){
            retazoInstance = Retazo.get(params.id)
        }else{
            retazoInstance = new Retazo()
        }

        return [retazoInstance: retazoInstance]
    }

}
