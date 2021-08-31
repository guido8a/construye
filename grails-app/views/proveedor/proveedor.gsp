<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/08/21
  Time: 10:26
--%>

<%@ page import="janus.pac.Proveedor" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Proveedores
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
        <g:if test="${adquisicion != 'null'}">
            <a href="#" class="btn btn-ajax btnRegresar">
                <i class="icon-arrow-left"></i>
                Regresar
            </a>
        </g:if>
        <g:else>
            <a href="${createLink(controller: 'adquisicion', action: 'adquisicion')}" class="btn btn-ajax btn-new">
                <i class="icon-arrow-left"></i>
                Regresar
            </a>
        </g:else>
        <a href="#" class="btn btn-ajax btn-new">
            <i class="icon-file"></i>
            Crear  Proveedor
        </a>
    </div>
</div>

<fieldset class="borde" style="border-radius: 4px; margin-top: 10px">
    <div class="row-fluid" style="margin-left: 20px">
        <div class="span2">Buscar Por</div>
        <div class="span5">Criterio</div>
    </div>

    <div class="row-fluid" style="margin-left: 20px">
        <div class="span2">
            <g:select name="buscar_name" class="buscar" from="${[1: 'Nombre', 2: 'Apellido', 3: 'RUC']}" style="width: 100%"
                      optionKey="key" optionValue="value"/>
        </div>

        <div class="span5">
            <g:textField name="criterio" style="width: 100%"/></div>

        <div class="span4" style="margin-left: 60px">
            <button class="btn btn-info" id="btnBuscar"><i class="icon-search"></i> Buscar</button>
            <button class="btn btn-primary" id="btnLimpiar"><i class="icon-eraser"></i> Limpiar</button>
        </div>
    </div>
</fieldset>


<div id="list-Proveedor" role="main" style="margin-top: 10px;">

    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Tipo</th>
            <th style="width: 10%">RUC</th>
            <th style="width: 29%">Nombre</th>
            <th style="width: 20%">Nombre contacto</th>
            <th style="width: 20%">Apellido contacto</th>
            <th style="width: 11%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="tablaProveedores" style="margin-top: -20px">

    </div>

</div>

<div class="modal hide fade" id="modal-Proveedor" style="width: 930px;">
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

<div class="modal hide fade" id="modal-showProveedor" style="width: 600px;">
    <div class="modal-header" id="modalHeaderShow">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitleShow"></h3>
    </div>

    <div class="modal-body" id="modalBodyShow">
    </div>

    <div class="modal-footer" id="modalFooterShow">
    </div>
</div>

<script type="text/javascript">
    var url = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");


    $(".btnRegresar").click(function () {
       location.href="${createLink(controller: 'adquisicion', action: 'adquisicion')}/" + '${adquisicion}'
    });

    function cargarTablaProveedores(campo, busqueda){
        $("#dlgLoad").dialog("open");
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proveedor', action: 'tablaProveedores_ajax')}',
            data:{
                campo: campo,
                busqueda: busqueda
            },
            success: function(msg){
                $("#dlgLoad").dialog("close");
                $("#tablaProveedores").html(msg)
            }
        });
    }

    $("#btnBuscar").click(function () {
        var campo = $(".buscar").val();
        var buscar = $("#criterio").val();
        cargarTablaProveedores(campo, buscar)
    });

    $("#btnLimpiar").click(function () {
        var campo = $(".buscar").val(1);
        var buscar = $("#criterio").val("");
        cargarTablaProveedores($(".buscar").val(), $("#criterio").val());
    });

    function guardarProveedor(){
        if($("#frmSave-Proveedor").valid()){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'proveedor', action: 'saveProveedor_ajax')}',
                data: $("#frmSave-Proveedor").serialize(),
                success: function(msg){
                    $("#dlgLoad").dialog("close");
                    $("#modal-Proveedor").modal("hide");
                    if(msg=='ok'){
                        caja("Proveedor guardado correctamente","Alerta")
                        cargarTablaProveedores($(".buscar").val(), $("#criterio").val());
                    }else{
                        caja("Error al guardar el proveedor","Error")
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
                buttons: {
                    "Aceptar": function () {
                    }
                }
            }
        });
    }

    function borrarProveedor(id){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proveedor', action: 'borrarProveedor_ajax')}',
            data:{
                id: id
            },
            success: function(msg){
                cargarTablaProveedores($(".buscar").val(), $("#criterio").val());
                caja("Borrado correctamente", "Alerta")
            }
        })
    }

    $("#frmSave-Proveedor").validate({
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

        cargarTablaProveedores($(".buscar").val(), $("#criterio").val());

        $(".btn-new").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'form_ajax')}",
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                    btnSave.click(function () {
                        guardarProveedor();
                    });

                    $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitle").html("Crear Proveedor");
                    $("#modalBody").html(msg);
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal-Proveedor").modal("show");
                }
            });
            // return false;
            %{--location.href="${g.createLink(action: 'form')}"--}%
        }); //click btn new




        %{--$(".btn-edit").click(function () {--}%
        %{--    var id = $(this).data("id");--}%
        %{--    $.ajax({--}%
        %{--        type    : "POST",--}%
        %{--        url     : "${createLink(action:'form_ajax')}",--}%
        %{--        data    : {--}%
        %{--            id : id--}%
        %{--        },--}%
        %{--        success : function (msg) {--}%
        %{--            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
        %{--            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');--}%

        %{--            btnSave.click(function () {--}%
        %{--                submitForm(btnSave);--}%
        %{--                return false;--}%
        %{--            });--}%

        %{--            $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");--}%
        %{--            $("#modalTitle").html("Editar Proveedor");--}%
        %{--            $("#modalBody").html(msg);--}%
        %{--            $("#modalFooter").html("").append(btnOk).append(btnSave);--}%
        %{--            $("#modal-Proveedor").modal("show");--}%
        %{--        }--}%
        %{--    });--}%
        %{--    return false;--}%
        %{--    --}%%{--location.href="${g.createLink(action: 'form')}/"+id--}%
        %{--}); //click btn edit--}%

        %{--$(".btn-show").click(function () {--}%
        %{--    var id = $(this).data("id");--}%
        %{--    $.ajax({--}%
        %{--        type    : "POST",--}%
        %{--        url     : "${createLink(action:'show_ajax')}",--}%
        %{--        data    : {--}%
        %{--            id : id--}%
        %{--        },--}%
        %{--        success : function (msg) {--}%
        %{--            var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');--}%
        %{--            $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");--}%
        %{--            $("#modalTitle").html("Ver Proveedor");--}%
        %{--            $("#modalBody").html(msg);--}%
        %{--            $("#modalFooter").html("").append(btnOk);--}%
        %{--            $("#modal-Proveedor").modal("show");--}%
        %{--        }--}%
        %{--    });--}%
        %{--    return false;--}%
        %{--}); //click btn show--}%

    });

</script>

</body>
</html>
