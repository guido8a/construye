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
                <i class="fa fa-list-ul fa-5x"></i><br/>
                Costo actual de la obra
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" id="buscar_obra_comp">
                <i class="fa fa-database fa-5x"></i><br/>
                Composición
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" id="buscar_obra_adicionales">
                <i class="fa fa-clone fa-5x"></i><br/>
                Items adicionales
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
                <i class="fa fa-archive fa-5x"></i><br/>
                Existencias
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
                <button class="btn btn-info" id="btn-obras" ><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObra" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>

<div id="buscarObraCompo" style="overflow: hidden">
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
                <button class="btn btn-info" id="btn-obrasCompo" ><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObraCompo" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>

<div id="buscarObraDiferencia" style="overflow: hidden">
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
                <button class="btn btn-info" id="btn-obrasDiferencia" ><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaObraDiferencia" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>



<script type="text/javascript">


    $("#buscar_obra").click(function () {
        $("#buscarObra").dialog("open");
        $("#tipo").val(1);
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#buscar_obra_comp").click(function () {
        $("#buscarObraCompo").dialog("open");
        $("#tipo").val(2);
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#buscar_obra_adicionales").click(function () {
        $("#buscarObraDiferencia").dialog("open");
        $("#tipo").val(3);
        $(".ui-dialog-titlebar-close").html("x");
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

    $("#buscarObraCompo").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Obras'
    });

    $("#buscarObraDiferencia").dialog({
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
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTablaObra").html(msg);
            }
        });
    }

    $("#btn-obrasCompo").click(function () {
        buscarObrasCompo();
    });

    function buscarObrasCompo() {
        var buscarPor = $("#buscarPorObra").val();
        var criterio = $("#criterio").val();
        var ordenar = $("#ordenarObra").val();

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportesInventario', action:'listaComposicion')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTablaObraCompo").html(msg);
            }
        });
    }

    $("#btn-obrasDiferencia").click(function () {
        buscarObrasDiferencia();
    });

    function buscarObrasDiferencia() {
        var buscarPor = $("#buscarPorObra").val();
        var criterio = $("#criterio").val();
        var ordenar = $("#ordenarObra").val();

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportesInventario', action:'listaDiferencia')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTablaObraDiferencia").html(msg);
            }
        });
    }

</script>

</body>
</html>