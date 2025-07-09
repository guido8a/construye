<g:form class="form-horizontal" name="frmRubroVolObra" role="form" controller="volumenObra" action="addItemNuevo" method="POST">
    <g:hiddenField name="id" value="${volumenObra?.id}" />
    <g:hiddenField name="obra" value="${obra?.id}" />

    <g:if test="${tipo == '1'}">
        <g:hiddenField name="sub" value="${subpresupuesto?.id}" />
    </g:if>
    <g:else>
        <span class="row-fluid form-group ${hasErrors(bean: volumenObra, field: 'subPresupuesto', 'error')} required">
            <span class="grupo">
                <label for="subPresupuestoName" class="span3 control-label text-info">
                    Subpresupuesto
                </label>
                <span class="span7">
                    <g:hiddenField name="sub" value="${subpresupuesto?.id}" />
                    <g:textField name="subPresupuestoName" required="" readonly="" class="span12 form-control required" value="${ volumenObra?.subPresupuesto?.grupo?.descripcion ? (volumenObra?.subPresupuesto?.grupo?.descripcion + " - " +  volumenObra?.subPresupuesto?.descripcion) : ''}"/>
                </span>
                <span class="span2">
                    <a href="#" class="btn btn-info" id="btnBuscarSubPresupuestoForm" title="Buscar subpresupuesto">
                      Buscar
                    </a>
                </span>
            </span>
        </span>
    </g:else>

    <g:if test="${tipo == '1'}">
        <g:hiddenField name="item" value="${rubro?.id}" />
        <g:hiddenField name="cod" value="${rubro?.codigo}" />

        <span class="form-group row-fluid">
            <span class="grupo">
                <label for="subPresupuestoName" class="span3 control-label text-info">
                    Subpresupuesto
                </label>
                <span class="span8">
                    <g:textField name="subPresupuestoName" required="" readonly="" class="span12 form-control" value="${ (subpresupuesto?.grupo?.descripcion + " - " +  subpresupuesto?.descripcion) ?: ''}"/>
                </span>
            </span>
        </span>

        <div class="form-group row-fluid" style="margin-bottom: 5px">
            <span class="grupo">
                <label for="itemName" class="span3 control-label text-info">
                    Rubro
                </label>
                <span class="span8">
                    <g:textArea name="itemName" readonly="" class="span12 form-control" value="${(rubro?.codigo + " - "  + rubro?.nombre) ?: ''}" style="resize: none; height: 90px"/>
                </span>
            </span>
        </div>
    </g:if>
    <g:else>
        <div class="row-fluid form-group ${hasErrors(bean: volumenObra, field: 'rubro', 'error')} required" style="margin-bottom: 5px">
            <span class="grupo">
                <label for="itemName" class="span3 control-label text-info">
                    Rubro
                </label>
                <span class="span7">
                    <g:hiddenField name="item" value="${rubro?.id}" />
                    <g:hiddenField name="cod" value="${rubro?.codigo}" />
                    <g:textArea name="itemName" required="" readonly="" style="resize: none; height: 90px" class="span12 form-control required" value="${ (volumenObra?.item?.codigo + " "  + volumenObra?.item?.nombre) ?: ''}"/>
                </span>
                <span class="span1">
                    <a href="#" class="btn btn-info" id="btnBuscarRubroEditar" title="Buscar rubro">
                        Buscar
                    </a>
                </span>
            </span>
        </div>
    </g:else>

    <div class="form-group row-fluid">
        <span class="grupo">
            <label for="unidadName" class="span3 control-label text-info">
                Unidad
            </label>
            <span class="span3">
                <g:textField name="unidadName" readonly="" class="span12 form-control" value="${volumenObra?.item?.unidad?.codigo ?: rubro?.unidad?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="row-fluid form-group ${hasErrors(bean: volumenObra, field: 'cantidad', 'error')} required">
        <span class="grupo">
            <label for="cantidad" class="span3 control-label text-info">
                Cantidad
            </label>
            <span class="span3">
                <g:textField name="cantidad" required="" class="span12 form-control required" value="${volumenObra?.cantidad ?: 1}"/>
            </span>
        </span>
    </div>

    <div class="row-fluid form-group ${hasErrors(bean: volumenObra, field: 'orden', 'error')} required">
        <span class="grupo">
            <label for="orden" class="span3 control-label text-info">
                Orden
            </label>
            <span class="span3">
                <g:textField name="orden" required="" class="span12 form-control required" value="${volumenObra?.id ?  volumenObra?.orden  : ((max ?: 0) + 1)}"/>
            </span>
        </span>
    </div>

    <div class="row-fluid form-group ${hasErrors(bean: volumenObra, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="dscr" class="span3 control-label text-info">
                Descripción
            </label>
            <span class="span8">
                <g:textArea name="dscr" class="span12 form-control" value="${volumenObra?.descripcion}" style="resize: none" />
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    var bcsb, bcru;

    $("#btnBuscarSubPresupuestoForm").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'volumenObra', action:'buscarSubpresupuestoRubro_ajax')}",
            data    : {
            },
            success : function (msg) {
                bcsb = bootbox.dialog({
                    id      : "dlgBuscarSubForm",
                    title   : "Buscar subpresupuesto",
                    className: 'large',
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarBuscardorSubpre() {
        bcsb.modal("hide");
    }

    $("#btnBuscarRubroEditar").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'volumenObra', action:'buscarRubroEditar_ajax')}",
            data    : {
            },
            success : function (msg) {
                bcru = bootbox.dialog({
                    id      : "dlgBuscarRubro",
                    title   : "Buscar rubro",
                    className: 'large',
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarBuscardorRubros() {
        bcru.modal("hide");
    }

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

    function validarNumEntero(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#orden").keydown(function (ev) {
        return validarNumEntero(ev);
    });

    var validator = $("#frmRubroVolObra").validate({
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