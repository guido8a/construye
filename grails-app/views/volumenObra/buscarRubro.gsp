
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Agregar Rubros
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 1px">
    <div class="span2 btn-group" role="navigation">
        <a href="#" class="btn btn-primary" id="btnRegresar">
            <i class="fa fa-arrow-left"></i>
            Regresar
        </a>
    </div>

    <div class="span10 breadcrumb" style="font-weight: bold; font-size: 16px">
        Obra: ${" (" + obra.codigo + ") - " + obra.nombre}
    </div>
</div>

<div id="busqueda" style="overflow: hidden">
%{--    <fieldset class="borde" style="border-radius: 4px">--}%

        <div class="row-fluid">
%{--            <div class="span12">--}%
                <div class="span2"> <label> Subpresupuesto en el cual se ingresará el rubro:</label> </div>
%{--                <div class="span6">--}%
                    <span class="span5">
                        <g:hiddenField name="subpresupuestoBusqueda" value="" />
                        <g:textField name="subPresupuestoName" readonly="" class="form-control span12" value=""/>
                    </span>
                    <span class="span2">
                        <a href="#" class="btn btn-info" id="btnBuscarSubPresupuesto" title="Buscar subpresupuesto">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </span>
%{--                </div>--}%

%{--                <div class="span1"> <label> Tipo Contrato</label> </div>--}%
%{--                <div class="span2">--}%
%{--                    <g:select name="tipoRubroName" id="tipoRubro" class="form-control btn-success" from="${['N': 'Normal', 'C':  'Complementario']}"--}%
%{--                              optionKey="key" optionValue="value" />--}%
%{--                </div>--}%

%{--            </div>--}%
        </div>

        <div class="row-fluid" style="margin-top: 20px !important;">
%{--            <div class="span12">--}%
%{--                <div class="span7">--}%
                    <div class="span1"> <label> Buscar Por </label> </div>
                    <div class="span2">
                        <g:select name="buscarPor" class="span12 buscarPor form-control" from="${[1: 'Nombre', 2: 'Código']}"
                                  optionKey="key" optionValue="value"/>
                    </div>
                    <div class="span1"> <label> Criterio </label> </div>
                    <div class="span3">
                        <g:textField name="criterio" class="span12 criterio form-control"/>
                    </div>
                    <div class="span1"> <label> Ordenado por </label> </div>
                    <div class="span2">
                        <g:select name="ordenar" class="span12 ordenar form-control" from="${[1: 'Nombre', 2: 'Código']}"  optionKey="key"
                                  optionValue="value"/>
                    </div>
                    <div class="span2 btn-group">
                        <button class="btn btn-info" id="btnBuscar"><i class="fa fa-search"></i></button>
                        <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda">
                            <i class="fa fa-eraser"></i></button>
                    </div>
%{--                </div>--}%

%{--            </div>--}%

        </div>
%{--    </fieldset>--}%

%{--    <fieldset class="borde span12">--}%
        <div class="span6" id="divTabla">
        </div>

        <div class="span5">

            <div class="alert alert-info" style="margin-top: 10px; text-align: center">
                <i class="fa fa-list"></i> <strong style="font-size: 16px"> Rubros en volúmenes de obra</strong>
            </div>

%{--            <div class="row-fluid">--}%
%{--                <div class="span12">--}%
                    <div class="span3"> <label> Ver rubros del Subpresupuesto </label> </div>
                    <div class="span9" id="divSubpresupuestoSeleccionado">

                    </div>
%{--                </div>--}%
%{--            </div>--}%

            <div class="span5" id="divTablaSeleccionados" >

            </div>
        </div>

%{--    </fieldset>--}%
</div>

<script type="text/javascript">
    var di, bcsb2;

    $("#btnBuscarSubPresupuesto").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'volumenObra', action:'buscarSubpresupuestoRubro_ajax')}",
            data    : {
                tipo: 1
            },
            success : function (msg) {
                bcsb2 = bootbox.dialog({
                    id      : "dlgBuscarSubPresupuesto",
                    title   : "Buscar subpresupuesto",
                    className: 'large',
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarBuscardorSubpre2() {
        bcsb2.modal("hide");
    }

    $("#btnRegresar").click(function () {
        location.href="${createLink(controller: 'volumenObra', action: 'volObra')}/${obra?.id}"
    });

    cargarSubpresupuestoBusqueda();

    function cargarSubpresupuestoBusqueda (){
        var tipo = $("#tipo option:selected").val();
        $.ajax({
            type    : "POST",
            url : "${g.createLink(controller: 'volumenObra',action:'subpresupuestos_ajax')}",
            data    : {
                id: tipo,
                obra: '${obra?.id}'
            },
            success : function (msg) {
                $("#divSubpresupuesto").html(msg)
            }
        });
    }

    $("#tipo").change(function () {
        cargarSubpresupuestoBusqueda();
    });

    $("#btnBuscar").click(function () {
        cargarTablaBusqueda();
    });

    $("#btnLimpiar").click(function  () {
        $("#buscarPor").val(1);
        $("#criterio").val('');
        $("#ordenar").val(1);
        cargarTablaBusqueda();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaBusqueda();
            return false;
        }
        return true;
    });

    cargarTablaBusqueda();
    cargarTablaSeleccionados();

    function cargarTablaBusqueda() {
        // var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $(".criterio").val();
        var ordenar = $("#ordenar option:selected").val();
        var tipoRubro = $("#tipoRubro option:selected").val();

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'tablaBusqueda_ajax')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                obra: '${obra?.id}',
                tipoRubro: tipoRubro
            },
            success: function (msg) {
                // d.modal("hide");
                $("#divTabla").html(msg);
            }
        });
    }

    function cargarTablaSeleccionados() {
        // var d = cargarLoader("Cargando...");
        var subpresupuesto = $("#subpresupuestoSeleccionado option:selected").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'tablaSeleccionados_ajax')}",
            data: {
                subpresupuesto: subpresupuesto,
                obra: '${obra?.id}'
            },
            success: function (msg) {
                // d.modal("hide");
                $("#divTablaSeleccionados").html(msg);
            }
        });
    }

    $("#subpresupuestoSeleccionado").change(function () {
        cargarTablaSeleccionados();
    });

    cargarSubpresuspuestosObra();

    function cargarSubpresuspuestosObra(seleccionado){
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'subpresupuestosObra_ajax')}",
            data: {
                obra: '${obra?.id}',
                seleccionado: seleccionado
            },
            success: function (msg) {
                $("#divSubpresupuestoSeleccionado").html(msg);
            }
        });
    }


</script>

</body>
</html>