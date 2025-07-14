<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <thead>
    <tr>
        <th class="alinear" style="width: 10%">Tipo</th>
        <th class="alinear" style="width: 17%">Cantidad</th>
        <th class="alinear" style="width: 15%">P. Unitario</th>
        <th class="alinear" style="width: 17%">Existencias</th>
        <th class="alinear" style="width: 20%">P.U. Existencias</th>
        <th class="alinear" style="width: 20%">Fecha de la transacción</th>
        <th class="alinear" style="width: 1%"></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<div class="" style="width: 99.7%;height: 250px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <g:if test="${kardexs.size() > 0}">
            <g:each in="${kardexs}" var="kardex" status="i">
                <tr>
                    <td style="width: 10%">${kardex?.tipo == 'I' ? 'INGRESO' : 'EGRESO'}</td>
                    <td style="width: 17%; text-align: center">
                        <g:formatNumber number="${kardex?.cantidad}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                    </td>
                    <td style="width: 15%; text-align: center">
                        <g:formatNumber number="${kardex?.precioUnitario}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                    </td>
                    <td style="width: 17%; text-align: center">
                        <g:formatNumber number="${kardex?.existencias}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                    </td>
                    <td style="width: 20%; text-align: center">
                        <g:formatNumber number="${kardex?.precioCosto}" format="##,#####0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                    </td>
                    <td style="width: 19%">${kardex?.fecha?.format('dd-MMM-yyyy HH:mm')}</td>
                    <td style="width: 1%; text-align: center">
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr>
                <td colspan="8" style="text-align: center; font-size: 16px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</td>
            </tr>
        </g:else>
    </table>
</div>