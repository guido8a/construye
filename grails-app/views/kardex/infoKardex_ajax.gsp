<div class="row-fluid">

    <span class="span12 breadcrumb">
        <span class="span2">
            ${item?.codigo}
        </span>

        <span class="span8">
            ${item?.nombre}
        </span>
    </span>

    <div id="divTablaKardex">
    </div>

</div>

<script type="text/javascript">
    cargarTablaKardex();

    function cargarTablaKardex() {
        var id = '${item?.id}';
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'kardex', action:'tablaKardex_ajax')}",
            data: {
                id:id
            },
            success: function (msg) {
                $("#divTablaKardex").html(msg);
            }
        });
    }
</script>
