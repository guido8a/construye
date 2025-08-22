<div class="row">
    <div class="col-md-12">

        <div class="alert alert-success" style="font-size: 14px; font-weight: bold">
            <i class="fa fa-list fa-2x"></i> Este rubro ya forma parte de la(s) siguientes obra(s)
        </div>

        <g:if test="${tipo == '1'}">
            <div class="alert alert-info" style="font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x"></i> Si desea eliminar el item, necesita crear el historico del rubro
            </div>
        </g:if>

        <g:if test="${tipo == '3'}">
            <div class="alert alert-success" style="font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x text-warning"></i> Desea crear una nueva versión de este rubro, y hacer una versión histórica?
            </div>
        </g:if>

        <div role="main" style="margin-top: 10px;">
            <table class="table table-bordered table-striped table-condensed table-hover">
                <thead>
                <tr>
                    <th style="width: 25%">Código</th>
                    <th style="width: 75%">Nombre</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
            <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
                <tbody>
                <g:each in="${volumenes}" status="i" var="volumen">
                    <tr>
                        <td style="width: 25%">${volumen?.obra?.codigo}</td>
                        <td style="width: 75%">${volumen?.obra?.nombre}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>

