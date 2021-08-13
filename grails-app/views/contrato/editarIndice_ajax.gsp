<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/20
  Time: 12:56
--%>

<div class="row">
    <div class="span2">
        Índice
    </div>
    <div class="3">
        <g:select name="indice" from="${indices}" optionKey="${{it.id}}"
                  optionValue="${{it.codigo + ' - ' + it.descripcion }}" value="${indiceActual.indice.id}" style="width:440px;"/>
    </div>
</div>

<div class="row">
    <div class="span2">
        Valor
    </div>
    <div class="3">
        <g:textField name="valor" value="${indiceActual?.valor ?: 0}" class="form-control number"/>
    </div>
</div>