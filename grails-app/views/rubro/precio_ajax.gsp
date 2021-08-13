<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 15/05/20
  Time: 10:52
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 17/11/16
  Time: 14:56
--%>
<%@ page import="janus.Item; janus.PrecioRubrosItems" %>

<div id="create-precioRubrosItemsInstance" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave" controller="mantenimientoItems" action="savePrecio_ajax">
        <g:hiddenField name="id" value="${precioRubrosItemsInstance?.id}"/>
        <g:hiddenField id="item" name="item.id" value="${precioRubrosItemsInstance?.item?.id}"/>
        <g:hiddenField name="ignore" value="${true}"/>

        <div class="tituloTree">
            Item:  ${precioRubrosItemsInstance.item.nombre} <br>
        </div>

        <div class="control-group">
            <span class="control-label label label-inverse">
                Lista
            </span>

            <div class="controls">
%{--                <elm:select name="lugar.id" from="${janus.Lugar.list() - janus.Lugar.findByCodigo(100)}" optionValue="descripcion" optionKey="id"--}%
%{--                            optionClass="${{ it?.id }}" id="lugar"/>--}%
                <g:select name="lugar.id" from="${janus.Lugar.findAllByTipoLista(janus.Item.get(item?.id).tipoLista)}" optionKey="id" optionValue="descripcion"/>
            </div>
        </div>
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Fecha
                </span>
            </div>

            <div class="controls">
                <elm:datepicker name="fecha" id="fechaPrecio" class="datepicker required" style="width: 100px"
                                yearRange="${(new Date().format('yyyy').toInteger() - 40).toString() + ':' + new Date().format('yyyy')}"
                                maxDate="${(new Date().format('MM').toInteger() + 60).toString()}" value="${new Date()}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Precio Unitario
                </span>
            </div>

            <div class="controls">
                <div class="input-append">

                    <g:textField type="text" name="precioUnitario" class="inputVar num"
                                 value="${g.formatNumber(number: precioRubrosItemsInstance?.precioUnitario, maxFractionDigits: 5, minFractionDigits: 5, format: '##,##0', locale: 'ec')}"
                                 title="Precio"/>
                    <span class="add-on" id="spanPeso">
                        $
                    </span>
                </div>
                Unidad: <span style="font-weight: bold"> ${precioRubrosItemsInstance.item.unidad.codigo} </span>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

    </g:form>
</div>

<script type="text/javascript">

    $(function () {

        %{--$("#frmSave").validate({--}%
        %{--rules          : {--}%
        %{--fecha : {--}%
        %{--remote : {--}%
        %{--url  : "${createLink(controller: 'mantenimientoItems', action:'checkFcPr_ajax')}",--}%
        %{--type : "post",--}%
        %{--data : {--}%
        %{--item  : "${precioRubrosItemsInstance.itemId}",--}%
        %{--lugar : lug--}%

        %{--}--}%
        %{--}--}%
        %{--}--}%
        %{--},--}%
        %{--messages       : {--}%
        %{--fecha : {--}%
        %{--remote : "Ya existe un precio para esta fecha"--}%
        %{--}--}%
        %{--},--}%
        %{--errorPlacement : function (error, element) {--}%
        %{--element.parent().find(".help-block").html(error).show();--}%
        %{--},--}%
        %{--success        : function (label) {--}%
        %{--label.parent().hide();--}%
        %{--},--}%
        %{--errorClass     : "label label-important"--}%
        %{--});--}%

    });



</script>
