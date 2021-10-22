<%@ page contentType="text/html;charset=UTF-8" %>

<%
    def buscadorServ = grailsApplication.classLoader.loadClass('janus.utilitarios.BuscadorService').newInstance()
%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Existencias</title>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }
    </style>

</head>

<body>

<div style="text-align: center; margin-bottom:20px">
    <h3>Existencias en Bodega</h3>
</div>
<g:if test="${flash.message}">
    <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
        <a class="close" data-dismiss="alert" href="#">×</a>
        ${flash.message}
    </div>
</g:if>


<div id="busqueda" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Bodega</div>
            <div class="span2">Grupo</div>

            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="bodega" class="buscarPor"
                          from="${bodegas}"
                          style="width: 100%" optionKey="id" optionValue="descripcion"/></div>

            <div class="span2">
                <g:select name="buscarGrupo" class="buscarPor"
                          from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
                          style="width: 100%" optionKey="key" optionValue="value"/></div>

            <div class="span2"><g:select name="buscarPor" class="buscarPor" from="${listaItems}"
                                         style="width: 100%" optionKey="key"
                                         optionValue="value"/></div>

            <div class="span2">
                <g:textField name="criterio" class="criterio" style="width: 80%"/>
            </div>

            <div class="span2">
                <g:select name="ordenar" class="ordenar" from="${listaItems}"
                          style="width: 100%" optionKey="key"
                          optionValue="value"/></div>

            <div class="span2" style="margin-left: 20px">
                <button class="btn btn-info" id="btn-consultar"><i
                        class="icon-check"></i> Consultar
                </button>
                <a href="#" class="btn btn-ajax btn-primary" id="imprimir" title="Imprimir Existencias">
                    <i class="icon-print"></i>
                </a>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde">
        <table class="table table-bordered table-hover table-condensed" style="width: 100%">
            <thead>
            <tr>
                <th class="alinear" style="width: 10%">Código</th>
                <th class="alinear" style="width: 42%">Item</th>
                <th class="alinear" style="width: 5%">Unidad</th>
                <th class="alinear" style="width: 10%">Fecha</th>
                <th class="alinear" style="width: 10%">Existencias</th>
                <th class="alinear" style="width: 8%">P. Unitario</th>
                <th class="alinear" style="width: 8%">Valor</th>
                <th class="alinear" style="width: 2%">Retazo</th>
                <th class="alinear" style="width: 5%"></th>
            </tr>
            </thead>
            <tbody>
            </tbody>

        </table>
        <div class="alert alert-danger hidden" id="mensaje" style="text-align: center">
        </div>

        <div id="divTabla" style="height: 460px; overflow-y:auto; overflow-x: auto; margin-top: -20px">
        </div>

    </fieldset>
</div>


<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna
como máximo 30
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                Problema y Solución..
            </div>

            <div class="modal-body" id="dialog-body" style="padding: 15px">

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

%{--Dialogo solicitudes--}%
<div class="modal fade col-md-12 col-xs-12" id="solicitud" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalsolicitud">Generar cartas solicitando pagos</h4>
            </div>

            <div class="modal-body" id="bodysolicitud">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-1">
                        </div>
                        <div class="col-md-3 col-xs-3">
                            <label>Generar para deudas con </label>
                        </div>
                        <div class="col-md-7 col-xs-7">
                            <g:select from="${['1':'Valores superiores a 1 alícuota',
                                               '2':'Valores superiores a 2 alícuotas',
                                               '3':'Valores superiores a 3 alícuotas']}"
                                      optionValue="value" optionKey="key" name="mesesHasta_name"
                                      id="valorHasta" class="form-control"/>
                        </div>
                        <div class="col-md-1 col-xs-1">
                        </div>

                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnSolicitud btn-success" data-dismiss="modal"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal hide fade" id="modal-showProveedor" style="width: 600px;">
    <div class="modal-header" id="modalHeaderShow">
        <button type="button" class="close darker" data-dismiss="modal">
            <i class="icon-remove-circle"></i>
        </button>

        <h3 id="modalTitleShow"></h3>
    </div>

    <div class="modal-body" id="modalBodyShow">
    </div>

    <div class="modal-footer" id="modalFooterShow">
    </div>
</div>

<script type="text/javascript">

    $("#imprimir").click(function () {
        var grupo = $("#buscarGrupo option:selected").val();
        var bodega = $("#bodega option:selected").val();

        $.box({
            imageClass: "box_info",
            text: "Seleccione el tipo de formato que desea imprimir",
            title: "Imprimir existencias",
            dialog: {
                resizable: false,
                draggable: false,
                width: 360,
                height: 180,
                buttons: {
                    "PDF": function () {
                        location.href = "${g.createLink(controller: 'reportes5',action: 'reporteExistencias')}?grupo=" + grupo + "&bodega=" + bodega;
                    },
                    "EXCEL": function () {
                        location.href = "${g.createLink(controller: 'reportes5',action: 'reporteExistenciasExcel')}?grupo=" + grupo + "&bodega=" + bodega;
                    },
                    "Cancelar" : function () {

                    }
                }
            }
        });
    });

    $(function () {
        $("#limpiaBuscar").click(function () {
            $("#buscar").val('');
        });
    });

    <g:if test="${bodegas}">
    busqueda();
    </g:if>
    <g:else>
    $("#mensaje").removeClass('hidden').append("No se han encontrado existencias");
    </g:else>

    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $("#btn-consultar").click();
        }
    });

    %{--function createContextMenu(node) {--}%
    %{--    var $tr = $(node);--}%
    %{--    var items = {--}%
    %{--        header: {--}%
    %{--            label: "Acciones",--}%
    %{--            header: true--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var id = $tr.data("id");--}%
    %{--    var deuda = $tr.data("deuda");--}%
    %{--    var ingr = $tr.data("ingr");--}%
    %{--    var codigo = $tr.data("p");--}%

    %{--    var perfil = {--}%
    %{--        label: " Asignar Perfil",--}%
    %{--        icon: "fa fa-user-o",--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            asignarPerfil(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var editar = {--}%
    %{--        label: " Editar Persona",--}%
    %{--        icon: "fa fa-id-card-o",--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            createEditRow(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var alicuota = {--}%
    %{--        label: "Alícuota",--}%
    %{--        icon: "fa fa-money",--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            tablaAlicuotas(id)--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var ingresos = {--}%
    %{--        label: "Registro de Pagos",--}%
    %{--        icon: "fa fa-money",--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            pagoAlicuota(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var certificado = {--}%
    %{--        label: "Certificado Expensas",--}%
    %{--        icon: "fa fa-print",--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            location.href='${createLink(controller: 'reportes', action: 'expensas')}?id=' + id;--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var propiedades = {--}%
    %{--        label: "Propiedades",--}%
    %{--        icon: "fa fa-home",--}%
    %{--        separator_before : true,--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            location.href='${createLink(controller: 'propiedad', action: 'list')}?id=' + id;--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var detalle = {--}%
    %{--        label: "Detalle Pagos",--}%
    %{--        icon: "fa fa-print",--}%
    %{--        separator_before : true,--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            cargarFechas(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var solicitudPago = {--}%
    %{--        label: "Solicitud de Pago",--}%
    %{--        icon: "fa fa-print",--}%
    %{--        separator_before : true,--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--            seleccionarAlicuotas(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var solicitudMonitorio = {--}%
    %{--        label: "Solicitud de Monitorio",--}%
    %{--        icon: "fa fa-print",--}%
    %{--        separator_before : true,--}%
    %{--        action : function ($element) {--}%
    %{--            var id = $element.data("id");--}%
    %{--        }--}%
    %{--    };--}%

    %{--    return items--}%
    %{--}--}%

    $("#btnLimpiarBusqueda").click(function () {
        $(".fechaD, .fechaH, #criterio_con").val('');
    });

    $("#buscador_con").change(function(){
        var anterior = "${params.operador}";
        var opciones = $(this).find("option:selected").attr("class").split(",");

        poneOperadores(opciones);
        /* regresa a la opción seleccionada */
//        $("#oprd option[value=" + anterior + "]").prop('selected', true);
    });


    $("#btn-consultar").click(function () {
        busqueda();
    });

    function busqueda() {
        var buscarPor = $("#buscarPor").val();
        var criterio = $(".criterio").val();
        var ordenar = $("#ordenar").val();
        var grupo = $("#buscarGrupo option:selected").val();
        var bdga = $("#bodega option:selected").val();
        var obra = $("#obra__id").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'existencia', action:'listaExst')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                grupo: grupo,
                bdga: bdga,
                obra: obra
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            }
        });
    }

    function cargarFechas (id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'reportes', action:'fechasDetalle_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgFechasDetalle",
                    title   : "Período para el detalle de Pagos",
//                    class   : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar : {
                            label     : "<i class='fa fa-print'></i> Imprimir",
                            className : "btn-success",
                            callback  : function () {
                                var hasta = $("#fechaHastaDet").val();
                                var desde = $("#fechaDesdeDet").val();
                                location.href='${createLink(controller: 'reportes', action: 'reporteDetallePagos')}?id=' + id + "&desde=" + desde + "&hasta=" + hasta ;
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 100);
            } //success
        }); //ajax
    }


    function poneOperadores (opcn) {
        var $sel = $("<select name='operador' id='oprd' style='width: 120px' class='form-control'>");
        for(var i=0; i<opcn.length; i++) {
            var opt = opcn[i].split(":");
            var $opt = $("<option value='"+opt[0]+"'>"+opt[1]+"</option>");
            $sel.append($opt);
        }
        $("#selOpt").html($sel);
    }

    /* inicializa el select de oprd con la primea opción de busacdor */
    $(document).ready(function() {
        $("#buscador_con").change();
    });

</script>

</body>
</html>