
<%@ page import="janus.construye.Empresa" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Empresas</title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
</head>
<body>

%{--<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>--}%

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-default btnCrear">
            <i class="icon-file"></i> Nueva empresa
        </a>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover">
    <thead>
    <tr>
        <th style="width: 10%">RUC</th>
        <th style="width: 35%">Nombre</th>
        <th style="width: 25%">Dirección</th>
        <th style="width: 10%">Email</th>
        <th style="width: 10%">Teléfono</th>
        <th style="width: 10%">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${empresaInstanceCount > 0}">
        <g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
            <tr data-id="${empresaInstance.id}">
                <td style="width: 10%">${empresaInstance.ruc}</td>
                <td style="width: 35%">${empresaInstance.nombre}</td>
                <td style="width: 25%">${empresaInstance.direccion}</td>
                <td style="width: 10%">${empresaInstance.email}</td>
                <td style="width: 10%">${empresaInstance.telefono}</td>
                <td style="width: 10%">
                    <a class="btn btn-small btn-primary showItem" href="#" rel="tooltip" title="Mostrar"
                       data-id="${empresaInstance.id}">
                        <i class="icon-search"></i>
                    </a>
                    <a class="btn btn-small btn-primary editarItem" href="#" rel="tooltip" title="Editar"
                       data-id="${empresaInstance.id}">
                        <i class="icon-edit"></i>
                    </a>
                    <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar"
                       data-id="${empresaInstance.id}">
                        <i class="icon-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr class="danger">
            <td class="text-center" colspan="11">
                No se encontraron registros que mostrar
            </td>
        </tr>
    </g:else>
    </tbody>
</table>

<div class="modal large hide fade" id="modal-empresa" style="width: 900px;">
    <div class="modal-header" id="modalHeader">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody" >
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<div class="modal large hide fade" id="modal-empresa_show" style="width: 600px;">
    <div class="modal-header" id="modalHeader_show">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitle_show"></h3>
    </div>

    <div class="modal-body" id="modalBody_show" >
    </div>

    <div class="modal-footer" id="modalFooter_show">
    </div>
</div>


<script type="text/javascript">

    $(".showItem").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');
                $("#modalHeader_show").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");
                $("#modalTitle_show").html("Ver Empresa");
                $("#modalBody_show").html(msg);
                $("#modalFooter_show").html("").append(btnOk);
                $("#modal-empresa_show").modal("show");
            }
        });
        return false;
    }); //click btn show

    $(".borrarItem").click(function () {

        var id = $(this).data("id");
        $.box({
            imageClass: "box_info",
            text: "Está seguro que desea eliminar esta empresa?",
            title: "Eliminar empresa",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#dlgLoad").dialog("open");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'empresa', action: 'eliminarEmpresa_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                $("#dlgLoad").dialog("close");
                                if (msg == 'ok') {
                                    caja("Empresa borrada correctamente","Alerta")
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                } else {
                                    caja("Error al eliminar la empresa","Error")
                                }
                            }
                        })
                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    });

    $(".btnCrear").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                btnSave.click(function () {
                    guardarEmpresa();
                });

                $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                $("#modalTitle").html("Crear Empresa");
                $("#modalBody").html(msg);
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-empresa").modal("show");
            }
        });
        // return false;
        %{--location.href="${g.createLink(action: 'form')}"--}%
    }); //click btn new


    $(".editarItem").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                btnSave.click(function () {
                    guardarEmpresa();
                });

                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");
                $("#modalTitle").html("Editar Empresa");
                $("#modalBody").html(msg);
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-empresa").modal("show");
            }
        });
        return false;
    }); //click btn edit

    function guardarEmpresa(){
        if($("#frmSave-Empresa").valid()){
            $("#dlgLoad").dialog("open");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'empresa', action: 'saveEmpresa_ajax')}',
                data: $("#frmSave-Empresa").serialize(),
                success: function(msg){
                    $("#dlgLoad").dialog("close");
                    $("#modal-empresa").modal("hide");
                    if(msg=='ok'){
                        $.box({
                            imageClass: "box_info",
                            text: "Empresa guardada correctamente",
                            title: "Alerta",
                            iconClose: false,
                            dialog: {
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    "Aceptar": function () {
                                        location.href="${createLink(controller: 'empresa', action: 'list')}"
                                    }
                                }
                            }
                        });
                    }else{
                        caja("Error al guardar la empresa","Error")
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

    $("#frmSave-Empresa").validate({
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


</script>

</body>
</html>
