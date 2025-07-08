<div id="listaRbro" style="overflow: hidden">
    %{--    <fieldset class="borde" style="border-radius: 4px">--}%
    <div class="row-fluid" style="margin-left: 10px">
        <span class="span12">
            <label class="span1 control-label text-info">
                Tipo
            </label>
            <span class="span3">
                <g:select name="buscadorPor" class="span12 form-control" from="${grupos}" optionKey="id" optionValue="descripcion"/>
            </span>
            <label class="span1 control-label text-info">
                Criterio
            </label>
            <span class="span4">
                <g:textField name="span12 buscadorCriterio" id="buscadorCriterio" class="form-control"/>
            </span>
            <span class="span1" style="margin-top: 1px; ">
                <button class="btn btn-info" id="btnBuscadorSubpre"><i class="fa fa-search"></i></button>
            </span>
        </span>
    </div>
    %{--    </fieldset>--}%

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaBuscadorSub" style="height: 350px; overflow: auto; margin-top: 5px">
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#buscadorPor").change(function () {
        buscadorSubpre();
    });

    buscadorSubpre();

    $("#btnBuscadorSubpre").click(function () {
        buscadorSubpre();
    });

    function buscadorSubpre() {
        var buscarPor = $("#buscadorPor option:selected").val();
        var criterio = $("#buscadorCriterio").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'volumenObra', action:'tablaBuscadorSub_ajax')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                tipo: '${tipo}'
            },
            success: function (msg) {
                $("#divTablaBuscadorSub").html(msg);
            }
        });
    }

    $("#buscadorCriterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            ev.preventDefault();
            buscadorSubpre();
            return false;
        }
    });

</script>