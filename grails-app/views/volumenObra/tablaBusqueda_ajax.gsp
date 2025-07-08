<style>

table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}

</style>

<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 15%">Código</th>
            <th style="width: 63%">Descripción</th>
            <th style="width: 10%">Unidad</th>
            <th style="width: 11%">Seleccionar</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover">
        <tbody>
        <g:if test="${data}">
            <g:each in="${data}" var="dt" status="i">
                <tr>
                    <td style="width: 15%">${dt.itemcdgo}</td>
                    <td style="width: 63%">${dt.itemnmbr}</td>
                    <td style="width: 11%; text-align: center">${dt.unddcdgo}</td>
                    <td style="width: 10%; text-align: center">
                        <g:if test="${obra.estado!='R' && duenoObra == 1}">
                            <a href="#" class="btn btn-success btn-xs btnSeleccionar" data-id="${dt?.item__id}"><i class="fa fa-check"></i></a>
                        </g:if>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-info" style="text-align: center">
                <i class="fa fa-exclamation-triangle text-info fa-2x"></i> <strong style="font-size: 14px"> No se encontraron registros </strong>
            </div>
        </g:else>

        </tbody>
    </table>
</div>

<script type="text/javascript">

    function editarFormVolObra(id, rubro) {
        // var subpresupuesto = $("#subpresupuestoBusqueda option:selected").val();
        var subpresupuesto = $("#subpresupuestoBusqueda").val();
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'volumenObra', action:'formRubroVolObra_ajax')}",
            data    : {
                id: id,
                rubro: rubro,
                subpresupuesto: subpresupuesto,
                obra: '${obra?.id}',
                tipo: 1
            },
            success : function (msg) {
                var er = bootbox.dialog({
                    id      : "dlgCreateEditRubroVO",
                    title   : "Agregar rubro",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormRubroVolObra();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormRubroVolObra() {
        var $form = $("#frmRubroVolObra");
        if ($form.valid()) {
            var data = $form.serialize();
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        var idCombo = parts[2];
                        cargarTablaBusqueda();
                        cargarSubpresuspuestosObra(idCombo);
                        setTimeout(function () {
                            cargarTablaSeleccionados();
                        }, 800);
                    }else{
                        if(parts[0] === 'err'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            log(parts[1], "error");
                            return false;
                        }
                    }
                }
            });
        } else {
            return false;
        }
    }

    function verificarEstadoVO(rubro){
        var valor = false;
        // var subpresupuesto = $("#subpresupuestoBusqueda option:selected").val();
        var subpresupuesto = $("#subpresupuestoBusqueda").val();
        $.ajax({
            type    : "POST",
            async : false,
            url: "${createLink(controller: 'volumenObra', action:'verificarEstado_ajax')}",
            data    : {
                rubro: rubro,
                subpresupuesto: subpresupuesto,
                obra: '${obra?.id}'
            },
            success : function (msg) {
                if(msg === 'si'){
                    valor = true
                }else{
                    valor = false
                }
            } //success
        }); //ajax

        return valor
    }

    function formVolObraExistente(rubro) {
        // var subpresupuesto = $("#subpresupuestoBusqueda option:selected").val();
        var subpresupuesto = $("#subpresupuestoBusqueda").val();
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'volumenObra', action:'formVolObraExistente_ajax')}",
            data    : {
                rubro: rubro,
                subpresupuesto: subpresupuesto,
                obra: '${obra?.id}'
            },
            success : function (msg) {
                var er = bootbox.dialog({
                    id      : "dlgCreateEditVOExistente",
                    title   : "Modificar cantidad",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormRubroVolObra();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    $(".btnSeleccionar").click(function () {
        var rubro = $(this).data("id");
        var existe = verificarEstadoVO(rubro);
        var subpresupuesto = $("#subpresupuestoBusqueda").val();

        if(subpresupuesto){

            if(existe){
                formVolObraExistente(rubro)
            }else{
                editarFormVolObra(null, rubro);
            }
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-info fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione un subpresupuesto" +'</strong>');
        }

    });

</script>