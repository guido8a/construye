<%@ page import="janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Volúmenes de obra
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.ui.position.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.js')}" type="text/javascript"></script>
    <link href="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.css')}" rel="stylesheet" type="text/css"/>

    <style type="text/css">
    .boton {
        padding: 2px 6px;
        margin-top: -10px
    }
    </style>
</head>

<body>
<div class="span12" id="mensaje">
    <g:if test="${flash.message}">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <elm:poneHtml textoHtml="${flash.message}"/>
        </div>
    </g:if>
</div>

<div class="span12 hide" style="margin-bottom: 10px;" id="divError">
    <div class="alert alert-error" role="status">
        <a class="close" data-dismiss="alert" href="#">×</a>
        <span id="spanError"></span>
    </div>
</div>

<div class="span12 hide" style="margin-bottom: 10px;" id="divOk">
    <div class="alert alert-success" role="status">
        <a class="close" data-dismiss="alert" href="#">×</a>
        <span id="spanOk"></span>
    </div>
</div>

<div style=" font-size: 14px;  color: #0088CC;">
    Volúmenes de la obra: <strong>${"( Código: " + obra.codigo + ") " + obra.nombre}</strong>
    <input type="hidden" id="override" value="0">
</div>
<div style="height: 25px; margin-bottom:10px; border-bottom: 1px solid rgba(148, 148, 148, 1);">
    <div class="span2" style="margin-left: 150px;">
        <b>Memo:</b> ${obra?.memoCantidadObra}
    </div>
    <div class="span3">
        <b>Ubicación:</b> ${obra?.parroquia?.nombre}
    </div>

    <div class="span2">
        <b style="">Dist. peso:</b> ${obra?.distanciaPeso}
    </div>

    <div class="span2" style="margin-left: -40px;">
        <b>Dist. volúmen:</b> ${obra?.distanciaVolumen}
    </div>
</div>

<div class="row">
    <div class="span6 btn-group" role="navigation" style="margin-left: 35px;">
        <a href="${g.createLink(controller: 'obra', action: 'registroObra', params: [obra: obra?.id])}" class="btn btn-ajax btn-new" id="atras" title="Regresar a la obra">
            <i class="icon-arrow-left"></i>
            Regresar
        </a>
        <a href="#" class="btn btn-ajax btn-new" id="calcular" title="Calcular precios">
            <i class="icon-table"></i>
            Calcular
        </a>
        <a href="#" class="btn btn-ajax btn-new" id="reporteGrupos" title="Reporte Grupos/Subgrupos" style="display: none">
            <i class="icon-print"></i>
            Reporte Grupos/Subgrupos
        </a>
    </div>

    <div class="span6 btn-group" role="navigation" style="margin-left: 5px;">
        <a href="#" class="btn  " id="copiar_rubros" title="Copiar rubros desde un subpresupuesto">
            <i class="icon-copy"></i>
            Copiar Rubros desde un subpresupuesto
        </a>
        <a href="#" class="btn btn-ajax btn-primary" id="btnCopiarRubroObra" title="Copiar rubros de una obra">
            <i class="fa fa-copy"></i>
            Copiar Rubros desde otra Obra
        </a>
    </div>
</div>

<g:if test="${obra.valor > vmc}">
    <div style="margin-top: 10px;">
        <div class="alert alert-warning" style="font-weight: bold; font-size: 13px;">
            <i class="icon icon-info-sign icon-2x pull-left"></i>
            <p>
                El presupuesto supera el límite de menor cuantía según lo registrado,
                por lo que no es obligatoria la elaboración de la fórmula polinómica ni cuadrilla tipo
                para registrar esta obra.
            </p>
            <g:if test="${obra.valor >= valorLicitacion}">
                <i class="icon icon-info-sign icon-2x pull-left"></i>
                <p>El presupuesto corresponde a una Licitación por lo que es obligatorio presentar el VAE.</p>
            </g:if>
        </div>
    </div>
</g:if>

<div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: 0px">
    <div class="borde_abajo" style="padding-left: 5px;position: relative; height: 92px">

        <div class="row-fluid" style="margin-left: 0px">
            <div class="span3" style="width: 185px; ">
                <b>Tipo de Obra:</b><g:select name="grupos" id="grupos" from="${grupoFiltrado}" optionKey="id" optionValue="descripcion"
                                              style="margin-left: 0px; width: 180px; font-size: 11px" value="${janus.Grupo.findByDireccion(obra.departamento.direccion)?.id}"/>
            </div>

            <div class="row-fluid" style="margin-left: 0px">
                <div class="span4" style="width: 400px">
                    <b>Crear Subpresupuesto / Ingresar Rubros:</b>
                    <span id="sp">
                        <span id="div_cmb_sub">
                            <g:select name="subpresupuesto" from="${subpreFiltrado}" optionKey="id" optionValue="descripcion" id="subPres"/>
                        </span>
                    </span>

                    <g:if test="${persona?.departamento?.codigo == 'PRSP'}">
                        <a href="#" class="btn boton btn-primary" id="btnCrearSP" title="Crear subpresupuesto" style="margin-top: -10px;">
                            <i class="icon-plus"></i>
                        </a>
                        <a href="#" class="btn boton btn-danger" id="btnBorrarSP" title="Borrar subpresupuesto" style="margin-top: -10px;">
                            <i class="icon-trash"></i>
                        </a>
                        <a href="#" class="btn boton" id="btnEditarSP" title="Editar subpresupuesto" style="margin-top: -10px;">
                            <i class="icon-edit"></i>
                        </a>
                    </g:if>
                </div>

                <div class="span1" style="margin-left: 0px; width: 100px;">
                    <b>Código</b>
                    <input type="text" style="width: 100px;;font-size: 10px" id="item_codigo" class="allCaps" readonly="true">
                    <input type="hidden" id="item_id">
                </div>

                <div class="span1" style="margin-top: 20px; width: 80px">
                    <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar" id="btnRubro">
                        <i class="icon-search"></i> Buscar
                    </a>
                </div>

                <div class="span4" style="margin-left: 0px;">
                    <b>Rubro</b>
                    <input type="text" style="width: 350px;font-size: 10px" id="item_nombre" readonly="true">
                </div>

                <div class="span2" style="margin-left: 0px; width: 780px;">
                    <b>Descripción:</b>
                    <input type="text" style="width: 680px" id="item_descripcion" value="">
                </div>
                <div class="span2" style="margin-left: 20px; width: 180px;" id="lbl_cntd">
                    <b>Cantidad:</b>
                    <input type="text" style="width: 90px;text-align: right" id="item_cantidad" value="">
                </div>

                <div class="span1" style="margin-left: 20px; width: 90px;">
                    <b>Orden:</b>
                    <input type="text" style="width: 30px;text-align: right" id="item_orden" value="${(volumenes?.size() > 0) ? volumenes.size() + 1 : 1}">
                </div>

                <div class="span2" style="margin-left: 10px;padding-top:0px; width: 65px;">
                    <input type="hidden" value="" id="vol_id">
                    <g:if test="${obra?.estado != 'R' && duenoObra == 1}">
                        <a href="#" class="btn btn-small btn-primary" title="Guardar item" id="item_agregar">
                            <i class="icon-plus"></i>
                        </a>
                        <a href="#" class="btn btn-small btn-primary" title="Cancelar" id="btnCancelar">
                            <i class="fa fa-times"></i>
                        </a>
                    </g:if>
                </div>
            </div>
        </div>

        <div class="borde_abajo" style="position: relative;float: left;width: 95%;padding-left: 45px">
            <p class="css-vertical-text">Composición</p>

            <div class="linea" style="height: 98%;"></div>

            <div style="width: 99.7%;height: 500px;overflow-y: auto;float: right;" id="detalle"></div>

            <div style="width: 99.7%;height: 30px;overflow-y: auto;float: right;text-align: right" id="total">
                <b>TOTAL:</b>

                <div id="divTotal" style="width: 150px;float: right;height: 30px;font-weight: bold;font-size: 12px;margin-right: 20px"></div>
            </div>
        </div>
    </div>
</div>

<div class="modal grande hide fade" id="modal-rubro" style="overflow: hidden;">
    <div class="modal-header btn-info">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
        <bsc:buscador name="rubro.buscador.id" value="" accion="buscaRubro" controlador="volumenObra" campos="${campos}" label="Rubro" tipo="lista"/>
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<div class="modal hide fade" id="modal-SubPresupuesto">
    <div class="modal-header" id="modalHeader">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitle-sp"></h3>
    </div>

    <div class="modal-body" id="modalBody-sp">
    </div>

    <div class="modal-footer" id="modalFooter-sp">
    </div>
</div>

<div id="borrarSPDialog">
    <fieldset>
        <div class="span3">
            Está seguro que desea borrar el subpresupuesto?
        </div>
    </fieldset>
</div>

<div id="busqueda" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Grupo</div>

            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarGrupo_name"  id="buscarGrupo" from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
                          style="width: 100%" optionKey="key" optionValue="value"/></div>

            <div class="span2"><g:select name="buscarPor" class="buscarPor" from="${[1: 'Nombre', 2: 'Código']}"
                                         style="width: 100%" optionKey="key"
                                         optionValue="value"/></div>

            <div class="span2">
                <g:textField name="criterio" class="criterio" style="width: 80%"/>
            </div>

            <div class="span2">
                <g:select name="ordenar" class="ordenar" from="${[1: 'Nombre', 2: 'Código']}"
                          style="width: 100%" optionKey="key"
                          optionValue="value"/></div>

            <div class="span2" style="margin-left: 60px"><button class="btn btn-info" id="btn-consultar"><i
                    class="icon-check"></i> Consultar
            </button></div>

        </div>
    </fieldset>

    <fieldset class="borde">
        <div id="divTabla" style="height: 460px; overflow-y:auto; overflow-x: auto;">
        </div>
    </fieldset>
</div>


<script type="text/javascript">


    $("#btnRubro").click(function () {
        $("#busqueda").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#busqueda").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Materiales y Equipos a Entregar'
    });

    $("#btn-consultar").click(function () {
        busqueda();
    });

    function busqueda() {
        var buscarPor = $("#buscarPor").val();
        var criterio = $(".criterio").val();
        var ordenar = $("#ordenar").val();
        var grupo = $("#buscarGrupo").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'listaItem')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                grupo: grupo
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            }
        });
    }



    $("#btnCancelar").click(function () {
        $("#calcular").removeClass("active");
        $(".col_delete").show();
        $(".col_precio").hide();
        $(".col_total").hide();
        $("#divTotal").html("");
        $("#vol_id").val('');   /* gdo: id del registro a editar */
        $("#item_codigo").val('');
        $("#item_id").val('');
        $("#subPres").val(1);
        $("#item_descripcion").val('');

        $("#item_nombre").val('');
        $("#item_cantidad").val('');
        // $("#item_orden").val('');
        $("#item_orden").val() * 1 + 1
    });

    $("#btnCopiarRubroObra").click(function () {
        location.href="${createLink(controller: 'volumenObra', action: 'copiarRubrosObra')}?id=" + '${obra?.id}'
    });

    var aviso = false;  //aviso de TR...

    function loading(div) {
        y = 0;
        $("#" + div).html("<div class='tituloChevere' id='loading'>Sistema Cargando, Espere por favor</div>");
        var interval = setInterval(function () {
            if (y == 30) {
                $("#detalle").html("<div class='tituloChevere' id='loading'>Cargando, Espere por favor</div>");
                y = 0
            }
            $("#loading").append(".");
            y++
        }, 500);
        return interval
    }

    function cargarTabla() {
        var interval = loading("detalle")
        var datos = ""
        if ($("#subPres_desc").val() * 1 > 0) {
            datos = "obra=${obra.id}&sub=" + $("#subPres_desc").val() + "&ord=" + 1
        } else {
            datos = "obra=${obra.id}&ord=" + 1
        }
        $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra', action:'tabla')}",
            data     : datos,
            success  : function (msg) {
                clearInterval(interval)
                $("#detalle").html(msg);
                $("#reporteGrupos").show()
            }
        });
    }
    $(function () {
        $("#grupos").change(function () {
            cargarSub();
        });

        function cargarSub(){
            $.ajax({
                type    : "POST",
                url : "${g.createLink(controller: 'volumenObra',action:'cargarSubpres')}",
                data    : "grupo=" + $("#grupos").val(),
                success : function (msg) {
                    $("#div_cmb_sub").html(msg)
                }
            });
        }

        cargarTabla();
        $("#vol_id").val("")

        $("#calcular").click(function () {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active")
                $(".col_delete").show()
                $(".col_precio").hide()
                $(".col_total").hide()
                $("#divTotal").html("")
            } else {
                $(this).addClass("active")
                $(".col_delete").hide()
                $(".col_precio").show()
                $(".col_total").show()
                var total = 0

                $(".total").each(function () {
                    total += parseFloat(str_replace(",", "", $(this).html()))
                });

                if ($("#subPres_desc").val() == "-1") {
                    $.ajax({
                        type    : "POST",
                        url : "${g.createLink(controller: 'volumenObra', action:'setMontoObra')}",
                        data    : "obra=${obra?.id}&monto=" + total,
                        success : function (msg) {

                        }
                    });
                }
                $("#divTotal").html(number_format(total, 2, ".", ","))
            }
        });

        // $("#item_codigo").dblclick(function () {
        // $("#btnRubro").click(function () {
        //     var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
        //     $("#modalTitle").html("Lista de rubros");
        //     $("#modalFooter").html("").append(btnOk);
        //     $("#modal-rubro").modal("show");
        //     $("#buscarDialog").unbind("click");
        //     $("#buscarDialog").bind("click", enviar)
        // });

        $("#reporteGrupos").click(function () {
            location.href = "${g.createLink(controller: 'reportes',action: 'reporteSubgrupos',id: obra?.id)}"
        });

        $("#item_codigo").blur(function () {
            if ($("#item_id").val() == "" && $("#item_codigo").val() != "") {
                $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'buscarRubroCodigo')}",
                    data     : "codigo=" + $("#item_codigo").val(),
                    success  : function (msg) {
                        // console.log("msg "+msg)
                        if (msg != "-1") {
                            var parts = msg.split("&&");
                            $("#item_id").val(parts[0]);
                            $("#item_nombre").val(parts[2])
                        } else {
                            $("#item_id").val("");
                            $("#item_nombre").val("")
                        }
                    }
                });
            }
        });

        $("#item_codigo").keydown(function (ev) {
            if (ev.keyCode * 1 != 9 && (ev.keyCode * 1 < 37 || ev.keyCode * 1 > 40)) {
                $("#item_id").val("");
                $("#item_nombre").val("")
            } else {
            }
        });

        $("#btnCrearSP").click(function () {
            var $btnOrig = $(this).clone(true);
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:"subPresupuesto",action:'form_ajax')}?obra=" + ${obra?.id},
                success : function (msg) {
                    $("#modalBody-sp").html(msg);

                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');
                    var $frm = $("#frmSave-SubPresupuesto");

                    btnSave.click(function () {
                        var data = $frm.serialize();
                        spinner.replaceWith($btnOrig);

                        if ($frm.valid()) {
                            $.ajax({
                                type    : "POST",
                                url     : $frm.attr("action"),
                                data    : data,
                                success : function (msg) {
                                    $("#modal-SubPresupuesto").modal("hide");
                                    var p = msg.split("_");
                                    var alerta;

                                    if (p[0] != "NO") {
                                        $.box({
                                            imageClass : "box_info",
                                            text       : p[1],
                                            title      : "Alerta",
                                            iconClose  : false,
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                width     : 500,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                        cargarSub();
                                                    }
                                                }
                                            }
                                        });
                                    }
                                    else {
                                        $.box({
                                            imageClass : "box_info",
                                            text       : p[1],
                                            title      : "Alerta",
                                            iconClose  : false,
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                width     : 500,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                        return false;
                    });

                    btnOk.click(function () {
                        spinner.replaceWith($btnOrig);
                    });

                    $("#modalHeader-sp").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitle-sp").html("Crear Sub Presupuesto");
                    $("#modalFooter-sp").html("").append(btnOk).append(btnSave);
                    $("#modal-SubPresupuesto").modal("show");

                    $("#volob").val("1");
                }
            });
            return false;
        });

        $("#btnEditarSP").click(function () {
            var $btnOrig = $(this).clone(true);

            var idSp = $("#subPres").val();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:"subPresupuesto",action:'form_ajax')}",
                data    : {
                    id : idSp
                },
                success : function (msg) {
                    $("#modalBody-sp").html(msg);

                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                    var $frm = $("#frmSave-SubPresupuesto");

                    btnSave.click(function () {

                        var data = $frm.serialize();

                        if ($frm.valid()) {
                            $.ajax({
                                type    : "POST",
                                url     : $frm.attr("action"),
                                data    : data,
                                success : function (msg) {
                                    $("#modal-SubPresupuesto").modal("hide");
                                    var p = msg.split("_");
                                    var alerta;

                                    if (p[0] != "NO") {
                                        $.box({
                                            imageClass : "box_info",
                                            text       : p[1],
                                            title      : "Alerta",
                                            iconClose  : false,
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                width     : 500,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                        // location.reload(true)
                                                        cargarSub();
                                                    }
                                                }
                                            }
                                        });
                                    }
                                    else {
                                        $.box({
                                            imageClass : "box_info",
                                            text       : p[1],
                                            title      : "Alerta",
                                            iconClose  : false,
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                width     : 500,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }

                        return false;
                    });

                    btnOk.click(function () {
                        spinner.replaceWith($btnOrig);
                    });

                    $("#modalHeader-sp").removeClass("btn-edit btn-show btn-delete");
                    $("#modalTitle-sp").html("Editar Sub Presupuesto");
                    $("#modalFooter-sp").html("").append(btnOk).append(btnSave);
                    $("#modal-SubPresupuesto").modal("show");

                    $("#volob").val("1");
                }
            });
            return false;

        });

        $("#btnBorrarSP").click(function () {
            // $("#borrarSPDialog").dialog("open")

            $.box({
                imageClass : "box_info",
                text       : "Está seguro de borrar este subpresupuesto?",
                title      : "Alerta",
                iconClose  : false,
                dialog     : {
                    resizable : false,
                    draggable : false,
                    width     : 450,
                    buttons   : {
                        "Aceptar" : function () {
                            var id = $("#subPres").val();
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(controller:"subPresupuesto",action:'delete2')}",
                                data    : {
                                    id : id
                                },
                                success : function (msg) {
                                    var p = msg.split("_");
                                    var alerta;
                                    if (msg != "NO") {

                                        $.box({
                                            imageClass : "box_info",
                                            text       : "Se ha borrado correctamente el subpresupuesto",
                                            title      : "Alerta",
                                            iconClose  : false,
                                            dialog     : {
                                                resizable : false,
                                                draggable : false,
                                                width     : 450,
                                                buttons   : {
                                                    "Aceptar" : function () {
                                                        cargarSub();
                                                    }
                                                }
                                            }
                                        });

                                        // alerta = '<div class="alert alert-success" role="status"><a class="close" data-dismiss="alert" href="#">×</a>';
                                        // alerta += p[1];
                                        // alerta += '</div>';
                                        // $("#div_cmb_sub").html(p[2])
                                    } else {
                                        alerta = '<div class="alert alert-error" role="status"><a class="close" data-dismiss="alert" href="#">×</a>';
                                        alerta += p[1];
                                        alerta += '</div>';
                                    }
                                    $("#mensaje").html(alerta);
                                }
                            });
                        },
                        "Cancelar" : function () {

                        }
                    }
                }
            });

        });

        $("#item_agregar").click(function () {
            $("#calcular").removeClass("active");
            $(".col_delete").show();
            $(".col_precio").hide();
            $(".col_total").hide();
            $("#divTotal").html("");

            var cantidad = $("#item_cantidad").val();
            cantidad = str_replace(",", "", cantidad);
            var orden = $("#item_orden").val();
            var rubro = $("#item_id").val();
            var cod = $("#item_codigo").val();
            var sub = $("#subPres").val();
            var dscr = $("#item_descripcion").val();
            if (isNaN(cantidad))
                cantidad = 0;
            if (isNaN(orden))
                orden = 0;
            var msn = "";
            if (cantidad * 1 < 0.00001 || orden * 1 < 1) {
                msn = "La cantidad  y el orden deben ser números positivos mayores a 0"
            }

            if (rubro * 1 < 1)
                msn = "seleccione un rubro";

            if (msn.length == 0) {
                var datos = "rubro=" + rubro + "&cantidad=" + cantidad + "&orden=" + orden + "&sub=" + sub +
                    "&obra=${obra.id}" + "&cod=" + cod + "&ord=" + '1&override=' + $("#override").val() +
                    "&dscr=" + dscr;
                if ($("#vol_id").val() * 1 > 0)
                    datos += "&id=" + $("#vol_id").val();

                $.ajax({
                    type : "POST",
                    url : "${g.createLink(controller: 'volumenObra',action:'addItem')}",
                    data     : datos,
                    success  : function (msg) {
                        if (msg != "error") {
                            $("#detalle").html(msg);
                            $("#vol_id").val("");
                            $("#item_codigo").val("");
                            $("#item_id").val("");
                            $("#item_nombre").val("");
                            $("#item_cantidad").val("");
                            $("#item_descripcion").val("");
                            $("#item_orden").val($("#item_orden").val() * 1 + 1);
                            $("#override").val("0")
                        } else {

                            $.box({
                                imageClass : "box_info",
                                text       : "El item ya existe dentro del volumen de obra. Desea incrementar la cantidad?",
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
                                    width     : 500,
                                    buttons   : {
                                        "Aceptar" : function () {
                                            $("#override").val("1");
                                            $("#item_agregar").click()
                                        },
                                        "cancelar" : function () {
                                            $("#vol_id").val("");
                                            $("#item_codigo").val("");
                                            $("#item_id").val("");
                                            $("#item_nombre").val("");
                                            $("#item_cantidad").val("");
                                            $("#item_orden").val($("#item_orden").val() * 1 + 1)
                                        }
                                    }
                                }
                            });
                         }
                    }
                });
            } else {
                $.box({
                    imageClass : "box_info",
                    text       : msn,
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        width     : 500,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        }
                    }
                });
            }
        });

        $(document).ready(function () {
            $("#grupos").trigger("change");
        });

        function alerta(titl, mnsj)
        {
            $("<div></div>").html(mnsj).dialog({
                title: titl,
                resizable: false,
                modal: true,
                buttons: {
                    "Aceptar": function()
                    {
                        $( this ).dialog( "close" );
                    }
                }
            });
        }

        $("#item_cantidad").focus(function () {
            if (($("#item_nombre").val()) && ($("#item_codigo").val().substr(0, 2) == 'TR') && !aviso) {
                aviso = true;
                alerta("Rubro para transporte", "Debe registrar la distancia de desalojo en Variables de " +
                    "la obra, en la sección Transporte Especial");
            }
        });
    });
</script>
</body>
</html>