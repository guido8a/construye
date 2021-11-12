<%@ page import="janus.construye.Bodega; janus.Item" %>
%{--
<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>
    <tr>
        <th style="width: 10%">Código</th>
        <th style="width: 54%">Descripción</th>
        <th style="width: 15%">Cantidad</th>
        <th style="width: 12%">Precio U.</th>
        <th style="width: 9%">Seleccionar</th>
    </tr>
    </thead>

    <tbody>
    </tbody>

</table>
--}%

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: 0px">
%{--    <table class="table-bordered table-condensed table-hover" style="width: 100%">--}%
         <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <g:each in="${data}" var="dt" status="i">
            <tr data-krdx="${dt?.krdx__id}">
                <td style="width: 10%">${dt.itemcdgo}</td>
                <td style="width: 38%">${dt.itemnmbr}</td>
                <td style="width: 5%">${dt.unddcdgo}</td>
                <td style="width: 10%">${dt.krdxfcha?.format('dd-MMM-yyyy HH:mm')}</td>
                <td style="width: 7%; text-align: center">
                    <g:formatNumber number="${dt.exstcntd}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                </td>
                <td style="width: 8%; text-align: right">${dt.exstpcun}</td>
                <td style="width: 8%; text-align: right">${dt.exstvlor}</td>
                <td style="width: 4%; text-align: center; font-weight: bold">${construye.Retazo.findAllByItemAndBodegaAndEstado(janus.Item.get(dt.item__id), janus.construye.Bodega.get(params.bdga), 'A').size()}</td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-primary btn-small btnRetazo" data-id="${dt?.item__id}"
                       data-krdx="${dt?.krdx__id}" title="Generar Retazo del Item">
                        <i class="fa fa-puzzle-piece"></i>
                    </a>
                    <g:if test="${dt?.exstpcun == 0.0001}">
                        <a href="#" class="btn btn-primary btn-small btnCambiar" data-id="${dt?.item__id}"
                           data-krdx="${dt?.krdx__id}" title="Cambiar el precio unitario del Item">
                            <i class="fa fa-dollar"></i>
                        </a>
                    </g:if>

                </td>
                %{--<td style="width: 8%"><div style="text-align: center" class="seleccionaItem" id="reg_${i}"--}%
                                           %{--regId="${dt?.item__id}" regNmbr="${dt?.itemnmbr}" regCdgo="${dt?.itemcdgo}"--}%
                                           %{--regUn="${dt?.unddcdgo}" regPc="${dt?.exstpcun}" data-id="${dt?.item__id}">--}%
                    %{--<button class="btn btn-small btn-success"><i class="icon-check"></i></button>--}%
                %{--</div></td>--}%
            </tr>
        </g:each>
    </table>
</div>



<div class="modal hide fade" id="modal-Precio" style="width: 600px;">
    <div class="modal-header" id="modalHeaderShow">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitleShow"></h3>
    </div>

    <div class="modal-body" id="modalBodyShow">
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
        </button>
        <button type="button" class="btn btnCambiarPrecio btn-success" data-dismiss="modal"><i class="fa fa-print"></i> Aceptar
        </button>
    </div>
</div>


<script type="text/javascript">

    $(".btnRetazo").click(function () {
        var id = $(this).data("id");
       location.href="${createLink(controller: 'existencia', action: 'retazo')}?id=" + id + "&bdga=" + '${bodega}' + "&grp=" + '${grupo}'
    });


    $(".btnCambiar").click(function () {
        var id = $(this).data("krdx");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'existencia', action:'precio_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                // var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary" >Aceptar</a>');
                $("#modalHeaderShow").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");
                $("#modalTitleShow").html("Precio unitario");
                $("#modalBodyShow").html(msg);
                // $("#modalFooterShow").html("").append(btnOk);
                $("#modal-Precio").modal("show");
            }
        });
        return false;
    }); //click btn show

    $(".btnCambiarPrecio").click(function () {
        var precio = $("#precioNuevo").val();
        var id = $("#idKardex").val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'existencia', action:'guardarPrecio_ajax')}",
            data    : {
                 id : id,
                 precio: precio
            },
            success : function (msg) {
                if(msg == 'ok'){
                    $.box({
                        imageClass: "box_info",
                        text: "Precio unitario cambiado correctamente",
                        title: "Precio cambiado",
                        iconClose: false,
                        dialog: {
                            resizable: false,
                            draggable: false,
                            buttons: {
                                "Aceptar": function () {
                                    $("#dlgLoad").dialog("open");
                                    busqueda();
                                }
                            },
                            width: 400
                        }
                    });
                }else{
                    $.box({
                        imageClass: "box_info",
                        text: "Error al cambiar el precio unitario",
                        title: "Error",
                        iconClose: false,
                        dialog: {
                            resizable: false,
                            draggable: false,
                            buttons: {
                                "Aceptar": function () {
                                }
                            },
                            width: 400
                        }
                    });
                }
            }
        });
    });

    %{--$(".btnRetazo").click(function () {--}%
    %{--    var id = $(this).data("id");--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'existencia', action:'retazo_ajax')}",--}%
    %{--        data    : {--}%
    %{--            id : id--}%
    %{--        },--}%
    %{--        success : function (msg) {--}%
    %{--            var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');--}%
    %{--            $("#modalHeaderShow").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");--}%
    %{--            $("#modalTitleShow").html("Retazos");--}%
    %{--            $("#modalBodyShow").html(msg);--}%
    %{--            $("#modalFooterShow").html("").append(btnOk);--}%
    %{--            $("#modal-showProveedor").modal("show");--}%
    %{--        }--}%
    %{--    });--}%
    %{--    return false;--}%
    %{--}); //click btn show--}%



    // $(".seleccionaItem").click(function () {
    //     var id = $(this).attr("regId");
    //     $("#item_id").val($(this).attr("regId"));
    //     $("#item_id_original").val($(this).data("id"));
    //     $("#cdgo_buscar").val($(this).attr("regCdgo"));
    //     $("#item_desc").val($(this).attr("regNmbr"));
    //     $("#item_unidad").val($(this).attr("regUn"));
    //     $("#item_precio").val($(this).attr("regPc"));
    //     $("#busqueda").dialog("close");
    // });
</script>

