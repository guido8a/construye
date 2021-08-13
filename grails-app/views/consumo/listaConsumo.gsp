<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>

    <th>Obra</th>
    <th>Fecha</th>
    <th>Bodega</th>
    <th>Recibe</th>
    <th>Seleccionar</th>
    </thead>

    <tbody>

    <g:each in="${data}" var="dt" status="i">
        <tr>
            <td style="width: 55%">${dt.obranmbr}</td>
            <td style="width: 10%">${dt.cnsmfcha.format('dd-MM-yyyy')}</td>
            <td style="width: 15%">${dt.bdganmbr}</td>
            <td style="width: 12%">${dt.recibe}</td>
            <td style="width: 8%"><div style="text-align: center"
                                       class="selecciona" id="reg_${i}" regId="${dt?.cnsm__id}">
                <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
            </div></td>

        </tr>

    </g:each>
    </tbody>

</table>

<script type="text/javascript">
    $(".selecciona").click(function () {
        var cnsm = $(this).attr("regId");
        location.href = "${g.createLink(action: 'consumo', controller: 'consumo')}" + "?id=" + cnsm
    });
</script>

