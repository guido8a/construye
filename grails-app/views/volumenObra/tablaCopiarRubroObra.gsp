<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/09/21
  Time: 10:30
--%>

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
            <tr class="item_row" id="${val.item__id}" item="${val}" sub="${val.sbpr__id}" ord="${val.vlobordn}" cant="${val.vlobcntd}" data-vlob="${val.vlob__id}">

                <td style="width: 5%" class="sel"><g:checkBox class="chec" name="selec" checked="false" id="seleccionar1" value="${val.item__id}"/></td>
                <td style="width: 5%" class="orden">${val.vlobordn}</td>
                <td style="width: 20%" class="sub">${val.sbprdscr.trim()}</td>
                <td class="cdgo" style="width: 7%">${val.rbrocdgo.trim()}</td>
                <td class="nombre" style="width: 50%">${val.rbronmbr.trim()}</td>
                <td style="width: 5%;text-align: center" class="col_unidad">${val.unddcdgo.trim()}</td>
                <td style="text-align: right; width: 8%" class="cant">
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
        var selec = [];
        var tamano = 0;

        if(subPre == ""){
            cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "origen" + "</strong>", "Alerta");
        } else {
            if(subPresDest == ""){
                cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "destino" + "</strong>", "Alerta");
            }else{
                tbody.children("tr").each(function () {

                    var vlob = $(this).data("vlob");
                    selec.push(vlob);
                    tamano += 1;
                    $.ajax({
                        type : "POST",
                        async : false,
                        url : "${g.createLink(controller: 'volumenObra',action:'copiarRubro')}",
                        data     : {
                            selec: selec,
                            obra: '${obraActual?.id}',
                            destino: subPresDest,
                            tamano: tamano
                        },
                        success  : function (msg) {
                            var parts = msg.split("_");
                            $.box({
                                imageClass: "box_info",
                                text: "<strong>Copiados: </strong>" + parts[1] + "<br>" + "<strong>Existentes(No copiados): </strong>" + parts[2] + "<br>" + "<strong>Errores: </strong>" + parts[3],
                                title: "Alerta",
                                iconClose: false,
                                dialog: {
                                    resizable: false,
                                    draggable: false,
                                    width: 500,
                                    buttons: {
                                        "Aceptar": function () {
                                            // location.reload(true)
                                        }
                                    }
                                }
                            });
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
        var selec = [];
        var tamano = 0;

        if(subPre == ""){
            cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "origen" + "</strong>", "Alerta");
        } else {
            if(subPresDest == ""){
                cajaTexto("Seleccione el subpresupuesto de " +  "<strong>" + "destino" + "</strong>", "Alerta");
            }else{

                tbody.children("tr").each(function () {
                    if(($(this).children("td").children().get(1).checked) == true){
                        var vlob = $(this).data("vlob");
                        selec.push(vlob);
                        tamano += 1;
                    } else {
                    }
                });

                if(tamano == 0){
                    cajaTexto("Seleccione al menos un rubro", "Alerta");
                }else{
                    $.ajax({
                        type : "POST",
                        async : false,
                        url : "${g.createLink(controller: 'volumenObra',action:'copiarRubro')}",
                        data     : {
                            selec: selec,
                            obra: '${obraActual?.id}',
                            destino: subPresDest,
                            tamano: tamano
                        },
                        success  : function (msg) {
                            var parts = msg.split("_");
                            $.box({
                                imageClass: "box_info",
                                text: "<strong>Copiados: </strong>" + parts[1] + "<br>" + "<strong>Existentes(No copiados): </strong>" + parts[2] + "<br>" + "<strong>Errores: </strong>" + parts[3],
                                title: "Alerta",
                                iconClose: false,
                                dialog: {
                                    resizable: false,
                                    draggable: false,
                                    width: 500,
                                    buttons: {
                                        "Aceptar": function () {
                                            // location.reload(true)
                                        }
                                    }
                                }
                            });
                        }
                    });
                }
           }
        }
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