<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Código</th>
            <th style="width: 66%">Descripción</th>
            <th style="width: 10%">Unidad</th>
            <th style="width: 13%">Seleccionar</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover">
        <tbody>
        <g:if test="${data}">
            <g:each in="${data}" var="dt" status="i">
                <tr>
                    <td style="width: 10%">${dt.itemcdgo}</td>
                    <td style="width: 66%">${dt.itemnmbr}</td>
                    <td style="width: 10%">
                        ${dt.unddcdgo}
                    </td>
                    <td style="width: 13%; text-align: center">
                        <a href="#" class="btn btn-success btn-xs btnSeleccionarRubroEditar" data-id="${dt?.item__id}"   data-nombre="${dt?.itemcdgo + " - " + dt.itemnmbr}"  data-codigo="${dt?.itemcdgo}"><i class="fa fa-check"></i></a>
                    </td>
                    <td style="width: 1%">

                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-info" style="text-align: center">
                <i class="fa fa-exclamation-triangle text-info fa-2x"></i> <strong style="font-size: 14px"> No se encontraron registros </strong>
            </div>
        </g:else>

        </tbody>
    </table>
</div>

<script type="text/javascript">


    $(".btnSeleccionarRubroEditar").click(function () {
        var rubro = $(this).data("id");
        var nombre = $(this).data("nombre");
        var codigo = $(this).data("codigo");

        $("#itemName").val(nombre);
        $("#item").val(rubro);
        $("#cod").val(codigo);

        cerrarBuscardorRubros();

    });

</script>