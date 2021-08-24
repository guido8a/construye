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

        %{--        <div class="span2">Ordenado por</div>--}%
    </div>

    <div class="row-fluid" style="margin-left: 20px">
        <div class="span2">
            <g:select name="buscar_name" class="buscar" from="${[1: 'Nombre', 2: 'Apellido', 3: 'RUC']}" style="width: 100%"
                      optionKey="key" optionValue="value"/>
        </div>

        <div class="span5">
            <g:textField name="criterio" style="width: 100%"/></div>

        %{--        <div class="span2">--}%
        %{--            <g:select name="ordenar_name" class="ordenar" from="${[1: 'Nombre', 2: 'Apellido', 3: 'RUC']}" style="width: 100%" optionKey="key"--}%
        %{--                      optionValue="value"/>--}%
        %{--        </div>--}%

        <div class="span4" style="margin-left: 60px">
            <button class="btn btn-info" id="btnBuscar"><i class="icon-check"></i> Buscar</button>
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

<div class="modal hide fade" id="modal-Proveedor" style="width: 900px;">
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

<script type="text/javascript">
    var url = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");

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

    function submitForm(btn) {
        if ($("#frmSave-Proveedor").valid()) {
            btn.replaceWith(spinner);
        }
        $("#frmSave-Proveedor").submit();
    }

    $(function () {

        cargarTablaProveedores($(".buscar").val(), $("#criterio").val());


        $('[rel=tooltip]').tooltip();

        $(".paginate").paginate({
            maxRows        : 10,
            searchPosition : $("#busqueda-Proveedor"),
            float          : "right"
        });

        $(".btn-new").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'form_ajax')}",
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                    btnSave.click(function () {
                        // submitForm(btnSave);
                        guardarProveedor();
                        // return false;
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


        function guardarProveedor(){
            if ($("#frmSave-Proveedor").valid()) {
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

        $(".btn-delete").click(function () {
            var id = $(this).data("id");
            $("#id").val(id);
            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
            var btnDelete = $('<a href="#" class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');

            btnDelete.click(function () {
                btnDelete.replaceWith(spinner);
                $("#frmDelete-Proveedor").submit();
                return false;
            });

            $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
            $("#modalTitle").html("Eliminar Proveedor");
            $("#modalBody").html("<p>¿Está seguro de querer eliminar este Proveedor?</p>");
            $("#modalFooter").html("").append(btnOk).append(btnDelete);
            $("#modal-Proveedor").modal("show");
            return false;
        });

    });

</script>

</body>
</html>
