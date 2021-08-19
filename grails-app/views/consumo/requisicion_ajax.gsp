<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/21
  Time: 10:28
--%>

<g:select name="requisicion_name" id="requisicion" from="${requisiciones}" value="${consumo?.id ? consumo.padre.id : ''}"
          class="span12 req" optionKey="id" optionValue="${{"N° " + it.id + " - Recibe: " +  it.recibe.nombre + " " + it.recibe.apellido}}" disabled="${items.size() > 0 ? true : false}" />

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
        <g:if test="${consumo?.id}">
        <g:if test="${consumo?.estado != 'A'}">
        guardarRequisicion(idReq);
        </g:if>
        </g:if>
        <g:else>
        cargarBodega(idReq);
        </g:else>
    });

    function guardarRequisicion(id){
        $("#dlgLoad").dialog("open");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'consumo', action: 'guardarRequisicion_ajax')}',
            data: {
                id: '${consumo?.id}',
                req: id
            },
            success: function (msg) {
                $("#dlgLoad").dialog("close");
                var parts = msg.split("_")
                if (parts[0] == 'ok') {
                    location.href = "${createLink(controller: 'consumo', action: 'devolucion')}/" + '${consumo?.id}'
                } else {
                    $.box({
                        imageClass: "box_info",
                        text: "Error al guardar la requisición",
                        title: "Error",
                        iconClose: false,
                        dialog: {
                            resizable: false,
                            draggable: false,
                            buttons: {
                                "Aceptar": function () {
                                }
                            }
                        }
                    });
                }
            }
        });
    }


</script>