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
            <tr>
                <td style="width: 10%">${dt.itemcdgo}</td>
                <td style="width: 42%">${dt.itemnmbr}</td>
                <td style="width: 8%">${dt.unddcdgo}</td>
                <td style="width: 10%">${dt.krdxfcha?.format('dd-MMM-yyyy HH:mm')}</td>
                <td style="width: 10%">
                    <g:formatNumber number="${dt.exstcntd}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                </td>
                <td style="width: 10%">${dt.exstpcun}</td>
                <td style="width: 10%">${dt.exstvlor}</td>
                %{--<td style="width: 8%"><div style="text-align: center" class="seleccionaItem" id="reg_${i}"--}%
                                           %{--regId="${dt?.item__id}" regNmbr="${dt?.itemnmbr}" regCdgo="${dt?.itemcdgo}"--}%
                                           %{--regUn="${dt?.unddcdgo}" regPc="${dt?.exstpcun}" data-id="${dt?.item__id}">--}%
                    %{--<button class="btn btn-small btn-success"><i class="icon-check"></i></button>--}%
                %{--</div></td>--}%
            </tr>
        </g:each>
    </table>
</div>


<script type="text/javascript">
    $(".seleccionaItem").click(function () {
        var id = $(this).attr("regId");
        %{--location.href = "${g.createLink(action: 'consumo', controller: 'consumo')}" + "?id=" + id--}%
        $("#item_id").val($(this).attr("regId"));
        $("#item_id_original").val($(this).data("id"));
        $("#cdgo_buscar").val($(this).attr("regCdgo"));
        $("#item_desc").val($(this).attr("regNmbr"));
        $("#item_unidad").val($(this).attr("regUn"));
        $("#item_precio").val($(this).attr("regPc"));
        $("#busqueda").dialog("close");
    });
</script>
