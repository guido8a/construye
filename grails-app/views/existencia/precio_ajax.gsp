<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/11/21
  Time: 10:31
--%>
<g:hiddenField name="idKardex" value="${kardex?.id}"/>

<div class="span1">
    <label>Precio Unitario: </label>
</div>
<div class="span4">
    <g:textField name="precioNuevo"  title="Precio unitario del item"
                 value="${g.formatNumber(number: kardex?.precioUnitario, maxFractionDigits: 4, minFractionDigits: 4,
                         format: '##,##0', locale: 'ec')}"/>
</div>


<script type="text/javascript">

    function validarNumDec(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }

    $("#precioNuevo").keydown(function (ev) {
        return validarNumDec(ev)
    });
</script>