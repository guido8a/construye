<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/09/21
  Time: 12:02
--%>

<g:select name="subpresupuestoOrg" from="${origen}" optionKey="id" optionValue="descripcion"
           style="width: 300px;font-size: 10px; margin-left: 5px" id="subPres_desc"/>

<script type="text/javascript">

    $("#subPres_desc").change(function(){
        var sub = $(this).val();
        cargarTablaOrigen($("#subPres_desc option:selected").val());
    });

</script>