
<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <thead>
    <tr>
        <th class="alinear" style="width: 10%">Código</th>
        <th class="alinear" style="width: 39%">Item</th>
        <th class="alinear" style="width: 5%">Unidad</th>
        <th class="alinear" style="width: 10%">Último movimiento</th>
        <th class="alinear" style="width: 7%">Existencias</th>
        <th class="alinear" style="width: 8%">P. Unitario</th>
        <th class="alinear" style="width: 8%">Valor</th>
        <th class="alinear" style="width: 11%"></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <g:if test="${data.size() > 0}">
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
                    <td style="width: 10%; text-align: center">
                        <a href="#" class="btn btn-primary btn-small btnKardex" data-id="${dt?.item__id}" data-krdx="${dt?.krdx__id}" title="Información del kardex del item">
                            <i class="fa fa-list"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr>
                <td colspan="8" style="text-align: center; font-size: 16px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</td>
            </tr>
        </g:else>
    </table>
</div>

<script type="text/javascript">

    var ik;

    $(".btnKardex").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'kardex', action:'infoKardex_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                ik = bootbox.dialog({
                    id      : "dlgBuscarKardex",
                    title   : "Kardex del item",
                    className: 'large',
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    })

</script>
