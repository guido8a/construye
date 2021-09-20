
<g:if test="${flash.message}">
    <div class="span12" style="height: 35px;margin-bottom: 10px; margin-left: -25px">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status" style="text-align: center">
            <a class="close" data-dismiss="alert" href="#">×</a>
            ${flash.message}
        </div>
    </div>
</g:if>

<div class="row-fluid"  style="width: 99.7%;height: 400px;overflow-y: auto;float: right; margin-top: -20px">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <tbody id="tabla_material">
        <g:each in="${valores}" var="val" status="">
            <tr class="item_row" id="${val.item__id}" item="${val}" sub="${val.sbpr__id}" ord="${val.vlobordn}" cant="${val.vlobcntd}">

                <td style="width: 10px" class="sel"><g:checkBox class="chec" name="selec" checked="false" id="seleccionar1" value="${val.item__id}"/></td>
                %{--<td style="width: 10px" class="sel"><input type="checkbox" id="seleccionar1" class="chec" checked="false" value="${val.item__id}"></td>--}%
                <td style="width: 20px" class="orden">${val.vlobordn}</td>
                <td style="width: 200px" class="sub">${val.sbprdscr.trim()}</td>
                <td class="cdgo">${val.rbrocdgo.trim()}</td>
                <td class="nombre">${val.rbronmbr.trim()}</td>
                <td style="width: 60px !important;text-align: center" class="col_unidad">${val.unddcdgo.trim()}</td>
                <td style="text-align: right" class="cant">
                    <g:formatNumber number="${val.vlobcntd}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                </td>
                <td class="col_precio" style="display: none;text-align: right" id="i_${val.item__id}"><g:formatNumber number="${val.pcun}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/></td>
                <td class="col_total total" style="display: none;text-align: right"><g:formatNumber number="${val.totl}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    var checkeados = [];

    $("#copiar_todos").click(function () {
        var tbody = $("#tabla_material");
        var datos
        var subPresDest = $("#subPres_destino").val();
        var subPre = $("#subPres_desc").val();

        if(subPre == ""){
            cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "origen" + "</strong>", "Alerta");
          } else {
            if(subPresDest == ""){
                cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "destino" + "</strong>", "Alerta");
            }else{
                tbody.children("tr").each(function () {
                    var trId = $(this).attr("id");
                    datos ="rubro=" + trId + "&subDest=" + subPresDest + "&obra=" + ${obra.id} + "&sub=" + subPre;
                    $.ajax({
                        type : "POST",
                        url : "${g.createLink(controller: 'volumenObra',action:'copiarItem')}",
                        data     : datos,
                        success  : function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                $.box({
                                    imageClass: "box_info",
                                    text: "Rubros copiados correctamente",
                                    title: "Alerta",
                                    iconClose: false,
                                    dialog: {
                                        resizable: false,
                                        draggable: false,
                                        width: 350,
                                        buttons: {
                                            "Aceptar": function () {
                                                location.reload(true)
                                            }
                                        }
                                    }
                                });
                            }else{
                                if(parts[0] == 'er'){
                                    $.box({
                                        imageClass: "box_info",
                                        text: parts[1],
                                        title: "Alerta",
                                        iconClose: false,
                                        dialog: {
                                            resizable: false,
                                            draggable: false,
                                            width: 350,
                                            buttons: {
                                                "Aceptar": function () {
                                                    location.reload(true)
                                                }
                                            }
                                        }
                                    });
                                }else{
                                    cajaTexto(parts[1], "Error")
                                }
                            }
                        }
                    });
                });
            }
        }
    });

    $("#copiar_sel").click(function () {
        var tbody = $("#tabla_material");
        var datos
        var subPresDest = $("#subPres_destino").val();
        var subPre = $("#subPres_desc").val();
        var rbros = [];

        if(subPre == ""){
            cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "origen" + "</strong>", "Alerta");
        } else {
            if(subPresDest == ""){
                cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "destino" + "</strong>", "Alerta");
            }else{
                tbody.children("tr").each(function () {
                    if(($(this).children("td").children().get(1).checked) == true){
                        var selec = [];

                        var trId = $(this).attr("id");
                        var ord = $(this).attr("ord");
                        var canti = $(this).attr("cant");

                        datos ="&rubro=" + trId + "&subDest=" + subPresDest + "&obra=" + ${obra.id} + "&sub=" + subPre + "&orden=" + ord + "&canti=" + canti;

                        $.ajax({
                            type : "POST",
                            async : false,
                            url : "${g.createLink(controller: 'volumenObra',action:'copiarItem')}",
                            data     : datos,
                            success  : function (msg) {
                                var parts = msg.split("_");
                                if(parts[0] == 'ok'){
                                    $.box({
                                        imageClass: "box_info",
                                        text: "Rubros copiados correctamente",
                                        title: "Alerta",
                                        iconClose: false,
                                        dialog: {
                                            resizable: false,
                                            draggable: false,
                                            width: 350,
                                            buttons: {
                                                "Aceptar": function () {
                                                    location.reload(true)
                                                }
                                            }
                                        }
                                    });
                                }else{
                                    if(parts[0] == 'er'){
                                        $.box({
                                            imageClass: "box_info",
                                            text: parts[1],
                                            title: "Alerta",
                                            iconClose: false,
                                            dialog: {
                                                resizable: false,
                                                draggable: false,
                                                width: 350,
                                                buttons: {
                                                    "Aceptar": function () {
                                                        location.reload(true)
                                                    }
                                                }
                                            }
                                        });
                                    }else{
                                        cajaTexto(parts[1], "Error")
                                    }
                                }
                            }
                        });
                    } else {
                    }
                });
            }
        }
    });

    $("#regresar").click(function () {
        location.href = "${g.createLink(controller: 'volumenObra', action: 'volObra', id: obra?.id)}"
    });

    function cajaTexto(texto, titulo){
      return  $.box({
            imageClass: "box_info",
            text: texto,
            title: titulo,
            iconClose: false,
            dialog: {
                resizable: false,
                draggable: false,
                width: 350,
                buttons: {
                    "Aceptar": function () {
                    }
                }
            }
        });
    }

</script>