<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Mantenimiento de Indices</title>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandlerBody.js')}"></script>

        <link rel="stylesheet" href="${resource(dir: 'css', file: 'tableHandler.css')}"/>

        <style type="text/css">
        th {
            vertical-align : middle !important;
            font-size      : 12px;
        }

        td {
            padding : 3px;
        }

        .number {
            text-align : right !important;
            width      : 100px;
        }

        .unidad {
            text-align : center !important;
        }

        .editable {
            background    : url(${resource(dir:'images', file:'edit.gif')}) right no-repeat;
            padding-right : 18px !important;
        }

        .changed {
            background-color : #e5c78e !important;
        }
        .grabado {
            background-color : #C3DBC3 !important;
        }
        </style>
    </head>

    <body>
        <div class="btn-toolbar" style="margin-top: 5px;">
            <div class="btn-group">
                <a href="${g.createLink(controller: 'contrato', action: 'registroContrato')}?contrato=${cntr}" class="btn " title="Regresar">
                    <i class="icon-arrow-left"></i>
                    Volver al Contrato
                </a>
            </div>
        </div>

        <fieldset class="borde">
            <div class="row">
                <div class="span4" align="center">Subpresupuesto</div>
            </div>

            <div class="row">
                <div class="span4" align="center">
                    <g:select class="span2" name="subpresupuesto" from="${subpresupuestos}" optionKey="id"
                              optionValue="${{ it.descripcion }}" noSelection="[0: 'Todos los Subpresupuestos']"
                              disabled="false" style="margin-left: 20px; width: 300px; margin-right: 50px"/>
                </div>

                <div class="btn-group span1" style="margin-left: 5px; margin-right: 10px; width: 200px;">
                    <a href="#" class="btn btn-consultar"><i class="icon-search"></i> Ver</a>
                    <a href="#" class="btn btn-verificar btn-info"><i class="icon-check"></i> Verificar</a>
                    <a href="#" class="btn btn-grabar btn-success"><i class="icon-save"></i> Guardar</a>

                </div>
                <g:link controller="cronogramaContrato" action="cantidadObra" class="btn btn-print btnExcel"
                        id="${cntr}"
                        title="Exportar a excel para definir las cantidades reales de Materiales, M.O. y Equipos"
                        style="margin-left: 80px;">
                    <i class="icon-table"></i> Generar Archivo Excel
                </g:link>
                <g:link controller="cronogramaContrato" action="subirExcel" class="btn btn-print btnExcel"
                        id="${cntr}"
                        title="Exportar a excel para definir las cantidades reales de Materiales, M.O. y Equipos"
                style="margin-left: 0px;">
                    <i class="icon-arrow-up"></i> Cargar desde Excel
                </g:link>
                %{--<div> <b>NOTA:</b> No se puede guardar valores iguales a <b> 0</b></div>--}%

            </div>
        </fieldset>

        <fieldset class="borde" >

            <div id="divTabla" style="height: 760px; overflow-y:auto; overflow-x: hidden;">

            </div>

        </fieldset>

        <script type="text/javascript">


            function consultar() {
                $("#divTabla").html("");

                var sbpr = $("#subpresupuesto").val();
                var cntr = "${cntr}"

//                console.log("antes de ajax .. periodo de indices:" + prin);

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action: 'tablaValores')}",
                    data    : { sbpr: sbpr, cntr: cntr, max: 100, pag: 1 },
                    success : function (msg) {
                        $("#divTabla").html(msg);
                        $("#dlgLoad").dialog("close");
                    }
                });

            }

            $(function () {
                $(".btn-consultar").click(function () {
                    $("#error").hide();
                    $("#dlgLoad").dialog("open");
                    consultar();
                    $("#divTabla").show();
                });

                $(".btn-grabar").click(function () {
                    $("#dlgLoad").dialog("open");
                    var data = "";

                    $(".editable").each(function () {
                        var id = $(this).data("id");
                        var cmpo = $(this).data("cmpo");
                        var valor = $(this).data("valor");
                        var data1 = $(this).data("original");
                        ////console.log(chk);

                        if ((parseFloat(data1) != parseFloat(valor))) {
                            if (data != "") {
                                data += "&";
                            }
                            var val = valor ? valor : data1;
                            data += "item=" + id + "_" + cmpo + "_" + valor;
                            $(this).addClass("grabado")
                        }
                        //console.log("item: " + data)
                    });


                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action: 'actualizaVlin')}",
                        data    : data,
                        success : function (msg) {
                            $("#dlgLoad").dialog("close");
                            var parts = msg.split("_");
                            var ok = parts[0];
                            var no = parts[1];
                            location.reload();
                            $(ok).each(function () {
                                var $tdChk = $(this).siblings(".chk");
                                var chk = $tdChk.children("input").is(":checked");
                                if (chk) {
                                    $tdChk.html('<i class="icon-ok"></i>');
                                }
                            });

                            doHighlight({elem : $(ok), clase : "ok"});
                            doHighlight({elem : $(no), clase : "no"});
                        }
                    });
                });

            });

            $(".btn-verificar").click(function () {
//                $("#dlgLoad").dialog("open");
                var data = "";

                $(".editable").each(function () {
                    var id = $(this).data("id");
                    var cmpo = $(this).data("cmpo");
                    var valor = $(this).data("valor");
                    var data1 = $(this).data("original");
                    ////console.log(chk);

                    if ((parseFloat(data1) != parseFloat(valor))) {
                        if (data != "") {
                            data += "&";
                        }
                        var val = valor ? valor : data1;
                        data += "item=" + id + "_" + cmpo + "_" + valor;
//                        var parcial = $(this).siblings("td").last().text(number_format(valor, 2, ".", ","));
                        var parcial = $(this).siblings("td").last();
                        var cantidad = parcial.prev().data("valor");
                        var precio   = parcial.prev().prev().data("valor");
                        var subtotal = Math.round(cantidad * precio * 100);
                        parcial.text(number_format(subtotal/100, 2, ".", ","));
                        $(this).siblings("td").addClass("changed")

                    }
                    //console.log("item: " + data)
                });
            });


        </script>

    </body>
</html>