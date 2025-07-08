<g:form class="form-horizontal" name="frmRubroVolObra" role="form" controller="volumenObra" action="addItem" method="POST">

    <div class="alert alert-info">
        <i class="fa fa-exclamation-triangle text-warning fa-3x"></i><strong style="font-size: 14px"> El rubro seleccionado ya se encuentra en el subpresupuesto, desea modificar la cantidad? </strong>
    </div>

    <g:hiddenField name="id" value="${null}" />
    <g:hiddenField name="obra" value="${obra?.id}" />
    <g:hiddenField name="sub" value="${subpresupuesto?.id}" />
    <g:hiddenField name="item" value="${rubro?.id}" />
    <g:hiddenField name="cod" value="${rubro?.codigo}" />

    <div class="form-group">
        <span class="grupo">
            <label for="itemName" class="col-md-1 control-label text-info">
                Rubro
            </label>
            <span class="col-md-11">
                <g:textArea name="itemName" readonly="" class="form-control" value="${(rubro?.codigo + " - "  + rubro?.nombre) ?: ''}" style="resize: none"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: volumenObra, field: 'cantidad', 'error')} required">
        <span class="grupo">
            <label for="cantidad" class="col-md-1 control-label text-info">
                Cantidad
            </label>
            <span class="col-md-3">
                <g:textField name="cantidad" required="" class="form-control required" value="${volumenObra?.cantidad ?: 1}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#cantidad").keydown(function (ev) {
        return validarNum(ev);
    });

    $("#frmRubro").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

</script>