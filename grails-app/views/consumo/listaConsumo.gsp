<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th>Obra</th>
        <th>Fecha</th>
        <th>Bodega</th>
        <th>Recibe</th>
        <th>Estado</th>
        <th>Seleccionar</th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${data}">
        <g:each in="${data}" var="dt" status="i">
            <tr>
                <td style="width: 44%">${dt.obranmbr}</td>
                <td style="width: 10%">${dt.cnsmfcha.format('dd-MM-yyyy')}</td>
                <td style="width: 13%">${dt.bdganmbr}</td>
                <td style="width: 12%">${dt.recibe}</td>
                <td style="width: 13%">${dt.cnsmetdo == 'N' ? 'En proceso (N) ' : (dt.cnsmetdo == 'P' ? 'Aprobado (P)' : (dt.cnsmetdo == 'R' ? 'Entregado (R)' : 'Anulado (A)' ) )}</td>
                <td style="width: 8%"><div style="text-align: center"
                                           class="selecciona" id="reg_${i}" regId="${dt?.cnsm__id}">
                    <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                </div></td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="5" style="text-align: center; font-size: 14px"><i class="fa fa-exclamation-triangle text-info fa-2x"></i> No existen registros</td>
        </tr>
    </g:else>

    </tbody>

</table>

<script type="text/javascript">
    $(".selecciona").click(function () {
        var cnsm = $(this).attr("regId");
        location.href = "${g.createLink(action: 'consumo', controller: 'consumo')}" + "?id=" + cnsm
    });
</script>

