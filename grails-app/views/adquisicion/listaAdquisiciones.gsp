<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/08/21
  Time: 10:36
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th>Proveedor</th>
        <th>Bodega</th>
        <th>Fecha</th>
        <th>Fecha Pago</th>
        <th>Seleccionar</th>
    </tr>
    </thead>

    <tbody>
    </tbody>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${adquisiciones}" var="adquisicion">
            <tr>
                <td style="width: 55%">${adquisicion?.proveedor?.ruc + " - " + adquisicion?.proveedor?.nombre}</td>
                <td style="width: 15%">${adquisicion?.bodega?.nombre}</td>
                <td style="width: 12%">${adquisicion?.fecha?.format('dd-MM-yyyy')}</td>
                <td style="width: 12%">${adquisicion?.fechaPago?.format('dd-MM-yyyy')}</td>
                <td style="width: 8%">
                    <div style="text-align: center" class="selecciona" id="reg_${adquisicion?.id}" data-id="${adquisicion?.id}">
                        <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                    </div></td>
            </tr>
        </g:each>
    </table>
</div>





<script type="text/javascript">
    $(".selecciona").click(function () {
        var ad = $(this).data("id");
        location.href = "${g.createLink(controller: 'adquisicion', action: 'adquisicion')}/" + ad
    });
</script>

