

<g:form class="form-horizontal" name="frmBodega" action="save_ajax">
    <g:hiddenField name="id" value="${bodegaInstance?.id}"/>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Empresa
            </span>
        </div>

        <div class="controls">
            <g:hiddenField name="empresa" value="${empresa?.id}"/>
            <g:textArea name="empresa_name" style="width: 300px; resize: none" class="required" readonly="" value="${empresa?.nombre}" />
            <span class="mandatory">*</span>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Nombre
            </span>
        </div>

        <div class="controls">
            <g:textField name="nombre" maxlength="63" style="width: 300px" class=" required" value="${bodegaInstance?.nombre}"/>
            <span class="mandatory">*</span>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Descripción
            </span>
        </div>

        <div class="controls">
            <g:textArea name="descripcion" maxlength="127" style="width: 300px; resize: none" class="" value="${bodegaInstance?.descripcion}"/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Dirección
            </span>
        </div>

        <div class="controls">
            <g:textArea name="direccion" maxlength="255" style="width: 300px; resize: none" class="" value="${bodegaInstance?.direccion}"/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Teléfono
            </span>
        </div>

        <div class="controls">
            <g:textField name="telefono" maxlength="127" style="width: 300px" class="" value="${bodegaInstance?.telefono}"/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Tipo
            </span>
        </div>

        <div class="controls">
            <g:select from="${['O': 'O', 'T' : 'T']}" name="tipo" optionKey="key" optionValue="value" style="width: 50px" class="" value="${bodegaInstance?.tipo}"/>
            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

</g:form>

<script type="text/javascript">
    var url = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");

    $("#frmBodega").validate({
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
