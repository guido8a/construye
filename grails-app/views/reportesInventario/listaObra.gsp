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
            <td style="width: 8%"><div style="text-align: center" class="seleccionaObra" id="reg_${i}"
                                       regId="${dt?.obra__id}" regNmbr="${dt?.obranmbr}" regCdgo="${dt?.obracdgo}">
                <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
            </div></td>

        </tr>
    </g:each>
    </tbody>

</table>

<script type="text/javascript">
    $(".seleccionaObra").click(function () {
        var obra = $(this).attr("regId");

        switch ('${tipo}') {
            case '1':
                location.href="${createLink(controller: 'reportesInventario', action: 'reporteCostoActual')}?obra=" + obra;
            break;
            case "2":
                break;
            case "3":
                location.href="${createLink(controller: 'reportesInventario', action: 'reporteDiferencia')}?obra=" + obra;
                break;
        }

        $("#buscarObra").dialog("close");
    });
</script>

