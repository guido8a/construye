<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/21
  Time: 10:28
--%>

<g:select name="requisicion_name" id="requisicion" from="${requisiciones}" value="${consumo?.id ? consumo.padre.id : ''}"  class="span12 req" optionKey="id" optionValue="${{"N° " + it.id + " - Recibe: " +  it.recibe.nombre + " " + it.recibe.apellido}}" />

<script type="text/javascript">

    cargarBodega($(".req").val());

    function cargarBodega(id){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'consumo', action: 'bodega_ajax')}',
            data:{
                id:id
            },
            success: function (msg) {
                $("#divBodega").html(msg)
            }
        })
    }

    $(".req").change(function () {
        var idReq = $(this).val();
        cargarBodega(idReq)
    });


</script>