<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/09/21
  Time: 11:32
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 10%">Código</th>
        <th style="width: 72%">Descripción</th>
        <th style="width: 8%">Unidad</th>
        <th style="width: 8%">Seleccionar</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${data}" var="dt" status="i">
            <tr>
                <td style="width: 9%">${dt.itemcdgo}</td>
                <td style="width: 71%">${dt.itemnmbr}</td>
                <td style="width: 8%">
                    ${dt.unddcdgo}
                </td>
                <td style="width: 8%">
                    <div style="text-align: center" class="selecciona" id="reg_${i}"
                                           regNmbr="${dt?.itemnmbr}" regCdgo="${dt?.itemcdgo}"
                                           regUn="${dt?.unddcdgo}" data-id="${dt?.item__id}" data-tpl="${dt?.tpls__id}">
                    <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                </div></td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(".selecciona").click(function () {
        $("#item_id").val($(this).data("id"));
        $("#cdgo_buscar").val($(this).attr("regCdgo"));
        $("#item_desc").val($(this).attr("regNmbr"));
        $("#item_tipoLista").val($(this).data("tpl"));
        $("#item_unidad").val($(this).attr("regUn"));
        $("#busqueda").dialog("close");
    });
</script>