<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/08/21
  Time: 10:53
--%>
<div class="" style="width: 100%;height: 400px; overflow-y: auto;float: right;" >
    <table class="table table-bordered table-striped table-condensed table-hover">
        <tbody>
        <g:each in="${proveedores}" status="i" var="proveedorInstance">
            <tr>
                <td style="width: 10%">${(proveedorInstance.tipo=="N")?"Natural": (proveedorInstance.tipo=="J")? "Jurídica":"Empresa Pública"}</td>
                <td style="width: 10%">${proveedorInstance?.ruc}</td>
                <td style="width: 30%">${proveedorInstance?.nombre}</td>
                <td style="width: 20%">${proveedorInstance?.nombreContacto}</td>
                <td style="width: 20%">${proveedorInstance?.apellidoContacto}</td>
                <td style="width: 10%">
                    <a class="btn btn-small btn-show btn-primary" href="#" rel="tooltip" title="Ver" data-id="${proveedorInstance.id}">
                        <i class="icon-zoom-in"></i>
                    </a>
                    <a class="btn btn-small btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${proveedorInstance.id}">
                        <i class="icon-pencil"></i>
                    </a>
                    <a class="btn btn-small btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${proveedorInstance.id}">
                        <i class="icon-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btn-show").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');
                $("#modalHeaderShow").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");
                $("#modalTitleShow").html("Ver Proveedor");
                $("#modalBodyShow").html(msg);
                $("#modalFooterShow").html("").append(btnOk);
                $("#modal-showProveedor").modal("show");
            }
        });
        return false;
    }); //click btn show


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
                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                btnSave.click(function () {
                    // submitForm(btnSave);
                    // return false;
                    guardarProveedor();
                });

                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");
                $("#modalTitle").html("Editar Proveedor");
                $("#modalBody").html(msg);
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-Proveedor").modal("show");
            }
        });
        return false;
    }); //click btn edit

    $(".btn-delete").click(function () {

        var id = $(this).data("id");
        $.box({
            imageClass: "box_info",
            text: "Está seguro de eliminar a este proveedor?",
            title: "Alerta",
            iconClose: false,
            dialog: {
                resizable: false,
                draggable: false,
                buttons: {
                    "Aceptar": function () {
                        borrarProveedor(id)
                    }
                }
            }
        });


        // var id = $(this).data("id");
        // $("#id").val(id);
        // var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
        // var btnDelete = $('<a href="#" class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');
        //
        // btnDelete.click(function () {
        //     btnDelete.replaceWith(spinner);
        //     $("#frmDelete-Proveedor").submit();
        //     return false;
        // });
        //
        // $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
        // $("#modalTitle").html("Eliminar Proveedor");
        // $("#modalBody").html("<p>¿Está seguro de querer eliminar este Proveedor?</p>");
        // $("#modalFooter").html("").append(btnOk).append(btnDelete);
        // $("#modal-Proveedor").modal("show");
        // return false;
    });


</script>