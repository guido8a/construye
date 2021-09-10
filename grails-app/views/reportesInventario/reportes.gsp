<%@ page import="janus.construye.Bodega" %>
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
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" id="btnRequisiciones" title="Requisiciones">
                <i class="fa fa-sign-in fa-5x"></i><br/>
                Requisiciones
            </a>
            <a href="#" class="link btn btn-warning btn-ajax" data-toggle="modal" id="btnDevoluciones" >
                <i class="fa fa-sign-out fa-5x"></i><br/>
                Devoluciones
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" id="btnExistencias">
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
                <g:select name="buscarPorObraCompo" class="buscarPor" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" id="criterioCompo" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObraCompo" class="ordenar" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%" optionKey="key"
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
                <g:select name="buscarPorObraDiferencia" class="buscarPor" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioObra" id="criterioDiferencia" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarObraDiferencia" class="ordenar" from="${['1': 'Obra', '2': 'Código']}" style="width: 100%" optionKey="key"
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

<div id="listaConsumo" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarPorCnsm" class="buscarPor" from="${['1': 'Obra', '2': 'Bodega', '3': 'Recibe (Apellido)', '4': 'Fecha']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterio" id="criterioCnsm" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarCnsm" class="ordenar" from="${['1': 'Obra', '2': 'Bodega', '3': 'Recibe (Apellido)', '4': 'Fecha']}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-consumos"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaCnsm" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>


<div id="listaExistencias" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">

        <div class="row-fluid" style="margin-left: 10px">
            <div class="span4">
                Bodega
                <g:select name="buscarBodega" class="buscarPor" from="${janus.construye.Bodega.findAllByTipoNotEqual('T',[sort: 'nombre'])}" style="width: 100%"
                          optionKey="id" optionValue="descripcion"/>
            </div>

            <div class="span4">
                Grupo
                <g:select name="buscarGrupoExistencias" class="ordenar" from="${['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span4" style="margin-top: 20px">
                <button class="btn btn-info" id="btnExistenciasPdf"><i class="fa fa-print"></i> PDF</button>
                <button class="btn btn-info" id="btnExistenciasExcel"><i class="fa fa-file-excel-o"></i> EXCEL</button>
            </div>
        </div>
    </fieldset>
</div>

<div id="listaDev" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarDev" class="buscarPorDev" from="${['1': 'Obra', '2': 'Bodega', '3': 'Recibe (Apellido)', '4': 'Fecha']}" style="width: 100%"
                          optionKey="key" optionValue="value"/>
            </div>

            <div class="span2">
                <g:textField name="criterioDev_name" id="criterioDev" style="width: 80%"/></div>

            <div class="span2">
                <g:select name="ordenarDev" class="ordenar" from="${['1': 'Obra', '2': 'Bodega', '3': 'Recibe (Apellido)', '4': 'Fecha']}" style="width: 100%" optionKey="key"
                          optionValue="value"/>
            </div>

            <div class="span2" style="margin-left: 60px">
                <button class="btn btn-info" id="btn-consumosDev"><i class="icon-check"></i> Consultar</button>
            </div>

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaDev" style="height: 460px; overflow: auto">
        </div>
    </fieldset>
</div>


<script type="text/javascript">


    $("#btnDevoluciones").click(function () {
        $("#listaDev").dialog("open");
        $(".ui-dialog-titlebar-close").html("x")
    });

    $("#listaDev").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Devoluciones'
    });

    $("#btn-consumosDev").click(function () {
        buscaConsumosDev();
    });

    function buscaConsumosDev() {
        var buscarPor = $("#buscarDev").val();
        var criterio = $("#criterioDev").val();
        var ordenar = $("#ordenarDev").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportesInventario', action:'listaDevoluciones')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTablaDev").html(msg);
            }
        });
    }

    $("#btnExistenciasPdf").click(function () {
        var grupo = $("#buscarGrupoExistencias option:selected").val();
        var bodega = $("#buscarBodega option:selected").val();
        location.href = "${g.createLink(controller: 'reportes5',action: 'reporteExistencias')}?grupo=" + grupo + "&bodega=" + bodega;
        $("#listaExistencias").dialog("close")
    });

    $("#btnExistenciasExcel").click(function () {
        var grupo = $("#buscarGrupoExistencias option:selected").val();
        var bodega = $("#buscarBodega option:selected").val();
        location.href = "${g.createLink(controller: 'reportes5',action: 'reporteExistenciasExcel')}?grupo=" + grupo + "&bodega=" + bodega;
        $("#listaExistencias").dialog("close")
    });

    $("#btnExistencias").click(function () {
        $("#listaExistencias").dialog("open");
        $(".ui-dialog-titlebar-close").html("x")
    });

    $("#listaExistencias").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 600,
        height: 150,
        position: 'center',
        title: 'Existencias'
    });


    $("#btnRequisiciones").click(function () {
        $("#listaConsumo").dialog("open");
        $(".ui-dialog-titlebar-close").html("x")
    });

    $("#listaConsumo").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Requisiciones'
    });

    $("#btn-consumos").click(function () {
        buscaConsumos();
    });

    function buscaConsumos() {
        var buscarPor = $("#buscarPorCnsm").val();
        var criterio = $("#criterioCnsm").val();
        var ordenar = $("#ordenarCnsm").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'reportesInventario', action:'listaConsumo')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTablaCnsm").html(msg);
            }
        });
    }

    $("#buscar_obra").click(function () {
        $("#buscarObra").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#buscar_obra_comp").click(function () {
        $("#buscarObraCompo").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#buscar_obra_adicionales").click(function () {
        $("#buscarObraDiferencia").dialog("open");
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
        var buscarPor = $("#buscarPorObraCompo").val();
        var criterio = $("#criterioCompo").val();
        var ordenar = $("#ordenarObraCompo").val();

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
        var buscarPor = $("#buscarPorObraDiferencia").val();
        var criterio = $("#criterioDiferencia").val();
        var ordenar = $("#ordenarObraDiferencia").val();

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