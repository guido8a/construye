

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Bodegas</title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
</head>
<body>

<div class="span12">
    <g:if test="${flash.message}">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            ${flash.message}
        </div>
    </g:if>
</div>
<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-default btnCrear">
            <i class="icon-file"></i> Nueva bodega
        </a>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover">
    <thead>
    <tr>
        <th style="width: 15%">Nombre</th>
        <th style="width: 35%">Descripción</th>
        <th style="width: 25%">Dirección</th>
        <th style="width: 10%">Teléfono</th>
        <th style="width: 5%">Tipo</th>
        <th style="width: 15%">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${bodegas.size() > 0}">
        <g:each in="${bodegas}" status="i" var="bodega">
            <tr data-id="${bodega.id}">
                <td>${bodega.nombre}</td>
                <td>${bodega.descripcion}</td>
                <td>${bodega.direccion}</td>
                <td>${bodega.telefono}</td>
                <td>${bodega.tipo}</td>
                <td>
                    <a class="btn btn-small btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${bodega.id}">
                        <i class="icon-pencil"></i>
                    </a>
                    <a class="btn btn-small btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${bodega .id}">
                        <i class="icon-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr class="danger">
            <td class="text-center" colspan="2">
                <g:if test="${params.search && params.search!= ''}">
                    No se encontraron resultados para su búsqueda
                </g:if>
                <g:else>
                    No se encontraron registros que mostrar
                </g:else>
            </td>
        </tr>
    </g:else>
    </tbody>
</table>

<g:form action="delete" name="frmDelete-tipoItemInstance">
    <g:hiddenField name="id"/>
</g:form>

<div class="modal hide fade" id="modal-bodega">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<script type="text/javascript">

    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        $("#id").val(id);
        var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
        var btnDelete = $('<a href="#" class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');

        btnDelete.click(function () {
            btnDelete.replaceWith(spinner);
            $("#frmDelete-tipoItemInstance").submit();
            return false;
        });

        $("#modalTitle").html("Eliminar Bodega");
        $("#modalBody").html("<p>¿Está seguro de querer eliminar esta bodega?</p>");
        $("#modalFooter").html("").append(btnOk).append(btnDelete);
        $("#modal-bodega").modal("show");
        return false;
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Guardar</a>');

                btnSave.click(function () {
                    if ($("#frmBodega").valid()) {
                        btnSave.replaceWith(spinner);
                    }
                    $("#frmBodega").submit();
                    return false;
                });

                $("#modalTitle").html("Editar Bodega");
                $("#modalBody").html(msg);
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-bodega").modal("show");
            }
        });
        return false;
    }); //click btn edit

    $(".btnCrear").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Guardar</a>');

                btnSave.click(function () {
                    if ($("#frmBodega").valid()) {
                        btnSave.replaceWith(spinner);
                    }
                    $("#frmBodega").submit();
                    return false;
                });

                $("#modalTitle").html("Crear Bodega");
                $("#modalBody").html(msg);
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-bodega").modal("show");
            }
        });
        return false;
    }); //click btn new

</script>

</body>
</html>
