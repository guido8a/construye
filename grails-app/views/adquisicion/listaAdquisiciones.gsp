<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/08/21
  Time: 10:36
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 5%">Núm.</th>
        <th style="width: 25%">Proveedor</th>
        <th style="width: 15%">Bodega</th>
        <th style="width: 25%">Detalle</th>
        <th style="width: 10%">Fecha</th>
        <th style="width: 10%">Fecha Pago</th>
        <th style="width: 4%">Reg.</th>
        <th style="width: 6%">Sel.</th>
    </tr>
    </thead>

    <tbody>
    </tbody>
</table>

<div class="" style="width: 99.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${data}" var="adqc">
            <tr>
                <td style="width: 5%">${adqc?.adqc__id}</td>
                <td style="width: 25%">${adqc?.prvenmbr}</td>
                <td style="width: 15%">${adqc?.bdganmbr}</td>
                <td style="width: 25%">${adqc?.adqcobsr}</td>
                <td style="width: 10%">${adqc?.adqcfcha?.format('dd-MM-yyyy')}</td>
                <td style="width: 10%">${adqc?.adqcfcpg?.format('dd-MM-yyyy')}</td>
                <td style="width: 4%">${adqc?.adqcetdo}</td>
                <td style="width: 6%">
                    <div style="text-align: center" class="selecciona" id="reg_${adqc?.adqc__id}" data-id="${adqc?.adqc__id}">
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

