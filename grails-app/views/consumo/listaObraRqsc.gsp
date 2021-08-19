<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>

    <th>Código</th>
    <th>Descripción</th>
    <th>Seleccionar</th>
    </thead>

    <tbody>

    <g:each in="${data}" var="dt" status="i">
        <tr>
            <td style="width: 10%">${dt.obracdgo}</td>
            <td style="width: 82%">${dt.obranmbr}</td>
            <td style="width: 8%"><div style="text-align: center" class="seleccionaObraRQ" id="reg_${i}"
                                       regId="${dt?.obra__id}" regNmbr="${dt?.obranmbr}" regCdgo="${dt?.obracdgo}">
                <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
            </div></td>

        </tr>

    </g:each>
    </tbody>

</table>

<script type="text/javascript">

    $(".seleccionaObraRQ").click(function () {
        $("#obra__id").val($(this).attr("regId"));
        $("#input_codigo").val($(this).attr("regCdgo"));
        $("#obradscr").val($(this).attr("regNmbr"));
        $("#buscarObra").dialog("close");

        cargarRequisiciones($(this).attr("regId"));
    });

</script>

