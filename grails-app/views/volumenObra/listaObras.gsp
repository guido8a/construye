<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/09/21
  Time: 11:16
--%>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>

    <th>Código</th>
    <th>Descripción</th>
    <th>Seleccionar</th>
    </thead>

    <tbody>

    <g:each in="${data}" var="dt" status="i">
        <tr>
            <td style="width: 10%">${dt.obracdgo}</td>
            <td style="width: 82%">${dt.obranmbr}</td>
            <td style="width: 8%"><div style="text-align: center" class="seleccionaObra" id="reg_${i}"
                                       regId="${dt?.obra__id}" regNmbr="${dt?.obranmbr}" regCdgo="${dt?.obracdgo}">
                <button class="btn btn-small btn-success"><i class="icon-check"></i></button>
            </div></td>

        </tr>

    </g:each>
    </tbody>

</table>

<script type="text/javascript">

    $(".seleccionaObra").click(function () {
        $("#obra__id").val($(this).attr("regId"));
        $("#input_codigo").val($(this).attr("regCdgo"));
        $("#obradscr").val($(this).attr("regNmbr"));
        $("#buscarObra").dialog("close");
         $("#divSubpresupuestos").removeClass("hidden");
         $("#tabla").removeClass("hidden");
        cargarOrigen($(this).attr("regId"));
    });

    function cargarOrigen(obra){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'volumenObra', action: 'subOrigen_ajax')}',
            data:{
                obra: obra
            },
            success: function(msg){
                $("#divOrigen").html(msg);
                cargarTablaOrigen($("#subPres_desc option:selected").val());
            }
        })
    }

    function cargarTablaOrigen(subpresupuesto){
        $.ajax({
            type : "POST",
            url : "${g.createLink(controller: 'volumenObra',action:'tablaCopiarRubroObra')}",
            async: true,
            data     : {
                sub: subpresupuesto,
                obra: $("#obra__id").val(),
                obraActual: '${obra?.id}'
            },
            success  : function (msg) {
                $("#detalle").html(msg)
            }
        });
    }


</script>

