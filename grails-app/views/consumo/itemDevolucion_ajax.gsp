<g:if test="${consumo?.estado == 'N'}">
    <g:if test="${consumo?.id}">
        <div style="border-bottom: 1px solid black;padding-left: 50px;margin-top: 10px;position: relative;">
            <p class="css-vertical-text">Items</p>

            <div class="linea" style="height: 100px;"></div>

            <div class="row-fluid" style="margin-bottom: 5px">

                <div class="span2">

                    <div style="display: inline-block">
                        Código
                    </div>
                    <input type="text" name="item.codigo" id="cdgo_buscar" class="span12" readonly="true">
                    <input type="hidden" id="item_id">
                    <input type="hidden" id="idItems">
                </div>

                <g:if test="${consumo?.estado == 'N'}">
                    <div class="span1" style="margin-top: 20px; width: 80px">
                        <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar Item" id="btnBuscarItem">
                            <i class="icon-search"></i> Buscar
                        </a>
                    </div>
                </g:if>

                <div class="span5">
                    Descripción
                    <input type="text" name="item.descripcion" id="item_desc" class="span11" disabled="disabled">
                </div>

                <div class="span1" style="margin-right: 0px;margin-left: -30px;">
                    Unidad
                    <input type="text" name="item.unidad" id="item_unidad" class="span8" disabled="true">
                </div>

                <div class="span1" style="margin-left: -5px !important;">
                    <g:hiddenField name="item_cantidad_hide" value="${0}"/>
                    Cantidad
                    <input type="text" name="item.cantidad" class="span12" id="item_cantidad" value="1" style="text-align: right">
                </div>

                <div class="span2">
                    P. Unitario
                    <input type="text" name="item.precio" class="span8" id="item_precio" value="1" disabled="true"  style="text-align: right; color: #44a;">
                </div>

                <g:if test="${consumo?.estado != 'R' || consumo?.estado != 'A'}">
                    <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 22px;margin-left: 10px">
                        <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar"
                           id="btn_agregarItem">
                            <i class="icon-plus"></i>
                        </a>
                        <a class="btn btn-small btn-primary btn-ajax hidden" href="#" rel="tooltip" title="Guardar"
                           id="btn_guardarItem">
                            <i class="icon-save"></i>
                        </a>
                        <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Cancelar edición"
                           id="btnCancelarEdicion">
                            <i class="icon-remove"></i>
                        </a>
                    </div>
                </g:if>
            </div>
        </div>

        <input type="hidden" id="actual_row">
    </g:if>
</g:if>

<script type="text/javascript">

    <g:if test="${consumo?.id}">
    $("#btnBuscarItem").click(function () {
        $("#busqueda").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    busqueda();
    </g:if>

    <g:if test="${consumo}">

    $("#btn_agregarItem, #btn_guardarItem").click(function () {
        var id = $("#item_id").val();
        if ($('#item_desc').val().length == 0) {
            $.box({
                imageClass: "box_info",
                text: "No hay item que agregar al APU",
                title: "Alerta",
                iconClose: false,
                dialog: {
                    resizable: false,
                    draggable: false,
                    buttons: {
                        "Aceptar": function () {
                        }
                    }
                }
            });
            return false
        }else{
            if($("#item_cantidad").val() == 0 || $("#item_cantidad").val() == null){
                $.box({
                    imageClass: "box_info",
                    text: "Ingrese la cantidad",
                    title: "Alerta",
                    iconClose: false,
                    dialog: {
                        resizable: false,
                        draggable: false,
                        buttons: {
                            "Aceptar": function () {
                            }
                        }
                    }
                });
            }else{
                guardarDetalleConsumo(id);
            }
        }
    });
    </g:if>
    <g:else>
    $("#btn_agregarItem, #btn_guardarItem").click(function () {
        $.box({
            imageClass: "box_info",
            text: "Primero guarde el consumo o seleccione uno para editar",
            title: "Alerta",
            iconClose: false,
            dialog: {
                resizable: false,
                draggable: false,
                buttons: {
                    "Aceptar": function () {
                    }
                },
                width: 500
            }
        });
    });
    </g:else>

    $("#btnCancelarEdicion").click(function () {
        $("#idItems").val("");
        $("#item_id").val("");
        $("#item_cantidad").val(1);
        $("#item_desc").val("").removeClass("readonly");
        $("#item_precio").val(1);
        $("#item_unidad").val("");
        $("#cdgo_buscar").val("");
        $("#btn_guardarItem").addClass("hidden");
        $("#btn_agregarItem").removeClass("hidden")
        // $("#btnCancelarEdicion").addClass("hidden")
    });


</script>