<div id="imprimirTransporteDialog">
    <fieldset>
        <div class="span5" style="margin-top: 10px">
            <label>Texto de cabecera para la impresión</label>
            <g:textField name="textoCabeceraImpresion" id="textoCabeceraImpresion" class="span5 allCaps" value="${rubro?.tituloImpresion}"/>

            <a href="#" id="btnGuardarTitulo" class="btn btn-primary">
                <i class="icon-save"></i> Guardar
            </a>
        </div>

        <div class="span4" style="margin-top: 10px">
            <label>Logo para impresión</label>

            <fieldset>
                <g:uploadForm action="subirLogo" method="post" name="frmUploadLogo" enctype="multipart/form-data">
                    <g:hiddenField name="rubro" value="${rubro?.id}"/>
                    <div class="fieldcontain required">
                        <b>Cargar archivo:</b>
                        <input type="file" id="file" name="file" class="" multiple accept=".jpg, .jpeg, .gif, .png"/>
                        <a href="#" id="btnSubmitLogo" class="btn btn-primary">
                            <i class="icon-save"></i> Subir logo
                        </a>
                        <div class="btn-group">
                            <g:if test="${rubro?.logo}">
                                <g:link action="descargarLogo_ajax" id="${rubro.id}" class="btn btn-info">
                                    <i class="icon-download-alt"></i> Descargar
                                </g:link>
                            </g:if>
                        </div>
                    </div>
                </g:uploadForm>
                <g:if test="${!rubro?.logo}">
                    <p style="color: #800">No se ha cargado ningún logo para este rubro</p>
                </g:if>
                <g:else>
                    <label class="text-success">Archivo Actual:  ${rubro?.logo}</label>

                                    <img alt="" src="${request.contextPath}/rubro/getLogo?id=${rubro?.id}" style="width: 100%; height: auto"/>

                </g:else>
            </fieldset>
        </div>

        <div class="span4" style="margin-top: 10px">
            <label>Se imprime a la Fecha de:</label>
            <elm:datepicker name="fechaSalida" class="span8" id="fechaSalidaId" value="${rubro?.fechaModificacion}"
                            style="width: 100px"/>
        </div>

        <div class="span4" style="margin-top: 10px;">
            <strong>¿Desea imprimir el reporte desglosando el transporte?</strong>
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#btnGuardarTitulo").click(function () {
        var titulo = $("#textoCabeceraImpresion").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'rubro', action:'guardarTitulo_ajax')}",
            data: {
                id: '${rubro?.id}',
                titulo: titulo
            },
            success: function (msg) {
                var parts = msg.split("_");
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');

            }
        });
    });

    $("#btnSubmitLogo").click(function () {
        submitImagen();
    });

    function submitImagen() {
        var $form = $("#frmUploadLogo");
        var formData = new FormData($form[0]);
        $.ajax({
            type    : "POST",
            url     : $form.attr("action"),
            data    : formData,
            contentType: false,
            processData: false,
            success : function (msg) {
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    cerrarImprimirRubro();
                    // location.reload();

                    setTimeout(function () {
                        dialogoImprimirRubro();
                    },500)
                }else{
                    cerrarImprimirRubro();
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                    return false;
                }
            }
        });
    }


</script>