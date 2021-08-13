
<%@ page import="construye.TipoConsumo" %>

<g:if test="${!tipoConsumoInstance}">
    <elm:notFound elem="TipoConsumo" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        
        <g:if test="${tipoConsumoInstance?.codigo}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Codigo
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${tipoConsumoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${tipoConsumoInstance?.descripcion}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${tipoConsumoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
        
    </div>
</g:else>