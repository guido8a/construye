

<div id="show-empresa" class="span5" role="main">

    <form class="form-horizontal">


        <g:if test="${empresaInstance?.ruc}">
            <div class="control-group">
                <div>
                    <span id="ruc-label" class="control-label label label-inverse">
                        RUC
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="ruc-label">
                        <g:fieldValue bean="${empresaInstance}" field="ruc"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${empresaInstance?.nombre}">
            <div class="control-group">
                <div>
                    <span id="nombre-label" class="control-label label label-inverse">
                        Nombre
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="nombre-label">
                        <g:fieldValue bean="${empresaInstance}" field="nombre"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${empresaInstance?.descripcion}">
            <div class="control-group">
                <div>
                    <span id="descripcion-label" class="control-label label label-inverse">
                        Descripción
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="descripcion-label">
                        <g:fieldValue bean="${empresaInstance}" field="descripcion"/>
                    </span>

                </div>
            </div>
        </g:if>


        <g:if test="${empresaInstance?.direccion}">
            <div class="control-group">
                <div>
                    <span id="direccion-label" class="control-label label label-inverse">
                        Dirección
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="direccion-label">
                        <g:fieldValue bean="${empresaInstance}" field="direccion"/>
                    </span>

                </div>
            </div>
        </g:if>


        <g:if test="${empresaInstance?.email}">
            <div class="control-group">
                <div>
                    <span id="email-label" class="control-label label label-inverse">
                        Email
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="email-label">
                        <g:fieldValue bean="${empresaInstance}" field="email"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${empresaInstance?.telefono}">
            <div class="control-group">
                <div>
                    <span id="telefono-label" class="control-label label label-inverse">
                        Teléfono
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="telefono-label">
                        <g:fieldValue bean="${empresaInstance}" field="telefono"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${empresaInstance?.lugar}">
            <div class="control-group">
                <div>
                    <span id="ciudad-label" class="control-label label label-inverse">
                        Ciudad
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="ciudad-label">
                        <g:fieldValue bean="${empresaInstance}" field="lugar"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${empresaInstance?.observaciones}">
            <div class="control-group">
                <div>
                    <span id="observaciones-label" class="control-label label label-inverse">
                        Observaciones
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="observaciones-label">
                        <g:fieldValue bean="${empresaInstance}" field="observaciones"/>
                    </span>
                </div>
            </div>
        </g:if>

    </form>
</div>
