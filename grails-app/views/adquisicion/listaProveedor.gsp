<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/08/21
  Time: 13:20
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 11%">RUC</th>
        <th style="width: 80%">Nombre</th>
        <th style="width: 9%">Seleccionar</th>
    </tr>
    </thead>
    <tbody> </tbody>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${proveedores}" var="proveedor" status="i">
            <tr>
                <td style="width: 10%">${proveedor.ruc}</td>
                <td style="width: 82%">${proveedor.nombre}</td>
                <td style="width: 8%"><div style="text-align: center" class="selecciona" data-id="${proveedor?.id}" data-nombre="${proveedor?.nombre}" data-ruc="${proveedor?.ruc}">
                    <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                </div></td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(".selecciona").click(function () {
        $("#proveedor_id").val($(this).data("id"));
        $("#proveedor_nombre").val($(this).data("ruc") + " - " + $(this).data("nombre"));
        $("#buscarObra").dialog("close");
    });
</script>