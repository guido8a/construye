
<%@ page import="janus.construye.Bodega" %>

<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        
        <g:if test="${bodegaInstance?.nombre}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Nombre
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${bodegaInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${bodegaInstance?.descripcion}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${bodegaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${bodegaInstance?.direccion}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Direccion
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${bodegaInstance}" field="direccion"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${bodegaInstance?.telefono}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Telefono
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${bodegaInstance}" field="telefono"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${bodegaInstance?.tipo}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Tipo
                </div>
                
                <div class="col-md-4">
                    <g:fieldValue bean="${bodegaInstance}" field="tipo"/>
                </div>
                
            </div>
        </g:if>
        
        <g:if test="${bodegaInstance?.empresa}">
            <div class="row">
                <div class="col-md-3 show-label">
                    Empresa
                </div>
                
                <div class="col-md-4">
                    ${bodegaInstance?.empresa?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
        
    </div>
</g:else>