<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/09/21
  Time: 12:52
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/21
  Time: 13:33
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>

    <th>Código</th>
    <th>Descripción</th>
    <th>Seleccionar</th>
    </thead>

    <tbody>

    <g:each in="${data}" var="dt" status="i">
        <tr>
            <td style="width: 15%">${dt.obracdgo}</td>
            <td style="width: 77%">${dt.obranmbr}</td>
            <td style="width: 8%"><div style="text-align: center" class="seleccionaObraDiferencia" id="reg_${i}"
                                       regId="${dt?.obra__id}" regNmbr="${dt?.obranmbr}" regCdgo="${dt?.obracdgo}">
                <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
            </div></td>

        </tr>
    </g:each>
    </tbody>

</table>

<script type="text/javascript">
    $(".seleccionaObraDiferencia").click(function () {
        var obra = $(this).attr("regId");
        location.href="${createLink(controller: 'reportesInventario', action: 'reporteDiferencia')}?obra=" + obra;
        $("#buscarObraDiferencia").dialog("close");
    });
</script>

