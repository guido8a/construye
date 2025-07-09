<%@ page import="janus.Item" %>

<style>
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}

</style>


<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Orden</th>
            <th style="width: 15%">Código</th>
            <th style="width: 50%">Descripción</th>
            <th style="width: 15%">Cant.</th>
            <th style="width: 9%"></th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 475px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${valores}">
            <g:each in="${valores}" var="val" status="i">
                <tr>
                    <td style="width: 10%; font-size: 10px">${val.vlobordn}</td>
                    <td style="width: 15%; font-size: 10px">${val.rbrocdgo}</td>
                    <td style="width: 50%; font-size: 12px">${val.rbronmbr}</td>
                    <td style="width: 15%"><g:formatNumber number="${val.vlobcntd}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/></td>
                    <td style="width: 9%">
                        <g:if test="${obra.estado!='R' && duenoObra == 1}">
                            <a href="#" class="btn btn-danger btn-xs btnBorrarSeleccion" data-id="${val.vlob__id}" ><i class="fa fa-trash"></i></a>
                        </g:if>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-info" style="text-align: center">
                <i class="fa fa-exclamation-triangle text-info fa-2x"></i> <strong style="font-size: 14px"> Ningún rubro agregado al subpresupuesto </strong>
            </div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnBorrarSeleccion").click(function () {
        var id = $(this).data("id");
        bootbox.confirm({
            title: "Eliminar",
            message: "<i class='fa fa-exclamation-triangle text-info fa-3x'></i> <strong style='font-size: 14px'> Está seguro de eliminar este rubro?</strong> ",
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-primary'
                },
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    // var d = cargarLoader("Borrando...");
                    $.ajax({
                        type : "POST",
                        url : "${g.createLink(controller: 'volumenObra',action:'eliminarRubroNuevo')}",
                        data     : {
                            id: id
                        },
                        success  : function (msg) {
                            // d.modal("hide");
                            if(msg === "ok"){
                                caja("Rubro borrado correctamente", "Borrado");
                                cargarTablaSeleccionados();
                            }else{
                                bootbox.alert('<i class="fa fa-exclamation-triangle text-info fa-3x"></i> ' + '<strong style="font-size: 14px">' + msg +'</strong>');
                            }
                        }
                    });
                }
            }
        });
    });

</script>