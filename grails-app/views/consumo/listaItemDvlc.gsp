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

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${data}" var="dt" status="i">
            <tr>
                <td style="width: 10%">${dt.itemcdgo}</td>
                <td style="width: 55%">${dt.itemnmbr}</td>
                <td style="width: 15%">
                    <g:formatNumber number="${dt.dtcscntd}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                </td>
                <td style="width: 12%">${dt.dtcspcun}</td>
                <td style="width: 8%"><div style="text-align: center" class="seleccionaDevolucion" id="reg_${i}"
                                           regId="${dt?.comp__id}" regNmbr="${dt?.itemnmbr}" regCdgo="${dt?.itemcdgo}"
                                           regUn="${dt?.unddcdgo}" regPc="${dt?.dtcspcun}" data-id="${dt?.item__id}" data-cant="${dt?.dtcscntd}">
                    <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                </div></td>
            </tr>
        </g:each>
    </table>
</div>


<script type="text/javascript">
    $(".seleccionaDevolucion").click(function () {
        var id = $(this).attr("regId");
        var c = $(this).data("cant")
        %{--location.href = "${g.createLink(action: 'consumo', controller: 'consumo')}" + "?id=" + id--}%
        $("#item_id").val($(this).attr("regId"));
        $("#item_id_original").val($(this).data("id"));
        $("#cdgo_buscar").val($(this).attr("regCdgo"));
        $("#item_desc").val($(this).attr("regNmbr"));
        $("#item_unidad").val($(this).attr("regUn"));
        $("#item_precio").val($(this).attr("regPc"));
        $("#item_cantidad").val(c);
        $("#item_cantidad_hide").val(c)
        $("#busqueda").dialog("close");
    });
</script>

