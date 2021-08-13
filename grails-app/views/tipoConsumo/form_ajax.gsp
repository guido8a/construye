

%{--<div id="create-tipoConsumo" class="span" role="main">--}%
<g:form class="form-horizontal" name="frmTipoConsumo" action="save_ajax">
    <g:hiddenField name="id" value="${tipoConsumoInstance?.id}"/>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Código
            </span>
        </div>

        <g:if test="${tipoConsumoInstance?.id}">
            <div class="controls">
                <g:textField name="codigo" maxlength="1" style="width: 20px" class=" required" value="${tipoConsumoInstance?.codigo}" readonly="readonly"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </g:if>
        <g:else>
            <div class="controls">
                <g:textField name="codigo" maxlength="1" style="width: 20px" class=" required allCaps" value="${tipoConsumoInstance?.codigo}" />
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </g:else>

    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Descripción
            </span>
        </div>

        <div class="controls">
            <g:textField name="descripcion" maxlength="20" style="width: 200px" class=" required" value="${tipoConsumoInstance?.descripcion}"/>
            <span class="mandatory">*</span>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

</g:form>

<script type="text/javascript">
    var url = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");

    $("#frmTipoConsumo").validate({
        errorPlacement : function (error, element) {
            element.parent().find(".help-block").html(error).show();
        },
        success        : function (label) {
            label.parent().hide();
        },
        errorClass     : "label label-important",
        submitHandler  : function(form) {
            $("[name=btnSave-tipoConsumo]").replaceWith(spinner);
            form.submit();
        }
    });
</script>
