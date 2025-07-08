
<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 20%">Grupo</th>
        <th style="width: 65%">Descripción</th>
        <th style="width: 14%">Seleccionar</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 430px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:if test="${subpresupuestos}">
            <g:each in="${subpresupuestos}" var="subpresupuesto" status="i">
                <tr>
                    <td style="width: 20%">${subpresupuesto?.grupo?.descripcion}</td>
                    <td style="width: 65%">${subpresupuesto?.descripcion}</td>
                    <td style="width: 14%">
                        <div style="text-align: center" class="seleccionaSubpre" data-id="${subpresupuesto?.id}" data-nombre="${subpresupuesto?.descripcion}" data-grupo="${subpresupuesto?.grupo?.descripcion}">
                            <button class="btn btn-xs btn-success"><i class="fa fa-check"></i></button>
                        </div>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr>
                <td colspan="4" class="alert alert-info" style="text-align: center">
                    <i class="fa fa-exclamation-triangle fa-2x"></i> No existen registros
                </td>
            </tr>
        </g:else>
    </table>
</div>

<script type="text/javascript">
    $(".seleccionaSubpre").click(function () {

        var id = $(this).data("id");
        var descripcion = $(this).data("nombre");
        var grupo = $(this).data("grupo");

        <g:if test="${tipo == '1'}">
        $("#subpresupuestoBusqueda").val(id);
        cerrarBuscardorSubpre2();
        </g:if>
        <g:else>
        $("#sub").val(id);
        cerrarBuscardorSubpre();
        </g:else>
        $("#subPresupuestoName").val(grupo + " - " + descripcion);

    });
</script>