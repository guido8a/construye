<div id="listaRbro" style="overflow: hidden">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="span12 grupo">
                <label class="span1 control-label text-info">
                    Buscar por
                </label>
                <span class="span3">
                    <g:select name="buscarPorRubros" class="span12 buscarPorRubros form-control" from="${[1: 'Nombre', 2: 'Código']}"
                              optionKey="key" optionValue="value"/>
                </span>
                <label class="span1 control-label text-info">
                    Criterio
                </label>
                <span class="span3">
                    <g:textField name="buscadorCriterioRubros" id="buscadorCriterioRubros" class="span12 form-control"/>
                </span>
                <span class="span1" style="margin-top: 1px">
                    <button class="btn btn-info" id="btnBuscadorRubros"><i class="fa fa-search"></i></button>
                </span>
            </span>
          </div>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaRubrosEditar" style="height: 350px; overflow: auto; margin-top: 5px">
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#buscarPorRubros").change(function () {
        buscadorRubrosEditar();
    });

    buscadorRubrosEditar();

    $("#btnBuscadorRubros").click(function () {
        buscadorRubrosEditar();
    });

    function buscadorRubrosEditar() {
        var buscarPor = $("#buscarPorRubros option:selected").val();
        var criterio = $("#buscadorCriterioRubros").val();
        var tipoRubro = $("#tipoRubro option:selected").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'tablaBuscadorRubroEditar_ajax')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                tipoRubro: tipoRubro
            },
            success: function (msg) {
                $("#divTablaRubrosEditar").html(msg);
            }
        });
    }

    $("#buscadorCriterioRubros").keydown(function (ev) {
        if (ev.keyCode === 13) {
            ev.preventDefault();
            buscadorRubrosEditar();
            return false;
        }
    });

</script>