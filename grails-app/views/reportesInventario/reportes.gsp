<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/21
  Time: 12:03
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Reportes</title>

 </head>

<body>



<div class="row">
    <div class="col-md-12 col-xs-5">
        <p>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" id="buscar_obra">
                <i class="fa fa-building-o fa-5x"></i><br/>
                Composición
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#detalleIngresos" title="Detalle de ingresos">
                <i class="fa fa-sign-in fa-5x"></i><br/>
                Requisiciones
            </a>
            <a href="#" class="link btn btn-warning btn-ajax" data-toggle="modal" data-target="#detalleEgresos">
                <i class="fa fa-sign-out fa-5x"></i><br/>
                Devoluciones
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#listaObras">
                <i class="fa fa-home fa-5x"></i><br/>
                Existencias
            </a>
            <a href="#" class="link btn btn-primary btn-ajax" data-toggle="modal" data-target="#balance">
                <i class="fa fa-book fa-5x"></i><br/>
                ---
            </a>
            <a href="#" class="link btn btn-warning btn-ajax" id="btnAceptarGestor">
                <i class="fa fa-line-chart fa-5x"></i><br/>
                ---
            </a>
        </p>
    </div>
</div>


<div id="buscarObra" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorObra" class="buscarPor" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" id="criterio" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObra" class="ordenar" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-obras"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObra" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>



<script type="text/javascript">


    $("#buscar_obra").click(function () {
        $("#buscarObra").dialog("open");
        $(".ui-dialog-titlebar-close").html("x")
        return false;
    });

    $("#buscarObra").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Obras'
    });

    $("#btn-obras").click(function () {
        buscarObras();
    });

    function buscarObras() {
        var buscarPor = $("#buscarPorObra").val();
        var criterio = $("#criterio").val();
        var ordenar = $("#ordenarObra").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportesInventario', action:'listaObra')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                tipo: 1
            },
            success: function (msg) {
                $("#divTablaObra").html(msg);
            }
        });
    }


    $(document).ready(function () {
        $('.item').hover(function () {
            //$('.item').click(function(){
            //entrar
            $('#tool').html($("#" + $(this).attr('texto')).html());
            $('#tool').show();
        }, function () {
            //sale
            $('#tool').hide();
        });

        $('#info').tabs({
            //event: 'mouseover', fx: {
            cookie: { expires: 30 },
            event: 'click', fx: {
                opacity: 'toggle',
                duration: 'fast'
            },
            spinner: 'Cargando...',
            cache: true
        });
    });

    var actionUrl = "";

    function updatePeriodo() {
        var cont = $("#contP").val();

        $.ajax({
            type: "POST",
            url: "${createLink(action:'updatePeriodo')}",
            data: {
                cont: cont
            },
            success: function (msg) {
                $("#divPeriodo").html(msg);
            }
        });

//                console.log(cont);
    }

    $(function () {

        $(".link").hover(
            function () {
                /*
                                    $(this).addClass("linkHover");
                                    $(".notice").hide();
                                    var id = $(this).parent().attr("text");
                                    $("#" + id).show();
                */
            },
            function () {
                /*
                                    $(this).removeClass("linkHover");
                                    $(".notice").hide();
                */
            }).click(function () {
            %{--var url = $(this).attr("href");--}%
            %{--var file = $(this).attr("file");--}%

            %{--var dialog = trim($(this).attr("dialog"));--}%
            %{--var cont = trim($(this).text());--}%


            %{--$("#" + dialog).dialog("option", "title", cont);--}%
            %{--$("#" + dialog).dialog("open");--}%

            %{--actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;--}%

            %{--//                            console.log(actionUrl);--}%

            %{--<g:link action="pdfLink" controller="pdf" params="[url: g.createLink(controller: 'reportes', action: 'planDeCuentas'), filename: 'Plan_de_Cuentas.pdf']">--}%
            %{--plan de cuentas--}%
            %{--</g:link>--}%

            %{--//                            console.log(url, file);--}%

            %{--return false;--}%
        });

        $("#contP").change(function () {
            updatePeriodo();
        });

        $("#dlgContabilidad").dialog({
            modal: true,
            resizable: false,
            autoOpen: false,
            buttons: {
                "Aceptar": function () {
                    var cont = $("#cont").val();
                    var url = actionUrl + "?cont=" + cont + "Wemp=${session.empresa?.id}";
//                            console.group("URL");
//                            console.log(actionUrl);
//                            console.log(url);
//                            console.groupEnd();

                    location.href = url;
                },
                "Cancelar": function () {
                    $("#dlgContabilidad").dialog("close");
                }
            }
        });
        $("#dlgVentas").dialog({
            modal: true,
            width: 400,
            height: 300,
            title: "Reporte de ventas",
            autoOpen: false,
            buttons: {
                "Ver": function () {
                    var desde = $("#desde").val()
                    var hasta = $("#hasta").val()
                    location.href = "${g.createLink(action: 'ventas')}?desde=" + desde + "&hasta=" + hasta;
                }
            }
        });

        $("#dlgContabilidadPeriodo").dialog({
            modal: true,
            resizable: false,
            autoOpen: false,
            width: 400,
            open: function () {
                updatePeriodo();
            },
            buttons: {
                "Aceptar": function () {
                    var cont = $("#contP").val();
                    var per = $("#periodo").val();
                    var url = actionUrl + "?cont=" + cont + "Wper=" + per + "Wemp=${session.empresa?.id}";
//                            console.group("URL");
//                            console.log(actionUrl);
//                            console.log(url);
//                            console.groupEnd();
                    location.href = url;
                },
                "Cancelar": function () {
                    $("#dlgContabilidadPeriodo").dialog("close");
                }
            }
        });


        $("#btnComprobantes").button({
            icons: {
                primary: "ui-icon-search"
            }
        });

        $("#dlgComprobante").dialog({
            resizable: false,
            autoOpen: false,
            modal: true,
            width: 400,
            buttons: {
                "Aceptar": function () {
                    var cont = $("#cont").val();
                    var per = $("#periodo").val();
                    var url = actionUrl + "?cont=" + cont + "Wper=" + per + "Wemp=${session.empresa?.id}";
//                            console.group("URL");
//                            console.log(actionUrl);
//                            console.log(url);
//                            console.groupEnd();
                    location.href = url;
                },
                "Cancelar": function () {
                    $("#dlgComprobante").dialog("close");
                }
            }
        });

    });
</script>

</body>
</html>