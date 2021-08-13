
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 8/20/13
  Time: 12:10 PM
--%>

<style type="text/css">
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


%{--<div class="" style="width: 99.7%;height: 270px; overflow-y: auto;float: right; margin-top: -20px">--}%
%{--    <table class="table-bordered table-condensed table-hover tabla" style="width: 100%">--}%
%{--        <g:each in="${lista}" var="detalle" status="z">--}%
%{--            <tr id="tr_${detalle?.id}">--}%
%{--                <td style="width: 15%">--}%
%{--                    ${detalle?.item?.codigo}--}%
%{--                </td>--}%
%{--                <td style="width: 45%">--}%
%{--                    ${detalle?.item?.nombre}--}%
%{--                </td>--}%
%{--                <td style="width: 15%; text-align: right; font-weight: bolder; font-size: 12px">--}%
%{--                    ${detalle?.precioUnitario}--}%
%{--                </td>--}%
%{--                <td style="width: 15%; text-align: center">--}%
%{--                    ${detalle?.procedencia == 'N' ? 'NACIONAL' : 'EXTRANJERO'}--}%
%{--                </td>--}%
%{--                <td style="width: 5%">--}%
%{--                    <g:if test="${proforma?.estado != 'R'}">--}%
%{--                        <a href="#" class="btn btn-danger btn-sm btnBorrarDetalleProforma" data-id="${detalle?.id}" title="Borrar"><i class="fa fa-trash"></i></a>--}%
%{--                    </g:if>--}%
%{--                </td>--}%
%{--            </tr>--}%
%{--        </g:each>--}%
%{--    </table>--}%
%{--</div>--}%



%{--<%@ page import="janus.utilitarios.reportesService" %>--}%
%{--<%--}%
%{--    def reportesServ = grailsApplication.classLoader.loadClass('janus.utilitarios.reportesService').newInstance()--}%
%{--%>--}%

%{--<g:if test="${flash.message}">--}%
%{--    <div class="span12" style="height: 35px;margin-bottom: 10px; margin-left: -25px">--}%
%{--        <div class="alert ${flash.clase ?: 'alert-info'}" role="status" style="text-align: center">--}%
%{--            <a class="close" data-dismiss="alert" href="#">×</a>--}%
%{--            ${flash.message}--}%
%{--        </div>--}%
%{--    </div>--}%
%{--</g:if>--}%

%{--<div class="row-fluid">--}%
%{--    <div class="span12">--}%
%{--        <b>Buscar Por:</b>--}%
%{--        <elm:select name="buscador" from = "${reportesServ.obrasPresupuestadas()}" value="${params.buscador}"--}%
%{--                    optionKey="campo" optionValue="nombre" optionClass="operador" id="buscador_con" style="width: 240px" />--}%
%{--        <b>Operación:</b>--}%
%{--        <span id="selOpt"></span>--}%
%{--        <b style="margin-left: 20px">Criterio: </b>--}%
%{--        <g:textField name="criterio" style="width: 160px; margin-right: 10px" value="${params.criterio ?: ''}" id="criterio_con"/>--}%
%{--        <a href="#" class="btn" id="buscar">--}%
%{--            <i class="icon-search"></i>--}%
%{--            Buscar--}%
%{--        </a>--}%
%{--        <a href="#" class="btn" id="imprimir" >--}%
%{--            <i class="icon-print"></i>--}%
%{--            Imprimir--}%
%{--        </a>--}%
%{--        <a href="#" class="btn" id="excel" >--}%
%{--            <i class="icon-print"></i>--}%
%{--            Excel--}%
%{--        </a>--}%
%{--    </div>--}%
%{--</div>--}%

%{--<div class="row-fluid"  style="width: 100%; height: 600px;overflow-y: auto; margin-top: -20px">--}%
%{--    <table class="table table-bordered table-striped table-condensed table-hover">--}%

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%">


    %{--            <thead>--}%
    %{--            <tr>--}%
    %{--                <th style="width: 80px;">--}%
    %{--                    Código--}%
    %{--                </th>--}%
    %{--                <th style="width: 250px;">--}%
    %{--                    Nombre--}%
    %{--                </th>--}%
    %{--                <th style="width: 120px;">--}%
    %{--                    Tipo--}%
    %{--                </th>--}%
    %{--                <th style="width: 80px">--}%
    %{--                    Fecha Reg--}%
    %{--                </th>--}%
    %{--                <th style="width: 250px">--}%
    %{--                    Cantón-Parroquia-Comunidad--}%
    %{--                </th>--}%
    %{--                <th style="width: 100px">--}%
    %{--                    Valor--}%
    %{--                </th>--}%
    %{--                <th style="width: 230px">--}%
    %{--                    Elaborado--}%
    %{--                </th>--}%
    %{--                <th style="width: 70px">--}%
    %{--                    Doc.Referencia--}%
    %{--                </th>--}%
    %{--                <th style="width: 100px">--}%
    %{--                    Estado--}%
    %{--                </th>--}%
    %{--            </tr>--}%
    %{--            </thead>--}%

        <g:each in="${obras}" var="obra" status="j">
            <tr class="obra_row" id="${obra.obra__id}">
                <td style="width: 10% !important;">${obra.obracdgo}</td>
                <td style="width: 25% !important;">${obra.obranmbr}</td>
                <td style="width: 13% !important;">${obra.tpobdscr}</td>
                <td style="width: 8% !important;"><g:formatDate date="${obra.obrafcha}" format="dd-MM-yyyy"/></td>
                <td style="width: 21% !important;">${obra.cntnnmbr} - ${obra.parrnmbr} - ${obra.cmndnmbr}</td>
                <td style="text-align: right; width: 9% !important;">${obra.obravlor}</td>
                <td style="width: 16% !important;">${obra.dptodscr}</td>
                <td style="width: 11% !important;">${obra.obrarefe}</td>
            %{--                                    <td style="width: 10% !important;">${obra.estado}</td>--}%
                <g:if test="${obras?.size() < 9}">
                    <td style="width: 9% !important;">${obra.estado}</td>
                    <td style="width: 1%"></td>
                </g:if>
                <g:else>
                    <td style="width: 10% !important;">${obra.estado}</td>
                </g:else>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    var checkeados = [];

    $("#buscar").click(function(){

        var datos = "si=${"si"}&buscador=" + $("#buscador_con").val() + "&criterio=" + $("#criterio_con").val() +
            "&operador=" + $("#oprd").val();
        var interval = loading("detalle");
        $.ajax({
            type : "POST",
            url : "${g.createLink(controller: 'reportes4',action:'tablaRegistradas')}",
            data     : datos,
            success  : function (msg) {
                clearInterval(interval);
                $("#detalle").html(msg);
            }
        });
    });


    $("#regresar").click(function () {
        location.href = "${g.createLink(controller: 'reportes', action: 'index')}"
    });

    $("#imprimir").click(function () {
        location.href = "${g.createLink(controller: 'reportes4', action:'reporteRegistradas' )}?buscador=" + $("#buscador_con").val() + "&criterio=" + $("#criterio_con").val() + "&operador=" + $("#oprd").val()
    });

    $("#excel").click(function () {
        location.href = "${g.createLink(controller: 'reportes4', action:'reporteRegistradasExcel' )}?buscador=" + $("#buscador_con").val() + "&criterio=" + $("#criterio_con").val() + "&operador=" + $("#oprd").val()
    });

    $("#buscador_con").change(function(){
        var anterior = "${params.operador}";
        var opciones = $(this).find("option:selected").attr("class").split(",");
        poneOperadores(opciones);
        /* regresa a la opción seleccionada */
        $("#oprd option[value=" + anterior + "]").prop('selected', true);
    });


    function poneOperadores (opcn) {
        var $sel = $("<select name='operador' id='oprd' style='width: 160px'}>");
        for(var i=0; i<opcn.length; i++) {
            var opt = opcn[i].split(":");
            var $opt = $("<option value='"+opt[0]+"'>"+opt[1]+"</option>");
            $sel.append($opt);
        }
        $("#selOpt").html($sel);
    };

    /* inicializa el select de oprd con la primea opción de busacdor */
    $( document ).ready(function() {
        $("#buscador_con").change();
    });


    $.contextMenu({
        selector: '.obra_row',
        callback: function (key, options) {
            var m = "clicked: " + $(this).attr("id");
            var idFila = $(this).attr("id")
            if(key == "registro"){
                location.href = "${g.createLink(controller: 'obra', action: 'registroObra')}" + "?obra=" + idFila;
            }

            if (key == "print") {
                var datos = "?obra="+idFila+"Wsub="+${-1}
                var url = "${g.createLink(controller: 'reportes3',action: 'imprimirTablaSub' )}" + datos
                location.href = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=" + url
            }

        },
        items: {
            "registro": {name: "Ir al Registro de esta Obra", icon:"info"},
            "print": {name: "Imprimir Subpresupuesto", icon: "print"
            }
        }

    });


</script>