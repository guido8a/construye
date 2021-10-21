<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 20/10/21
  Time: 11:19
--%>

<%@ page import="janus.pac.Proveedor" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Retazos
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
</head>
<body>

<g:if test="${flash.message}">
    <div class="row">
        <div class="span12">
            <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
                <a class="close" data-dismiss="alert" href="#">×</a>
                ${flash.message}
            </div>
        </div>
    </div>
</g:if>

<div class="row">
    <div class="span9 btn-group" role="navigation">

        <a href="${createLink(controller: 'existencia', action: 'index')}" class="btn btn-ajax btn-new">
            <i class="icon-arrow-left"></i>
            Regresar
        </a>
        <a href="#" class="btn btn-ajax btn-new">
            <i class="icon-file"></i>
            Crear  Retazo
        </a>
    </div>
</div>

<div id="list-Proveedor" role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 20%">Bodega</th>
            <th style="width: 40%">Item</th>
            <th style="width:  9%">Cantidad</th>
            <th style="width: 10%">Fecha</th>
            <th style="width: 10%">Estado</th>
            <th style="width: 11%">Acciones</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${retazos}" status="i" var="retazo">
            <tr>
                <td style="width: 20%">${bodega?.descripcion}</td>
                <td style="width: 40%">${retazo?.item?.codigo + " - " + retazo?.item?.nombre}</td>
                <td style="width: 9%; text-align: center">${retazo?.cantidad}</td>
                <td style="width: 10%; text-align: center">${retazo?.fecha?.format("dd-MM-yyyy")}</td>
                <td style="width: 10%; text-align: center">${retazo?.estado == 'A' ? 'Activo' : 'Usado'}</td>
                <td style="width: 11%">
                    <a class="btn btn-small btn-primary btn-ajax btnBaja" href="#" rel="tooltip" title="Dar de baja al retazo" data-id="${retazo.id}">
                        <i class="fa fa-scissors"></i> Dar de baja
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div class="modal hide fade" id="modal-Proveedor" style="width: 550px;">
    <div class="modal-header" id="modalHeader">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<div class="modal hide fade" id="modal-Dar" style="width: 550px;">
    <div class="modal-header" id="modalHeaderDar">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitleDar"></h3>
    </div>

    <div class="modal-body" id="modalBodyDar">
    </div>

    <div class="modal-footer" id="modalFooterDar">
    </div>
</div>



<script type="text/javascript">
    %{--var url = "${resource(dir:'images', file:'spinner_24.gif')}";--}%
    // var spinner = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");

    function guardarRetazo(){
        if($("#frmRetazo").valid()){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'retazo', action: 'saveRetazo_ajax')}',
                data: $("#frmRetazo").serialize(),
                success: function(msg){
                    $("#dlgLoad").dialog("close");
                    $("#modal-Proveedor").modal("hide");
                    var parts = msg.split("_");
                    if(parts[0]=='ok'){
                        caja("Retazo guardado correctamente","Alerta");
                        setTimeout(function () {
                            location.reload(true)
                        }, 800);
                    }else{
                        if(parts[0] == 'er'){
                            caja(parts[1],"Error")
                        }else{
                            caja("Error al guardar el retazo","Error")
                        }
                    }
                }
            });
        }
    }

    function guardarBajaRetazo(){
        if($("#frmBaja").valid()){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'retazo', action: 'saveBaja_ajax')}',
                data: $("#frmBaja").serialize(),
                success: function(msg){
                    $("#dlgLoad").dialog("close");
                    $("#modal-Dar").modal("hide");
                    var parts = msg.split("_");
                    if(parts[0]=='ok'){
                        caja("Guardado correctamente","Alerta");
                        setTimeout(function () {
                            location.reload(true)
                        }, 800);
                    }else{
                        if(parts[0] == 'er'){
                            caja(parts[1],"Error")
                        }else{
                            caja("Error al guardar el retazo","Error")
                        }
                    }
                }
            });
        }
    }

    function caja(texto, titulo){
        return $.box({
            imageClass: "box_info",
            text: texto,
            title: titulo,
            iconClose: false,
            dialog: {
                resizable: false,
                draggable: false,
                width: 350,
                buttons: {
                    "Aceptar": function () {
                    }
                }
            }
        });
    }


    $("#frmRetazo").validate({
        errorPlacement : function (error, element) {
            element.parent().find(".help-block").html(error).show();
        },
        success        : function (label) {
            label.parent().hide();
        },
        errorClass     : "label label-important",
        submitHandler  : function(form) {
            $(".btn-success").replaceWith(spinner);
            form.submit();
        }
    });


    $(function () {

        $(".btn-new").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'retazo', action:'form_ajax')}",
                data:{
                    bodega: '${bodega?.id}',
                    item: '${item?.id}',
                    existencias: '${datos.exstcntd}'
                },
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                    btnSave.click(function () {
                        guardarRetazo();
                    });

                    $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitle").html("Crear Retazo");
                    $("#modalBody").html(msg);
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal-Proveedor").modal("show");
                }
            });
        }); //click btn new

        $(".btnBaja").click(function () {
            var id = $(this).data("id");
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'retazo', action:'baja_ajax')}",
                data:{
                  id: id
                },
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                    btnSave.click(function () {
                        guardarBajaRetazo();
                    });

                    $("#modalHeaderDar").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitleDar").html("Dar de baja Retazo");
                    $("#modalBodyDar").html(msg);
                    $("#modalFooterDar").html("").append(btnOk).append(btnSave);
                    $("#modal-Dar").modal("show");
                }
            });
        })


    });

</script>

</body>
</html>
