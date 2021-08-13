<%@ page import="janus.pac.Concurso" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Proceso
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.ui.position.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.js')}" type="text/javascript"></script>
    <link href="${resource(dir: 'js/jquery/plugins/jQuery-contextMenu-gh-pages/src', file: 'jquery.contextMenu.css')}" rel="stylesheet" type="text/css"/>
    <style>
    td {
        line-height : 12px !important;
    }

    .largo{
        width: 250px;
    }

    .casillas{
        text-align: left !important;
        width: 150px !important;
    }


    </style>
</head>

<body>
<div class="span12 btn-group" role="navigation" style="margin-bottom: 10px;">
    <div class="row">
        <div class="span9 btn-group" role="navigation">
            <g:link controller="concurso" action="list" class="btn">
                <i class="icon-arrow-left"></i> Proceso
            </g:link>
        </div>
    </div>
</div>

<div id="show-concurso" class="span12" role="main">
    <form class="form-horizontal">
        <g:if test="${concursoInstance?.obra}">
            <div class="control-group">
                <div>
                    <span id="obra-label" class="control-label label label-inverse casillas">
                        Obra
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="obra-label">
                        ${concursoInstance?.obra?.descripcion}
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.administracion}">
            <div class="control-group">
                <div>
                    <span id="administracion-label" class="control-label label label-inverse casillas">
                        Administración
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="administracion-label">
                        ${concursoInstance?.administracion?.descripcion}
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.pac}">
            <div class="control-group">
                <div>
                    <span id="pac-label" class="control-label label label-inverse casillas">
                        Pac
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="pac-label">
                        ${concursoInstance?.pac?.descripcion}
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.codigo}">
            <div class="control-group">
                <div>
                    <span id="codigo-label" class="control-label label label-inverse casillas">
                        Código
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="codigo-label">
                        <g:fieldValue bean="${concursoInstance}" field="codigo"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.objeto}">
            <div class="control-group">
                <div>
                    <span id="objeto-label" class="control-label label label-inverse casillas">
                        Objeto
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="objeto-label">
                        <g:fieldValue bean="${concursoInstance}" field="objeto"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.costoBases}">
            <div class="control-group">
                <div>
                    <span id="costoBases-label" class="control-label label label-inverse casillas">
                        Costo Bases
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="costoBases-label">
                        <g:fieldValue bean="${concursoInstance}" field="costoBases"/>
                    </span>

                </div>
            </div>
        </g:if>
        <g:if test="${concursoInstance?.fechaInicio}">
            <div class="control-group">
                <div>
                    <span id="fechaInicio-label" class="control-label label label-inverse casillas">
                        Fecha Inicio
                    </span>
                </div>

                <div class="controls">
                    <span aria-labelledby="fechaInicio-label">
                        <g:formatDate date="${concursoInstance?.fechaInicio}"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaPublicacion}">
            <div class="control-group">
                <div>
                    <span id="fechaPublicacion-label" class="control-label label label-inverse casillas">
                        Fecha Publicación
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="fechaPublicacion-label">
                        <g:formatDate date="${concursoInstance?.fechaPublicacion}"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaLimitePreguntas}">
            <div class="control-group">
                <div>
                    <span id="fechaLimitePreguntas-label" class="control-label label label-inverse casillas" >
                        Fecha Límite <br/>Preguntas
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="fechaLimitePreguntas-label">
                        <g:formatDate date="${concursoInstance?.fechaLimitePreguntas}" format="dd-MM-yyyy"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaLimiteRespuestas}">
            <div class="control-group">
                <div>
                    <span id="fechaLimiteRespuestas-label" class="control-label label label-inverse casillas">
                        Fecha Límite <br/>Respuestas
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="fechaLimiteRespuestas-label">
                        <g:formatDate date="${concursoInstance?.fechaLimiteRespuestas}" format="dd-MM-yyyy"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaLimiteEntregaOfertas}">
            <div class="control-group">
                <div>
                    <span id="fechaLimiteEntregaOfertas-label" class="control-label label label-inverse casillas">
                        Fecha Límite Entrega <br/>Ofertas
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaLimiteEntregaOfertas-label">
                        <g:formatDate date="${concursoInstance?.fechaLimiteEntregaOfertas}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaLimiteSolicitarConvalidacion}">
            <div class="control-group">
                <div>
                    <span id="fechaLimiteSolicitarConvalidacion-label" class="control-label label label-inverse casillas" >
                        Fecha Límite Solicitar <br/>Convalidación
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaLimiteSolicitarConvalidacion-label">
                        <g:formatDate date="${concursoInstance?.fechaLimiteSolicitarConvalidacion}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaLimiteRespuestaConvalidacion}">
            <div class="control-group">
                <div>
                    <span id="fechaLimiteRespuestaConvalidacion-label" class="control-label label label-inverse casillas">
                        Fecha Límite Respuesta <br/>Convalidación
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaLimiteRespuestaConvalidacion-label">
                        <g:formatDate date="${concursoInstance?.fechaLimiteRespuestaConvalidacion}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaCalificacion}">
            <div class="control-group">
                <div>
                    <span id="fechaCalificacion-label" class="control-label label label-inverse casillas">
                        Fecha Calificación
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaCalificacion-label">
                        <g:formatDate date="${concursoInstance?.fechaCalificacion}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaInicioPuja}">
            <div class="control-group">
                <div>
                    <span id="fechaInicioPuja-label" class="control-label label label-inverse casillas">
                        Fecha Inicio Puja
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaInicioPuja-label">
                        <g:formatDate date="${concursoInstance?.fechaInicioPuja}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaFinPuja}">
            <div class="control-group">
                <div>
                    <span id="fechaFinPuja-label" class="control-label label label-inverse casillas">
                        Fecha Fin Puja
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaFinPuja-label">
                        <g:formatDate date="${concursoInstance?.fechaFinPuja}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.fechaAdjudicacion}">
            <div class="control-group">
                <div>
                    <span id="fechaAdjudicacion-label" class="control-label label label-inverse casillas">
                        Fecha Adjudicación
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="fechaAdjudicacion-label">
                        <g:formatDate date="${concursoInstance?.fechaAdjudicacion}" format="dd-MM-yyyy"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.estado}">
            <div class="control-group">
                <div>
                    <span id="estado-label" class="control-label label label-inverse casillas">
                        Estado
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="estado-label">
                        <g:fieldValue bean="${concursoInstance}" field="estado"/>
                    </span>
                </div>
            </div>
        </g:if>

        <g:if test="${concursoInstance?.observaciones}">
            <div class="control-group">
                <div>
                    <span id="observaciones-label" class="control-label label label-inverse casillas">
                        Observaciones
                    </span>
                </div>
                <div class="controls">
                    <span aria-labelledby="observaciones-label">
                        <g:fieldValue bean="${concursoInstance}" field="observaciones"/>
                    </span>
                </div>
            </div>
        </g:if>

    </form>
</div>
</body>

</html>