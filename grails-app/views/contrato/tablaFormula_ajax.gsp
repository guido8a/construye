<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/11/15
  Time: 03:16 PM
--%>

<script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
<link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">

 <div id="tabs" style="width: 700px; height: 700px; text-align: center">

        <ul>
            <li><a href="#tab-formulaPolinomica">Fórmula Polinómica</a></li>
            <li><a href="#tab-cuadrillaTipo">Cuadrilla Tipo</a></li>

        </ul>

        <div id="tab-formulaPolinomica" class="tab">

            <div class="formula">

                <fieldset class="borde">
                    <legend>Fórmula Polinómica</legend>

                    <table class="table table-bordered table-striped table-hover table-condensed" id="tablaPoliContrato">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%; text-align: center">Coeficiente</th>
                            <th style="width: 65%">Nombre del Indice (INEC)</th>
                            <th style="width: 15%">Valor</th>
                            <th style="width: 15%">Editar</th>
                        </tr>
                        </thead>
                        <tbody id="bodyPoliContrato">
                        <g:set var="tot" value="${0}"/>
                        <g:each in="${ps}" var="i">
                            <tr>
                                <td>${i?.numero}</td>
                                <td>${i?.indice?.descripcion}</td>
                                <g:if test="${i.indice.id == 143}">
                                    <td class="editable" data-tipo="p" data-id="${i.id}" id="${i.id}" data-original="${i.valor}" data-valor="${i.valor}" style="text-align: right; width: 40px">
                                        ${g.formatNumber(number: i?.valor, minFractionDigits: 3, maxFractionDigits: 3)}
                                    </td>
                                </g:if>
                                <g:else>
                                    <td data-tipo="p" data-valor="${i.valor}"style="text-align: right; width: 40px">
                                        ${g.formatNumber(number: i?.valor, minFractionDigits: 3, maxFractionDigits: 3)}
                                    </td>
                                </g:else>
                                <td style="text-align: center">
                                    <g:if test="${i.indice.id != 143}">
                                        <a href="#" data-id="${i.id}" class="btn btn-xs btn-success btnEditarIndice" title="Editar índice">
                                            <i class="icon-pencil"></i>
                                        </a>
                                    </g:if>
                                </td>
                                <g:set var="tot" value="${tot + i.valor}"/>
                            </tr>
                        </g:each>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th colspan="2">TOTAL</th>
                            <th class="total p" style="text-align: right; ">${g.formatNumber(number: tot, maxFractionDigits: 3, minFractionDigits: 3)}</th>
                            <th></th>
                        </tr>
                        </tfoot>
                    </table>
                </fieldset>
            </div>
        </div>

        <div id="tab-cuadrillaTipo" class="tab">
            <fieldset class="borde">
                <legend>Cuadrilla Tipo</legend>

                <table class="table table-bordered table-striped table-hover table-condensed" id="tablaCuadrilla">
                    <thead>
                    <tr style="width: 100%">
                        <th style="width: 10%; text-align: center">Coeficiente</th>
                        <th style="width: 65%">Nombre del Indice (INEC)</th>
                        <th style="width: 15%">Valor</th>
                        <th style="width: 15%">Editar</th>
                    </tr>
                    </thead>
                    <tbody id="bodyCuadrilla">
                    <g:set var="tot" value="${0}"/>
                    <g:each in="${cuadrilla}" var="i">
                        <tr>
                            <td>${i?.numero}</td>
                            <td>${i?.indice?.descripcion}</td>
                            <td data-tipo="c" data-id="${i.id}" id="${i.id}" data-original="${i.valor}" data-valor="${i.valor}" style="text-align: right; width: 40px">
                                ${g.formatNumber(number: i?.valor, minFractionDigits: 3, maxFractionDigits: 3)}
                            </td>
                            <td style="text-align: center">
                                    <a href="#" data-id="${i.id}" class="btn btn-xs btn-success btnEditarIndiceCuadrilla" title="Editar índice">
                                        <i class="icon-pencil"></i>
                                    </a>
                            </td>
                            <g:set var="tot" value="${tot + i.valor}"/>
                        </tr>
                    </g:each>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="2">TOTAL</th>
                        <th class="total c" style="text-align: right; ">${g.formatNumber(number: tot, maxFractionDigits: 3, minFractionDigits: 3)}</th>
                        <th></th>
                    </tr>
                    </tfoot>
                </table>
            </fieldset>
        </div>
    </div>

<div class="modal hide fade mediumModal" id="modal-var" style="overflow: hidden">
    <div class="modal-header btn-primary">
        <button type="button" class="close" data-dismiss="modal">x</button>

        <h3 id="modal_tittle_var">

        </h3>

    </div>

    <div class="modal-body" id="modal_body_var">

    </div>

    <div class="modal-footer" id="modal_footer_var">

    </div>

</div>


<script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandlerBody.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandler.js')}"></script>

<script type="text/javascript">

    $(".btnEditarIndiceCuadrilla").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'contrato', action: 'editarIndiceC_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var $btnSave = $('<a href="#" class="btn btn-success"><i class="icon icon-save"></i> Guardar</a>');
                var $btnCerrar = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
                $btnSave.click(function () {
                    $(this).replaceWith(spinner);
                    var indiceNuevo = $("#indice").val();
                    var valorNuevo = $("#valor").val();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'guardarNuevoIndice')}",
                        data    : {
                            id   : id,
                            indice: indiceNuevo,
                            valor: valorNuevo
                        },
                        success : function (msg) {
                            $("#modal-var").modal("hide");
                            if(msg == 'ok'){
                                $.box({
                                    imageClass: "box_info",
                                    text: "Guardado correctamente",
                                    title: "Guardado",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        width: 400,
                                        buttons: {
                                            "Aceptar": function () {
                                                location.reload(true);
                                            }
                                        }
                                    }
                                });
                            }else{
                                $.box({
                                    imageClass: "box_info",
                                    text: "Error al guardar!",
                                    title: "Error",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        width: 400,
                                        buttons: {
                                            "Aceptar": function () {
                                            }
                                        }
                                    }
                                });
                            }

                        }
                    });
                });
                $("#modal_tittle_var").text("Editar índice");
                $("#modal_body_var").html(msg);
                $("#modal_footer_var").html($btnCerrar).append($btnSave);
                $("#modal-var").modal("show");
            }
        });
        return false;
    });



    $(".btnEditarIndice").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'contrato', action: 'editarIndice_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                var $btnSave = $('<a href="#" class="btn btn-success"><i class="icon icon-save"></i> Guardar</a>');
                var $btnCerrar = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
                $btnSave.click(function () {
                    $(this).replaceWith(spinner);
                    var indiceNuevo = $("#indice").val();
                    var valorNuevo = $("#valor").val();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'guardarNuevoIndice')}",
                        data    : {
                            id   : id,
                            indice: indiceNuevo,
                            valor: valorNuevo
                        },
                        success : function (msg) {
                            $("#modal-var").modal("hide");
                            if(msg == 'ok'){
                                $.box({
                                    imageClass: "box_info",
                                    text: "Guardado correctamente",
                                    title: "Guardado",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        width: 400,
                                        buttons: {
                                            "Aceptar": function () {
                                                location.reload(true);
                                            }
                                        }
                                    }
                                });
                            }else{
                                $.box({
                                    imageClass: "box_info",
                                    text: "Error al guardar!",
                                    title: "Error",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        width: 400,
                                        buttons: {
                                            "Aceptar": function () {
                                            }
                                        }
                                    }
                                });
                            }

                        }
                    });
                });
                $("#modal_tittle_var").text("Editar índice");
                $("#modal_body_var").html(msg);
                $("#modal_footer_var").html($btnCerrar).append($btnSave);
                $("#modal-var").modal("show");
            }
        });
        return false;
    });



    decimales = 3;
    tabla = $(".table");

    beforeDoEdit = function (sel, tf) {
        var tipo = sel.data("tipo");
        tf.data("tipo", tipo);
    };

    textFieldBinds = {
        keyup : function () {
            var tipo = $(this).data("tipo");
            var td = $(this).parents("td");
            var val = $(this).val();
            var thTot = $("th." + tipo);
            var tds = $(".editable[data-tipo=" + tipo + "]").not(td);

            var tot = parseFloat(val);
            tds.each(function () {
                tot += parseFloat($(this).data("valor"));
            });
            thTot.text(tot);
        }
    };

    $(".editable").first().addClass("selected");

    $("#btnSave").click(function () {
//                var btn = $(this);
        var str = "";
        $(".editable").each(function () {
            var td = $(this);
            var id = td.data("id");
            var valor = parseFloat(td.data("valor"));
            var orig = parseFloat(td.data("original"));

            if (valor != orig) {
                if (str != "") {
                    str += "&";
                }
                str += "valor=" + id + "_" + valor;
            }
        });
        if (str != "") {
//                    btn.hide().after(spinner);
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'saveCambiosPolinomica')}",
                data    : str,
                success : function (msg) {
//                            spinner.remove();
//                            btn.show();
                    var parts = msg.split("_");
                    var ok = parts[0];
                    var no = parts[1];
                    doHighlight({elem : $(ok), clase : "ok"});
                    doHighlight({elem : $(no), clase : "no"});
                    location.reload(true);
                }
            });
        }
        return false;
    });

    $("#tabs").tabs({
        heightStyle : "fill",
        activate    : function (event, ui) {
            ui.newPanel.find(".editable").first().addClass("selected");
        }
    });

</script>



