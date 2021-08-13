<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/08/21
  Time: 10:54
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 35%">Bodega Sale</th>
        <th style="width: 35%">Bodega Recibe</th>
        <th style="width: 22%">Fecha</th>
        <th style="width: 8%">Seleccionar</th>
    </tr>
    </thead>

    <tbody>
    </tbody>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${transferencias}" var="transferencia">
            <tr>
                <td style="width: 35%">${transferencia?.sale?.descripcion}</td>
                <td style="width: 35%">${transferencia?.recibe?.descripcion}</td>
                <td style="width: 22%">${transferencia?.fecha?.format('dd-MM-yyyy')}</td>
                <td style="width: 8%">
                    <div style="text-align: center" class="selecciona" id="reg_${transferencia?.id}" data-id="${transferencia?.id}">
                        <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
                    </div></td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(".selecciona").click(function () {
        var ad = $(this).data("id");
        location.href = "${g.createLink(controller: 'transferencia', action: 'transferencia')}/" + ad
    });
</script>

