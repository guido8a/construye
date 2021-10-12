<%@ page import="janus.TipoLista; janus.Grupo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Rubros
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/', file: 'jquery.livequery.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet">
</head>

<body>

<div class="span12">
    <g:if test="${flash.message}">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            <elm:poneHtml textoHtml="${flash.message}"/>
        </div>
    </g:if>
</div>

<div class="span12 btn-group" role="navigation">
    <a href="#" class="btn  " id="btn_lista">
        <i class="icon-list-ul"></i>
        Lista
    </a>
    <a href="${g.createLink(action: 'rubroPrincipal')}" class="btn btn-ajax btn-new">
        <i class="icon-file-alt"></i>
        Nuevo
    </a>
    <g:if test="${rubro?.aprobado != 'R'}">
        <a href="#" class="btn btn-ajax btn-new btn-primary" id="guardar">
            <i class="icon-save"></i>
            Guardar
        </a>
        <a href="#" class="btn btn-ajax btn-new" id="borrar">
            <i class="icon-trash"></i>
            Borrar
        </a>
    </g:if>
    <a href="${g.createLink(action: 'rubroPrincipal')}" class="btn btn-ajax btn-new">
        <i class="icon-remove"></i>
        Cancelar
    </a>

    <a href="#" class="btn btn-ajax btn-new" id="calcular" title="Calcular precios">
        <i class="icon-table"></i>
        Calcular
    </a>
    <a href="#" class="btn btn-ajax btn-new" id="transporte" title="Transporte">
        <i class="icon-truck"></i>
        Transporte
    </a>
    <g:if test="${rubro}">
        <a href="#" class="btn btn-ajax btn-new" id="imprimir" title="Imprimir">
            <i class="icon-print"></i>
            Imprimir
        </a>
    </g:if>
    <g:if test="${rubro}">
        <a href="#" class="btn btn-ajax btn-new" id="excel" title="Imprimir">
            <i class="icon-print"></i>
            Excel
        </a>
    </g:if>

    <g:if test="${rubro}">
        <g:if test="${rubro?.codigoEspecificacion}">
            <a href="#" id="detalle" class="btn btn-ajax btn-new">
                <i class="icon-list"></i>
                Especifi.
            </a>
        </g:if>
    </g:if>
    <g:if test="${rubro}">
        <a href="#" id="foto" class="btn btn-ajax btn-new">
            <i class="icon-picture"></i>
            Ilust.
        </a>
    </g:if>
    <g:if test="${session.perfil.codigo == 'APRB' && rubro?.aprobado == null && rubro?.id}">
        <a href="#" class="btn btn-ajax btn-new btn-success" id="btnRegistrar" title="Aprobar el rubro">
            <i class="icon-check"></i>
            Aprobar
        </a>
    </g:if>
    <g:if test="${session.perfil.codigo == 'APRB' && rubro?.aprobado == 'R'}">
        <a href="#" class="btn btn-ajax btn-new btn-warning" id="btnQuitarRegistro" title="Quitar el aprobado del rubro">
            <i class="icon-check"></i>
            Desaprobar
        </a>
    </g:if>
</div>

<div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: -10px">

    <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;">
        <g:form name="frmRubro" action="save" style="height: 100px;">
            <input type="hidden" id="rubro__id" name="rubro.id" value="${rubro?.id}">

            <p class="css-vertical-text">Rubro</p>

            <div class="linea" style="height: 100px;"></div>

            <div class="row-fluid">

                <div class="span2" style="width: 150px;">
                    Código
                %{--<input type="text" name="rubro.codigo" class="span20 allCaps required input-small" value="${rubro?.codigo ? (rubro?.codigo?.contains("-") ? rubro?.codigo?.split("-")[1] : rubro?.codigo) : ''}"--}%
                %{--id="input_codigo" maxlength="30" minlength="2">--}%
                %{--                    <input type="text" name="rubro.codigo" class="span20 allCaps required input-small"--}%
                %{--                           value="${rubro?.codigo}"--}%
                %{--                           id="input_codigo" maxlength="30" minlength="2">--}%

                %{--                    <p class="help-block ui-helper-hidden"></p>--}%

                    <g:if test="${rubro?.id}">
                        %{--<g:if test="${rubro?.codigo?.contains(empresa?.codigo?.toString()?.toUpperCase())}">--}%
                            %{--<div class="input-prepend">--}%
                                %{--<span class="add-on">${empresa?.codigo?.toUpperCase() + "-"}</span>--}%
                                %{--<g:textField name="rubro.codigo" id="input_codigo" class="allCaps required input-small" maxlength="30" minlength="3" value="${rubro?.codigo ? (rubro?.codigo?.contains("-") ? rubro?.codigo?.split("-")[1] : rubro?.codigo) : ''}"/>--}%
%{----}%
                                %{--<p class="help-block ui-helper-hidden"></p>--}%
                            %{--</div>--}%
                        %{--</g:if>--}%
                        %{--<g:else>--}%
                            %{--<input type="text" name="rubro.codigo" class="span20 allCaps required input-small" value="${rubro?.codigo ? (rubro?.codigo?.contains("-") ? rubro?.codigo?.split("-")[1] : rubro?.codigo) : ''}"--}%
                            <input type="text" name="rubro.codigo" class="span20 allCaps required input-small" value="${rubro?.codigo}"
                                   id="input_codigo" maxlength="30" minlength="3">
                            <p class="help-block ui-helper-hidden"></p>
                        %{--</g:else>--}%
                    </g:if>
                    <g:else>
                        <div class="input-prepend">
                            <span class="add-on">${empresa?.codigo?.toUpperCase() + "-"}</span>
                            <g:textField name="rubro.codigo" id="input_codigo" class="allCaps required input-small" maxlength="30" minlength="3" value="${rubro?.codigo ? (rubro?.codigo?.contains("-") ? rubro?.codigo?.split("-")[1]?.padLeft(3, '0') : rubro?.codigo?.padLeft(3, '0')) : ''}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </g:else>
                </div>

                <div class="span2" style="width: 130px; margin-left: 10px">
                    Código Especificación
                    <input type="text" name="rubro.codigoEspecificacion" class="span24 allCaps required input-small" value="${rubro?.codigoEspecificacion}" id="input_codigo_es" maxlength="30">

                    <p class="help-block ui-helper-hidden"></p>
                </div>

                <div class="span6" style="width: 500px; margin-left: 10px">
                    Descripción
                    <input type="text" name="rubro.nombre" class="span72" value="${rubro?.nombre}" id="input_descripcion">
                </div>

                <div class="span2" style="width: 105px; margin-left: 10px">
                    Fecha Creación
                    <elm:datepicker name="rubro.fechaReg" class="span24" value="${rubro?.fecha}" disabled="true" id="fechaCreacion"/>
                </div>

                <div class="span2"  style="width: 140px; margin-left: 10px">
                    Fecha Modificación
                    <elm:datepicker name="rubro.fechaReg" class="span24" value="${rubro?.fechaModificacion}" format="dd-MM-yyyy hh:mm " disabled="true" id="fchaMod"/>
                </div>

            </div>

            <div class="row-fluid">
                <div class="span2" style="width: 150px;">
                    Dirección responsable
                    <g:select name="rubro.grupo.id" id="selClase" from="${grupos}" class="span12" optionKey="id" optionValue="descripcion"
                              value="${rubro?.departamento?.subgrupo?.grupo?.id}" noSelection="['': '--Seleccione--']"/>
                </div>

                <div class="span2" style="width: 310px; margin-left: 10px">
                    Grupo
                    <g:if test="${rubro?.departamento?.subgrupo?.id}">
                        <g:select id="selGrupo" name="rubro.suggrupoItem.id" from="${janus.SubgrupoItems.findAllByGrupo(rubro?.departamento?.subgrupo?.grupo)}"
                                  class="span12" optionKey="id" optionValue="descripcion" value="${rubro?.departamento?.subgrupo?.id}" noSelection="['': '--Seleccione--']"/>
                    </g:if>
                    <g:else>
                        <select id="selGrupo" class="span12"></select>
                    </g:else>
                </div>

                <div class="span3" style="width: 200px; margin-left: 10px">
                    Sub grupo
                    <g:if test="${rubro?.departamento?.id}">
                        <g:select name="rubro.departamento.id" id="selSubgrupo" from="${janus.DepartamentoItem.findAllBySubgrupo(rubro?.departamento?.subgrupo)}"
                                  class="span12" optionKey="id" optionValue="descripcion" value="${rubro?.departamento?.id}"/>
                    </g:if>
                    <g:else>
                        <select id="selSubgrupo" class="span12"></select>
                    </g:else>
                </div>

                <div class="span1" style="width: 75px; margin-left: 10px">
                    Unidad
                    <g:select name="rubro.unidad.id" from="${janus.Unidad.list()}" class="span12" optionKey="id" optionValue="codigo" value="${rubro?.unidad?.id}"/>
                </div>

                <div class="span2" style="color: #01a; width: 260px; margin-left: 10px" >
                    Responsable: <br>
                    <g:if test="${rubro?.aprobado != 'R'}">
                        <input type="hidden" name="rubro.responsable" class="span72" value="${rubro?.responsable?.id?:session.usuario.id}" id="selResponsable">
                        <input type="text" name="persona" class="span72" value="${rubro?.responsable?:session.usuario}" id="Responsable" readonly>
                    </g:if>
                    <g:else>
                        <g:textField name="persona_res" value="${rubro?.responsable}" readonly="true" title="${rubro?.responsable}" class="span12"/>
                    </g:else>
                </div>
                <div class="span1" style="width: 50px; color: #01a">
                    Estado
                    <g:textField name="estadoSuper" value="${rubro?.aprobado == null ? 'N' : 'R'}" readonly="true" title="${rubro?.aprobado == null ? 'Ingresado' : 'Registrado'}" class="span12"/>
                </div>
            </div>
        </g:form>
    </div>

    <div style="border-bottom: 1px solid black;padding-left: 50px;margin-top: 10px;position: relative;">
        <p class="css-vertical-text">Items</p>

        <div class="linea" style="height: 100px;"></div>

        <div class="row-fluid" style="color: #248">

            <div class="span6" style="width: 500px;">
                Lista de precios: MO y Equipos
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(6))}" optionKey="id" optionValue="descripcion" class="span10" id="ciudad" style="width: 300px"/>
            </div>

            <div class="span3" style="width: 180px;">
                % costos indirectos
                <input type="text" style="width: 30px;" id="costo_indi" value="20.0">
            </div>

            <div class="span2">
                Fecha
                <elm:datepicker name="item.fecha" class="span8" id="fecha_precios" value="${new java.util.Date()}" format="dd-MM-yyyy"/>
            </div>

            <g:if test="${rubro}">
                <g:if test="${rubro?.aprobado != 'R'}">
                    <div class="span2" style="margin-left: -10px">
                        <a class="btn btn-small btn-warning " href="#" rel="tooltip" title="Copiar " id="btn_copiarComp">
                            Copiar composición
                        </a>
                    </div>
                    <div class="span1" style="margin-left: -10px">
                        <a class="btn btn-small btn-info infoItem" href="#" rel="tooltip" title="Información">
                            <i class="icon-exclamation"></i> Info</a>
                    </div>
                </g:if>
            </g:if>

        </div>

        <div class="row-fluid" style="margin-bottom: 5px">
            <div class="span2">
                CÓDIGO
                <input type="text" name="item.codigo" id="cdgo_buscar" class="span24" readonly="true">
                <input type="hidden" id="item_id">
                <input type="hidden" id="item_tipoLista">
            </div>

            <div class="span1" style="margin-top: 20px; width: 80px">
                <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar rubro" id="btnRubro">
                    <i class="icon-search"></i> Buscar
                </a>
            </div>

            <div class="span5">
                DESCRIPCIÓN
                <input type="text" name="item.descripcion" id="item_desc" class="span11" readonly="true">
            </div>

            <div class="span1" style="margin-right: 0px;margin-left: -30px;">
                UNIDAD
                <input type="text" name="item.unidad" id="item_unidad" class="span8" readonly="true">
            </div>

            <div class="span1" style="margin-left: -5px !important;">
                CANTIDAD
                <input type="text" name="item.cantidad" class="span12" id="item_cantidad" value="0" style="text-align: right">
            </div>

            <div class="span2">
                RENDIMIENTO
                <input type="text" name="item.rendimiento" class="span8" id="item_rendimiento" value="1" style="text-align: right; color: #44a;width: 170px;">
            </div>

            <g:if test="${rubro?.aprobado != 'R'}">
                <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 22px;margin-left: 10px">
                    <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Agregar" id="btn_agregarItem">
                        <i class="icon-plus"></i>
                    </a>
                    <a class="btn btn-small btn-primary btn-ajax" href="#" rel="tooltip" title="Precio" id="btn_precio">$</a>
                </div>
            </g:if>
        </div>
    </div>

    <input type="hidden" id="actual_row">

    <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;float: left;width: 95%" id="tablas">
        <p class="css-vertical-text">Composición</p>

        <div class="linea" style="height: 98%;"></div>
        <table class="table table-bordered table-striped table-condensed table-hover" style="margin-top: 10px;">
            <thead>
            <tr>
                <th style="width: 80px;">
                    CÓDIGO
                </th>
                <th style="width: 600px;">
                    EQUIPO
                </th>
                <th style="width: 80px;">
                    CANTIDAD
                </th>
                <th class="col_tarifa" style="display: none;">TARIFA <br>($/hora)</th>
                <th class="col_hora" style="display: none;">COSTO($)</th>
                <th class="col_rend" style="width: 50px">RENDIMIENTO</th>
                <th class="col_total" style="display: none;"><C class="TOTAL"></C>C.TOTAL($)<br>($/hora)</th>
                <th style="width: 40px" class="col_delete"></th>
            </tr>
            </thead>
            <tbody id="tabla_equipo">
            <g:each in="${items}" var="rub" status="i">
                <g:if test="${rub.item.departamento.subgrupo.grupo.id == 3}">
                    <tr class="item_row " id="${rub.id}" tipo="${rub.item.departamento.subgrupo.grupo.id}">
                        <td class="cdgo">${rub.item.codigo}</td>
                        <td>${rub.item.nombre}</td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${rub.cantidad}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>

                        <td class="col_tarifa cod_${rub.item.codigo?.replaceAll('\\.', '_')}" style="display: none;text-align: right" id="i_${rub.item.id}"></td>
                        <td class="col_hora" style="display: none;text-align: right"></td>
                        <td class="col_rend rend" style="width: 50px;text-align: right" valor="${rub.rendimiento}">
                            <g:formatNumber number="${rub.rendimiento}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td class="col_total" style="display: none;text-align: right"></td>
                        <td style="width: 50px;text-align: center" class="col_delete">
                            <g:if test="${rubro?.aprobado != 'R'}">
                                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="${rub.id}">
                                    <i class="icon-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="width: 80px;">
                    CÓDIGO
                </th>
                <th style="width: 600px;">
                    MANO DE OBRA
                </th>
                <th style="width: 80px">
                    CANTIDAD
                </th>

                <th class="col_jornal" style="display: none;">JORNAL<br>($/hora)</th>
                <th class="col_hora" style="display: none;">COSTO($)</th>
                <th class="col_rend" style="width: 50px;">RENDIMIENTO</th>
                <th class="col_total" style="display: none;">C.TOTAL($)</th>
                <th style="width: 40px" class="col_delete"></th>
            </tr>
            </thead>
            <tbody id="tabla_mano">
            <g:each in="${items}" var="rub" status="i">
                <g:if test="${rub.item.departamento.subgrupo.grupo.id == 2}">
                    <tr class="item_row" id="${rub.id}" tipo="${rub.item.departamento.subgrupo.grupo.id}">
                        <td class="cdgo">${rub.item.codigo}</td>
                        <td>${rub.item.nombre}</td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${rub.cantidad}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>

                        <td class="col_jornal" style="display: none;text-align: right" id="i_${rub.item.id}"></td>
                        <td class="col_hora" style="display: none;text-align: right"></td>
                        <td class="col_rend rend" style="width: 50px;text-align: right" valor="${rub.rendimiento}">
                            <g:formatNumber number="${rub.rendimiento}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td class="col_total" style="display: none;text-align: right"></td>
                        <td style="width: 50px;text-align: center" class="col_delete">
                            <g:if test="${rubro?.aprobado != 'R'}">
                                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="${rub.id}">
                                    <i class="icon-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="width: 80px;">
                    CÓDIGO
                </th>
                <th style="width: 600px;">
                    MATERIAL
                </th>
                <th style="width: 60px" class="col_unidad">
                    UNIDAD
                </th>
                <th style="width: 80px">
                    CANTIDAD
                </th>
                <th style="width: 40px" class="col_delete"></th>
                <th class="col_precioUnit" style="display: none;">UNITARIO</th>
                <th class="col_total" style="display: none;">C.TOTAL($)</th>
            </tr>
            </thead>
            <tbody id="tabla_material">
            <g:each in="${items}" var="rub" status="i" >
                <g:if test="${rub.item.departamento.subgrupo.grupo.id == 1}">
                    <tr class="item_row" id="${rub.id}" tipo="${rub.item.departamento.subgrupo.grupo.id}">
                        <td class="cdgo">${rub.item.codigo}</td>
                        <td>${rub.item.nombre}</td>
                        <td style="width: 60px !important;text-align: center" class="col_unidad">${rub.item.unidad.codigo}</td>
                        <td style="text-align: right" class="cant">
                            <g:formatNumber number="${rub.cantidad}" format="##,#####0" minFractionDigits="5" maxFractionDigits="5" locale="ec"/>
                        </td>
                        <td class="col_precioUnit" style="display: none;text-align: right" id="i_${rub.item.id}"></td>

                        <td class="col_total" style="display: none;text-align: right"></td>
                        <td style="width: 50px;text-align: center" class="col_delete">
                            <g:if test="${rubro?.aprobado != 'R'}">
                                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="${rub.id}">
                                    <i class="icon-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>

        <div id="tabla_transporte"></div>

        <div id="tabla_indi"></div>

        <div id="tabla_costos" style="height: 120px;display: none;float: right;width: 100%;margin-bottom: 10px;"></div>
    </div>
</div>

<div class="modal grande hide fade " id="modal-rubro" style=";overflow: hidden;">
    <div class="modal-header btn-primary">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
        <div id="tipos" class="btn-group" data-toggle="buttons-radio">
            <button type="button" class="btn btn-primary tipo active" tipo="3">Equipos</button>
            <button type="button" class="btn btn-primary tipo" tipo="2">Mano de obra</button>
            <button type="button" class="btn btn-primary tipo" tipo="1">Materiales</button>
        </div>
        <bsc:buscador name="rubro.buscador.id" value="" accion="buscaRubro" controlador="rubro" campos="${campos}" label="Rubro" tipo="lista"/>
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<div class="modal large hide fade " id="modal-detalle" style=";overflow: hidden;">
    <div class="modal-header btn-primary">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle-detalle">Especificaciones</h3>
    </div>

    <div class="modal-body" id="modalBody-detalle">
        Especificaciones:<br>
        <textarea id="especificaciones" style="width: 700px;height: 150px;resize: none;margin-top: 10px">
            ${rubro?.especificaciones}
        </textarea>
    </div>

    <div class="modal-footer" id="modalFooter-detalle">
        <a href="#" id="save-espc" class="btn btn-info">Guardar</a>
    </div>
</div>

<div class="modal large hide fade " id="modal-transporte" style=";overflow: hidden;">
    <div class="modal-header btn-primary">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modal_trans_title">
            Variables de transporte
        </h3>
    </div>

    <div class="modal-body" id="modal_trans_body">
        <div class="row-fluid">
            <div class="span2">
                Volquete
            </div>

            <div class="span5">
                <g:select name="volquetes" from="${volquetes2}" optionKey="id" optionValue="nombre" id="cmb_vol" noSelection="${['-1': 'Seleccione']}" value="${aux.volquete.id}"/>
            </div>

            <div class="span2">
                Costo
            </div>

            <div class="span3">
                <input type="text" style="width: 60px;text-align: right" disabled="" id="costo_volqueta">
            </div>
        </div>

        <div class="row-fluid">
            <div class="span2">
                Chofer
            </div>

            <div class="span5">
                <g:select name="volquetes" from="${choferes}" optionKey="id" optionValue="nombre" id="cmb_chof" style="" noSelection="${['-1': 'Seleccione']}" value="${aux.chofer.id}"/>
            </div>

            <div class="span2">
                Costo
            </div>

            <div class="span3">
                <input type="text" style="width: 60px;text-align: right" disabled="" id="costo_chofer">
            </div>
        </div>

        <div class="row-fluid" style="border-bottom: 1px solid black;margin-bottom: 5px">
            <div class="span6">
                <b>Distancia peso</b>
            </div>

            <div class="span5" style="margin-left: 30px;">
                <b>Distancia volumen</b>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span2">
                Canton
            </div>

            <div class="span3">
                <input type="text" style="width: 50px;" id="dist_p1" value="0.00">
            </div>

            <div class="span4">
                Materiales Petreos Hormigones
            </div>

            <div class="span3">
                <input type="text" style="width: 50px;" id="dist_v1" value="0.00">
            </div>

        </div>

        <div class="row-fluid">
            <div class="span2">
                Especial
            </div>

            <div class="span3">
                <input type="text" style="width: 50px;" id="dist_p2" value="0.00">
            </div>

            <div class="span4">
                Materiales Mejoramiento
            </div>

            <div class="span3">
                <input type="text" style="width: 50px;" id="dist_v2" value="0.00">
            </div>
        </div>

        <div class="row-fluid">
            <div class="span5">

            </div>

            <div class="span4">
                Materiales Carpeta Asfáltica
            </div>

            <div class="span3">
                <input type="text" style="width: 50px;" id="dist_v3" value="0.00">
            </div>
        </div>

        <div class="row-fluid" style="border-bottom: 1px solid black;margin-bottom: 10px">
            <div class="span6">
                <b>Listas de precios</b>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span1">
                Canton
            </div>

            <div class="span4">
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(1))}"
                          optionKey="id" optionValue="descripcion" class="span10" id="lista_1"/>
            </div>

            <div class="span3">
                Petreos Hormigones
            </div>

            <div class="span4">
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(3))}"
                          optionKey="id" optionValue="descripcion" class="span10" id="lista_3"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span1">
                Especial
            </div>

            <div class="span4">
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(2))}"
                          optionKey="id" optionValue="descripcion" class="span10" id="lista_2"/>
            </div>

            <div class="span3">
                Mejoramiento
            </div>

            <div class="span4">
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(4))}"
                          optionKey="id" optionValue="descripcion" class="span10" id="lista_4"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span5"></div>

            <div class="span3">
                Carpeta Asfáltica
            </div>

            <div class="span4">
                <g:select name="item.ciudad.id" from="${janus.Lugar.findAllByTipoLista(janus.TipoLista.get(5))}"
                          optionKey="id" optionValue="descripcion" class="span10" id="lista_5"/>
            </div>
        </div>

    </div>
    <input type="hidden" id="totMat_h">

    <div class="modal-footer" id="modal_trans_footer">
        <a href="#" data-dismiss="modal" class="btn btn-primary">OK</a>
    </div>

    <div id="imprimirTransporteDialog">
        <fieldset>
            <div class="span4" style="margin-top: 10px">
                Se imprime a la Fecha de:
                <elm:datepicker  name="fechaSalida" class="span8" id="fechaSalidaId" value="${rubro?.fechaModificacion}"
                                 style="width: 100px"/>
            </div>

            <div class="span4" style="margin-top: 10px;">
                <strong>¿Desea imprimir el reporte desglosando el transporte?</strong>
            </div>
        </fieldset>
    </div>

    <div id="copiar_dlg">
        <input type="hidden" id="rub_select">
        Factor: <input type="text" id="factor" class="ui-corner-all" style="width:150px;">
    </div>

</div>

<div class="modal hide fade" id="modal-tree">
    <div class="modal-header" id="modal-header-tree">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle-tree"></h3>
    </div>

    <div class="modal-body" id="modalBody-tree">
    </div>

    <div class="modal-footer" id="modalFooter-tree">
    </div>
</div>

<div id="busqueda" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">Grupo</div>

            <div class="span2">Buscar Por</div>

            <div class="span2">Criterio</div>

            <div class="span2">Ordenado por</div>
        </div>

        <div class="row-fluid" style="margin-left: 20px">
            <div class="span2">
                <g:select name="buscarGrupo_name"  id="buscarGrupo" from="['1': 'Materiales', '2': 'Mano de Obra', '3': 'Equipos']"
                          style="width: 100%" optionKey="key" optionValue="value"/></div>

            <div class="span2"><g:select name="buscarPor" class="buscarPor" from="${[1: 'Nombre', 2: 'Código']}"
                                         style="width: 100%" optionKey="key"
                                         optionValue="value"/></div>

            <div class="span2">
                <g:textField name="criterio" class="criterio" style="width: 80%"/>
            </div>

            <div class="span2">
                <g:select name="ordenar" class="ordenar" from="${[1: 'Nombre', 2: 'Código']}"
                          style="width: 100%" optionKey="key"
                          optionValue="value"/></div>

            <div class="span2" style="margin-left: 60px"><button class="btn btn-info" id="btn-consultar"><i
                    class="icon-check"></i> Consultar
            </button></div>

        </div>
    </fieldset>

    <fieldset class="borde">
        <div id="divTabla" style="height: 460px; overflow-y:auto; overflow-x: auto;">
        </div>
    </fieldset>
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
            ev.keyCode == 37 || ev.keyCode == 39);
    }

    $("#codigo").keydown(function (ev) {
        return validarNumDec(ev)
    });

    $("#btnRubro").click(function () {
        $("#busqueda").dialog("open");
        $(".ui-dialog-titlebar-close").html("x");
        return false;
    });

    $("#busqueda").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        draggable: false,
        width: 1000,
        height: 600,
        position: 'center',
        title: 'Items'
    });

    $("#btn-consultar").click(function () {
        busqueda();
    });

    function busqueda() {
        var buscarPor = $("#buscarPor").val();
        var criterio = $(".criterio").val();
        var ordenar = $("#ordenar").val();
        var grupo = $("#buscarGrupo").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'rubro', action:'listaItem')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar,
                grupo: grupo
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            }
        });
    }

    $("#btn_precio").click(function () {
        var idItem = $("#item_id").val();
        if(idItem){
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'rubro', action:'precio_ajax')}",
                data    : {
                    item        : idItem
                },
                success : function (msg) {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Guardar</a>');
                    btnSave.click(function () {
                        if($("#precioUnitario").val() == 0){
                            $("#modal-tree").modal("hide");
                            $.box({
                                imageClass: "box_info",
                                text: "Ingrese un valor diferente de 0",
                                title: "Error",
                                dialog: {
                                    resizable: false,
                                    draggable: false,
                                    width: 300,
                                    height: 150,
                                    buttons: {
                                        "Aceptar": function () {
                                        }
                                    }
                                }
                            });
                        }else{
                            $.ajax({
                                type    : "POST",
                                url     : $("#frmSave").attr("action"),
                                data    : $("#frmSave").serialize(),
                                success : function (msg) {
                                    if (msg == "OK") {
                                        $("#modal-tree").modal("hide");
                                        $.box({
                                            imageClass: "box_info",
                                            text: "Precio creado correctamente",
                                            title: "Precio creado",
                                            dialog: {
                                                resizable: false,
                                                draggable: false,
                                                width: 300,
                                                height: 150,
                                                buttons: {
                                                    "Aceptar": function () {
                                                    }
                                                }
                                            }
                                        });
                                    } else {
                                        $("#modal-tree").modal("hide");
                                        $.box({
                                            imageClass: "box_info",
                                            text: "Error al crear el precio",
                                            title: "Error",
                                            dialog: {
                                                resizable: false,
                                                draggable: false,
                                                width: 300,
                                                height: 150,
                                                buttons: {
                                                    "Aceptar": function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                        return false;
                    });

                    $("#modalTitle-tree").html("Nuevo Precio");
                    $("#modalBody-tree").html(msg);
                    $("#modalFooter-tree").html("").append(btnOk).append(btnSave);
                    $("#modal-tree").modal("show");
                }
            });
        }else{
            $.box({
                imageClass: "box_info",
                text: "Seleccione un item!",
                title: "Error",
                dialog: {
                    resizable: false,
                    draggable: false,
                    width: 300,
                    height: 150,
                    buttons: {
                        "Aceptar": function () {
                        }
                    }
                }
            });
        }
    });

    var urlS = "${resource(dir:'images', file:'spinner_24.gif')}";
    var spinner = $("<img style='margin-left:15px;' src='" + urlS + "' alt='Cargando...'/>");

    $("#btnRegistrar").click(function () {
        var idRubro = '${rubro?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de este"  + '<p style="margin-left: 42px">' + "rubro a " + '<strong style="color: #1a7031">' + "APROBADO" + "?" + '</strong>' + '</p>',
            title: "Registrar rubro",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#btnRegistrar").replaceWith(spinner);
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'rubro', action: 'registrar_ajax')}',
                            data:{
                                id: idRubro
                            },
                            success: function (msg) {
                                if(msg == 'ok'){
                                    $("#spanOk").html("Rubro registrado correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    $("#spanError").html("Error al cambiar el estado del rubro a registrado");
                                    $("#divError").show()
                                }
                            }
                        })

                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    });

    $("#btnQuitarRegistro").click(function () {
        var idRubroR = '${rubro?.id}';
        $.box({
            imageClass: "box_info",
            text: "Está seguro de cambiar el estado de este"  + '<p style="margin-left: 42px">' + "rubro a " +
                '<strong style="color: #ff5c34">' + "NO APROBADO" + "?" + '</strong>' + '</p>',
            title: "Quitar registro del rubro",
            dialog: {
                resizable: false,
                draggable: false,
                width: 340,
                height: 180,
                buttons: {
                    "Aceptar": function () {
                        $("#btnQuitarRegistro").replaceWith(spinner);
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'rubro', action: 'desregistrar_ajax')}',
                            data:{
                                id: idRubroR
                            },
                            success: function (msg) {
                                if(msg == 'ok'){
                                    $("#spanOk").html("Se ha retirado el registro del rubro correctamente");
                                    $("#divOk").show();
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    $("#spanError").html("Error al cambiar el estado del rubro a ingresado");
                                    $("#divError").show()
                                }
                            }
                        })
                    },
                    "Cancelar": function () {

                    }
                }
            }
        });
    });

    function agregar(id,tipo){
        var tipoItem=$("#item_id").attr("tipo");
        var cant = $("#item_cantidad").val();
        if (cant == "")
            cant = 0;
        if (isNaN(cant))
            cant = 0;
        if(tipoItem*1>1){
            if(cant>0){
                var c = Math.ceil(cant);
//                console.log(c)
                if(c>cant){
                    cant=0
                }
            }
        }
        var rend = $("#item_rendimiento").val();
        if (isNaN(rend))
            rend = 1
        if ($("#item_id").val() * 1 > 0) {
            if (cant > 0) {
                var data = "rubro="+id+"&item=" + $("#item_id").val() + "&cantidad=" + cant + "&rendimiento=" + rend
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'addItem')}",
                    data     : data,
                    success  : function (msg) {
                        if(tipo=="H"){
                            window.location.href="${g.createLink(action: 'rubroPrincipal')}?idRubro="+id
                        }
                        var tr = $("<tr class='item_row'>");
                        var td = $("<td>");
                        var band = true;
                        var parts = msg.split(";");
                        tr.attr("id", parts[1]);
                        tr.attr("tipoLista", parts[5]);
                        var a;
                        td.addClass("cdgo");
                        td.html($("#cdgo_buscar").val());
                        tr.append(td);
                        td = $("<td>");
                        td.html($("#item_desc").val());
                        tr.append(td);

                        if (parts[0] == "1") {
                            $("#tabla_material").children().find(".cdgo").each(function () {
//                                    ////console.log($(this))
                                if ($(this).html() == $("#cdgo_buscar").val()) {
                                    var tdCant = $(this).parent().find(".cant");
                                    var tdRend = $(this).parent().find(".rend");
                                    tdCant.html(number_format(parts[3], 5, ".", ""));
                                    tdRend.html(number_format(parts[4], 5, ".", ""));
                                    tdRend.attr("valor", parts[4]);
                                    band = false
                                }
                            });
                            if (band) {
                                td = $("<td style='text-align: center' class='col_unidad'>")
                                td.html($("#item_unidad").val())
                                tr.append(td)
                                td = $("<td style='text-align: right' class='cant'>")
                                td.html(number_format($("#item_cantidad").val(), 5, ".", ""))
                                tr.append(td)
                                td = $('<td class="col_precioUnit" style="display: none;text-align: right"></td>');
                                td.attr("id", "i_" + parts[2])
                                tr.append(td)
                                td = $('<td class="col_vacio" style="width: 40px;display: none"></td>');
                                tr.append(td)
                                td = $('<td class="col_vacio" style="width: 40px;display: none"></td>');
                                tr.append(td)
                                td = $('<td class="col_total" style="display: none;text-align: right"></td>');
                                tr.append(td)
                                td = $('<td  style="width: 40px;text-align: center" class="col_delete">')
                                a = $('<a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="' + parts[1] + '"><i class="icon-trash"></i></a>')
                                td.append(a)
                                tr.append(td)
                                $("#tabla_material").append(tr)
                            }

                        } else {
                            if (parts[0] == "2") {

                                $("#tabla_mano").children().find(".cdgo").each(function () {
//                                        ////console.log("mano de obra ",parts)
                                    if ($(this).html() == $("#cdgo_buscar").val()) {
                                        var tdCant = $(this).parent().find(".cant")
                                        var tdRend = $(this).parent().find(".rend")
                                        tdCant.html(number_format(parts[3], 5, ".", ""))
                                        tdRend.html(number_format(parts[4], 5, ".", ""))
                                        tdRend.attr("valor", parts[4]);
                                        band = false
                                    }
                                });
                                if (band) {
                                    td = $("<td style='text-align: right' class='cant'>")
                                    td.html(number_format(parts[3], 5, ".", ""))
                                    tr.append(td)
                                    td = $('<td class="col_jornal" style="display: none;text-align: right"></td>');
                                    td.attr("id", "i_" + parts[2])
                                    tr.append(td)
                                    td = $('<td class="col_hora" style="display: none;text-align: right"></td>');
                                    tr.append(td)
                                    td = $("<td style='text-align: right' class='col_rend rend'>")
                                    td.attr("valor", parts[4]);
                                    td.html(number_format(parts[4], 5, ".", ""))
                                    tr.append(td)
                                    td = $('<td class="col_total" style="display: none;text-align: right"></td>');
                                    tr.append(td)
                                    td = $('<td  style="width: 40px;text-align: center" class="col_delete">')
                                    a = $('<a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="' + parts[1] + '"><i class="icon-trash"></i></a>')
                                    td.append(a)
                                    tr.append(td)
                                    $("#tabla_mano").append(tr)
                                }

                            } else {
                                $("#tabla_equipo").children().find(".cdgo").each(function () {
                                    if ($(this).html() == $("#cdgo_buscar").val()) {

                                        var tdCant = $(this).parent().find(".cant")
                                        var tdRend = $(this).parent().find(".rend")
                                        tdCant.html(number_format(parts[3], 5, ".", ""))
                                        tdRend.html(number_format(parts[4], 5, ".", ""))
                                        tdRend.attr("valor", parts[4]);
                                        band = false
                                    }
                                });

                                if (band) {
                                    td = $("<td style='text-align: right' class='cant'>")
                                    td.html(number_format(parts[3], 5, ".", ""))
                                    tr.append(td)
                                    td = $('<td class="col_tarifa" style="display: none;text-align: right"></td>');
                                    td.attr("id", "i_" + parts[2])
                                    tr.append(td)
                                    td = $('<td class="col_hora" style="display: none;text-align: right"></td>');
                                    tr.append(td)
                                    td = $("<td style='text-align: right' class='col_rend rend'>");
                                    td.attr("valor", parts[4]);
                                    td.html(number_format(parts[4], 5, ".", ""))
                                    tr.append(td)
                                    td = $('<td class="col_total" style="display: none;text-align: right"></td>');
                                    tr.append(td)
                                    td = $('<td  style="width: 40px;text-align: center" class="col_delete">')
                                    a = $('<a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="' + parts[1] + '"><i class="icon-trash"></i></a>')
                                    td.append(a)
                                    tr.append(td)
                                    $("#tabla_equipo").append(tr)
                                }
                            }
                        }

                        tr.bind("dblclick", function () {
                            var row = $(this)
                            var hijos = row.children()
                            var desc = $(hijos[1]).html()
                            var cant
                            var codigo = $(hijos[0]).html()
                            var unidad
                            var rendimiento
                            var item
                            var tipo = row.attr("tipo")
                            for (i = 2; i < hijos.length; i++) {

                                if ($(hijos[i]).hasClass("cant"))
                                    cant = $(hijos[i]).html()
                                if ($(hijos[i]).hasClass("col_unidad"))
                                    unidad = $(hijos[i]).html()
                                if ($(hijos[i]).hasClass("col_rend"))
                                    rendimiento = $(hijos[i]).attr("valor")
                                if ($(hijos[i]).hasClass("col_tarifa"))
                                    item = $(hijos[i]).attr("id")
                                if ($(hijos[i]).hasClass("col_precioUnit"))
                                    item = $(hijos[i]).attr("id")
                                if ($(hijos[i]).hasClass("col_jornal"))
                                    item = $(hijos[i]).attr("id")

                            }
                            item = item.replace("i_", "")
                            $("#item_cantidad").val(cant.toString().trim())
                            if (rendimiento)
                                $("#item_rendimiento").val(rendimiento.toString().trim())
                            $("#item_id").val(item)
                            $("#item_id").attr("tipo",tipo)
                            $("#cdgo_buscar").val(codigo)
                            $("#item_desc").val(desc)
                            $("#item_unidad").val(unidad)
                        })

                        if (a) {
                            a.bind("click", function () {
                                var tr = $(this).parent().parent()
                                if (confirm("Esta seguro de eliminar este registro? Esta acción es irreversible")) {
                                    $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'eliminarRubroDetalle')}",
                                        data     : "id=" + $(this).attr("iden"),
                                        success  : function (msg) {
                                            if (msg == "Registro eliminado") {
                                                tr.remove()
                                            }
                                            $.box({
                                                imageClass : "box_info",
                                                text       : msg,
                                                title      : "Alerta",
                                                iconClose  : false,
                                                dialog     : {
                                                    resizable : false,
                                                    draggable : false,
                                                    buttons   : {
                                                        "Aceptar" : function () {
                                                        }
                                                    }
                                                }
                                            });

                                        }
                                    });
                                }

                            });
                        }

                        $("#item_desc").val("")
                        $("#item_id").val("")
                        $("#item_cantidad").val("0")
                        $("#cdgo_buscar").val("")
                        $("#cdgo_unidad").val("")
                        $("#cdgo_buscar").focus()
                    }
                });
            } else {
                var msg = "La cantidad debe ser un número positivo."
                if(tipoItem*1>1){
                    msg="Para mano de obra y equipos, la cantidad debe ser un número entero positivo."
                }
                $.box({
                    imageClass : "box_info",
                    text       : msg,
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        }
                    }
                });
            }
        } else {
            $.box({
                imageClass : "box_info",
                text       : "Seleccione un item",
                title      : "Alerta",
                iconClose  : false,
                dialog     : {
                    resizable : false,
                    draggable : false,
                    buttons   : {
                        "Aceptar" : function () {
                        }
                    }
                }
            });
        }
    }
    function enviarItem() {
        var data = "";
        $("#buscarDialog").hide();
        $("#spinner").show();
        $(".crit").each(function () {
            data += "&campos=" + $(this).attr("campo");
            data += "&operadores=" + $(this).attr("operador");
            data += "&criterios=" + $(this).attr("criterio");
        });
        if (data.length < 2) {
            data = "tc=" + $("#tipoCampo").val() + "&campos=" + $("#campo :selected").val() + "&operadores=" + $("#operador :selected").val() + "&criterios=" + $("#criterio").val()
        }
        data += "&ordenado=" + $("#campoOrdn :selected").val() + "&orden=" + $("#orden :selected").val();
        var tipo = $(".tipo.active").attr("tipo")
        data+="&tipo="+tipo
        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'buscaItem')}",
            data     : data,
            success  : function (msg) {
                $("#spinner").hide();
                $("#buscarDialog").show();
                $(".contenidoBuscador").html(msg).show("slide");
            }
        });
    }

    function enviarCopiar() {
        var data = "";
        $("#buscarDialog").hide();
        $("#spinner").show();
        $(".crit").each(function () {
            data += "&campos=" + $(this).attr("campo");
            data += "&operadores=" + $(this).attr("operador");
            data += "&criterios=" + $(this).attr("criterio");
        });
        if (data.length < 2) {
            data = "tc=" + $("#tipoCampo").val() + "&campos=" + $("#campo :selected").val() + "&operadores=" +
                $("#operador :selected").val() + "&criterios=" + $("#criterio").val()
        }
        data += "&ordenado=" + $("#campoOrdn :selected").val() + "&orden=" + $("#orden :selected").val();
        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'buscaRubroComp')}",
            data     : data,
            success  : function (msg) {
                $("#spinner").hide();
                $("#buscarDialog").show();
                $(".contenidoBuscador").html(msg).show("slide");
            }
        });
    }

    function transporte() {
        var dsp0 = $("#dist_p1").val()
        var dsp1 = $("#dist_p2").val()
        var dsv0 = $("#dist_v1").val()
        var dsv1 = $("#dist_v2").val()
        var dsv2 = $("#dist_v3").val()
        var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val()
        var volqueta = $("#costo_volqueta").val()
        var chofer = $("#costo_chofer").val()

        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'transporte')}",
            data     : "dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2  + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val() + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof=" + $("#cmb_chof").val() + "&volq=" + $("#cmb_vol").val(),
            success  : function (msg) {
                $("#tabla_transporte").html(msg)
                tablaIndirectos();
            }
        });
    }

    function totalEquipos() {
//        ////console.log("tot equipo")
        var trE = $("<tr id='total_equipo' class='total'>")
        var equipos = $("#tabla_equipo").children()
        var totalE = 0
        var td = $("<td>")
        td.html("<b>SUBTOTAL</b>")
        trE.append(td)
        for (i = 0; i < 5; i++) {
            td = $("<td>")
            trE.append(td)
        }

        equipos.each(function () {
            totalE += parseFloat($(this).find(".col_total").html())
        })

        td = $("<td class='valor_total'  style='text-align: right;;font-weight: bold'>")
        td.html(number_format(totalE, 5, ".", ""))
        trE.append(td)
        $("#tabla_equipo").append(trE)
        transporte()
    }

    function calculaHerramientas() {
        var h2 = $(".i_3490")
        var h3 = $(".cod_103_001_001")
        var h5 = $(".cod_103_001_002")
        var h
        if (h2.html())
            h = h2
        if (h3.html())
            h = h3
        if (h5.html())
            h = h5

        if (h) {

            var precio = 0
            var listas = "" + $("#lista_1").val() + "#" + $("#lista_2").val() + "#" + $("#lista_3").val() + "#" + $("#lista_4").val() + "#" + $("#lista_5").val() + "#" + $("#ciudad").val()

            var datos = "fecha=" + $("#fecha_precios").val() + "&ciudad=" + $("#ciudad").val() + "&tipo=C" + "&listas=" + listas + "&ids=" + str_replace("i_", "", h.attr("id"))
            $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'getPreciosItem')}",
                data     : datos,
                success  : function (msg) {
                    var precios = msg.split("&");
                    for (i = 0; i < precios.length; i++) {
                        var parts = precios[i].split(";");
                        if (parts.length > 1) {
                            precio = parseFloat(parts[1].trim())
                        }
                    }
                    var padre = h.parent()
                    var rend = padre.find(".rend")
                    var hora = padre.find(".col_hora")
                    var total = padre.find(".col_total")
                    var cant = padre.find(".cant")
                    var tarifa = padre.find(".col_tarifa")
                    rend.html(number_format(1, 5, ".", ""))
                    cant.html(number_format($("#total_mano").find(".valor_total").html(), 5, ".", ""))
//                    ////console.log("cantidad",$("#total_mano").find(".valor_total").html())
//                    ////console.log(number_format($("#total_mano").find(".valor_total").html(), 5, ".", ""))
                    tarifa.html(number_format(precio, 5, ".", ""))
                    hora.html(number_format(parseFloat(cant.html()) * parseFloat(tarifa.html()), 5, ".", ""))
                    total.html(number_format(parseFloat(hora.html()) * parseFloat(rend.html()), 5, ".", ""))
                    totalEquipos()
//                    ////console.log("total herramienta",parseFloat(hora.html())*parseFloat(rend.html()),total)

                }
            });

        } else {
            totalEquipos()
        }

    }

    function calcularTotales() {
        var materiales = $("#tabla_material").children()
        var equipos = $("#tabla_equipo").children()
        var manos = $("#tabla_mano").children()
        var totalM = 0, totalE = 0, totalMa = 0
        var trM = $("<tr id='total_material' class='total'>")
        var trMa = $("<tr id='total_mano' class='total'>")
        var trE = $("<tr id='total_equipo' class='total'>")

        var td = $("<td>")
        td.html("<b>SUBTOTAL</b>")
        trM.append(td)
        td = $("<td>")
        td.html("<b>SUBTOTAL</b>")
        trMa.append(td)
        td = $("<td>")
        td.html("<b>SUBTOTAL</b>")
        trE.append(td)
        for (i = 0; i < 5; i++) {
            if (i < 3) {
                td = $("<td>")
                trM.append(td)
            }
            td = $("<td>")
            trMa.append(td)
            td = $("<td>")
            trE.append(td)
        }

        td = $("<td>")
        trM.append(td)
        materiales.each(function () {
            var val = $(this).find(".col_total").html()
            if (val == "")
                val = 0
            if (isNaN(val))
                val = 0
            totalM += parseFloat(val)
        });
        manos.each(function () {
            totalMa += parseFloat($(this).find(".col_total").html())
        });
        td = $("<td class='valor_total' style='text-align: right;font-weight: bold'>")
        td.html(number_format(totalM, 5, ".", ""))
        trM.append(td)
        td = $("<td class='valor_total'  style='text-align: right;font-weight: bold'>")
        td.html(number_format(totalMa, 5, ".", ""))
        trMa.append(td)
        $("#tabla_material").append(trM)
        $("#tabla_mano").append(trMa)
        $("#totMat_h").val(totalMa)
        calculaHerramientas()
    }

    function tablaIndirectos() {
        var total = 0
        $(".valor_total").each(function () {
            total += $(this).html() * 1
        })
        var indi = $("#costo_indi").val()
        if (isNaN(indi))
            indi = 21
        indi = parseFloat(indi)
        var tabla = $('<table class="table table-bordered table-striped table-condensed table-hover">')
        tabla.append("<thead><tr><th colspan='3'>COSTOS INDIRECTOS</th></tr><tr><th style='width: 885px;'>DESCRIPCION</th><th style='text-align: right'>PORCENTAJE</th><th style='text-align: right'>VALOR</th></tr></thead>")
        tabla.append("<tbody><tr><td>COSTOS INDIRECTOS</td><td style='text-align: right'>" + indi + "%</td><td style='text-align: right;font-weight: bold'>" + number_format(total * indi / 100, 5, ".", "") + "</td></tr></tbody>")
        tabla.append("</table>")
        $("#tabla_indi").append(tabla)
        tabla = $('<table class="table table-bordered table-striped table-condensed table-hover" ' +
            'style="width: 360px;float: right;border: 1px solid #00485a">')
        tabla.append("<tbody>");
        tabla.append("<tr><td style='width: 300px;font-weight: bolder;'>COSTO UNITARIO DIRECTO</td><td style='text-align: right;font-weight: bold'>" + number_format(total, 5, ".", "") + "</td></tr>")
        tabla.append("<tr><td style='font-weight: bolder'>COSTOS INDIRECTOS</td><td style='text-align: right;font-weight: bold'>" + number_format(total * indi / 100, 5, ".", "") + "</td></tr>")
        tabla.append("<tr><td style='font-weight: bolder'>COSTO TOTAL DEL RUBRO</td><td style='text-align: right;font-weight: bold'>" + number_format(total * indi / 100 + total, 5, ".", "") + "</td></tr>")
        tabla.append("<tr><td style='font-weight: bolder'>PRECIO UNITARIO ($USD)</td><td style='text-align: right;font-weight: bold'>" + number_format(total * indi / 100 + total, 2, ".", "") + "</td></tr>")
        tabla.append("</tbody>");
        $("#tabla_costos").append(tabla)
        $("#tabla_costos").show("slide")
    }

    $(function () {
        $("#save-espc").click(function () {
            if ($("#especificaciones").val().trim().length < 1024) {
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro', action:'saveEspc')}",
                    data     : "id=${rubro?.id}&espc=" + $("#especificaciones").val().trim(),
                    success  : function (msg) {
                        if (msg == "ok") {
                            $("#modal-detalle").modal("hide");
                        } else {
                            $.box({
                                imageClass : "box_info",
                                text       : "Error",
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
                                    buttons   : {
                                        "Aceptar" : function () {
                                        }
                                    },
                                    width     : 500
                                }
                            });
                        }
                    }
                });
            } else {
                $.box({
                    imageClass : "box_info",
                    text       : "Error",
                    title      : "Error: Las especificaciones deben tener un máximo de 1024 caracteres",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        },
                        width     : 500
                    }
                });
            }

        });

        $("#copiar_dlg").dialog({
            autoOpen : false,
            width    : 400,
            height   : 200,
            title    : "Copiar composición",
            modal    : true,
            buttons  : {
                "Cancelar" : function () {
                    $("#copiar_dlg").dialog("close")
                },
                "Copiar"   : function () {
                    $("#dlgLoad").dialog("open")
                    var factor = $("#factor").val()
                    if (isNaN(factor))
                        factor = 0;
                    else
                        factor = factor * 1;
                    if (factor > 0) {

                        var idReg = $("#rub_select").val();
                        var datos = "rubro=" + $("#rubro__id").val() + "&copiar=" + idReg + "&factor=" + factor;
                        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro', action: 'copiarComposicion')}",
                            data     : datos,
                            success  : function (msg) {
                                $("#modal-rubro").modal("hide");
                                window.location.reload(true)
                            }
                        });

                    } else {
                        $("#dlgLoad").dialog("close")
                        $.box({
                            imageClass : "box_info",
                            text       : "El factor debe ser un número positivo",
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                draggable : false,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                }
                            }
                        });
                    }
                }
            }
        });

        $("#fecha_precios").change(function(){
            $("#cmb_vol").change()
            $("#cmb_chof").change()
        });

        $("#foto").click(function () {
            var child = window.open('${createLink(controller:"rubro",action:"showFoto",id: rubro?.id, params:[tipo:"il"])}', 'Mies', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');

            if (child.opener == null)
                child.opener = self;
            window.toolbar.visible = false;
            window.menubar.visible = false;
        });

        $("#detalle").click(function () {
            var child = window.open('${createLink(controller:"rubro",action:"showFoto",id: rubro?.id, params:[tipo:"dt"])}',
                'Mies', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');

            if (child.opener == null)
                child.opener = self;
            window.toolbar.visible = false;
            window.menubar.visible = false;
        });

        $("#borrar").click(function () {
            <g:if test="${rubro}">
            if (confirm("Esta Seguro?")) {
                $("#dlgLoad").dialog("open")
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'borrarRubro')}",
                    data     : "id=${rubro?.id}",
                    success  : function (msg) {
                        $("#dlgLoad").dialog("close")
                        if (msg == "ok") {
                            location.href = "${createLink(action: 'rubroPrincipal')}"
                        } else {
//                            ////console.log(msg)
                            $.box({
                                imageClass : "box_info",
                                text       : "Error: el rubro seleccionado no se pudo eliminar. Esta referenciado en las siguientes obras: <br>" + msg,
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
                                    buttons   : {
                                        "Aceptar" : function () {
                                        }
                                    },
                                    width     : 700
                                }
                            });
                        }
                    }
                });
            }
            </g:if>
        });

        <g:if test="${!rubro?.departamento?.subgrupo?.grupo?.id}">
        $("#selClase").val("");
        </g:if>
        $("#costo_indi").blur(function () {
            var indi = $(this).val()
            if (isNaN(indi) || indi * 1 < 0) {
                $.box({
                    imageClass : "box_info",
                    text       : "El porcentaje de costos indirectos debe ser un número positvo",
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        },
                        width     : 500
                    }
                });
                $("#costo_indi").val("21")
            }
        });

        $("#excel").click(function () {
            var dsp0 = $("#dist_p1").val()
            var dsp1 = $("#dist_p2").val()
            var dsv0 = $("#dist_v1").val()
            var dsv1 = $("#dist_v2").val()
            var dsv2 = $("#dist_v3").val()
            var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val()
            var volqueta = $("#costo_volqueta").val()
            var chofer = $("#costo_chofer").val()

            datos = "?dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2 + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val() + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof=" + $("#cmb_chof").val() + "&volq=" + $("#cmb_vol").val() + "&indi=" + $("#costo_indi").val()

            var url = "${g.createLink(controller: 'reportes3',action: 'imprimirRubroExcel')}" + datos
            location.href = url
        });

        $("#imprimir").click(function () {
            $("#imprimirTransporteDialog").dialog("open");
        });

        $("#transporte").click(function () {
            if ($("#fecha_precios").val().length < 8) {
                $.box({
                    imageClass : "box_info",
                    text       : "Seleccione una fecha para determinar la lista de precios",
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        },
                        width     : 500
                    }
                });
                $(this).removeClass("active")
            } else {
                $("#modal-transporte").modal("show");
            }
        })

        $("#cmb_vol").change(function () {
            if ($("#cmb_vol").val() != "-1") {
                var datos = "fecha=" + $("#fecha_precios").val() + "&ciudad=" + $("#ciudad").val() + "&ids=" + $("#cmb_vol").val()
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'getPreciosTransporte')}",
                    data     : datos,
                    success  : function (msg) {
                        var precios = msg.split("&")

                        for (i = 0; i < precios.length; i++) {
                            var parts = precios[i].split(";")
//                        ////console.log(parts,parts.length)
                            if (parts.length > 1)
                                $("#costo_volqueta").val(parts[1].trim())

                        }
                    }
                });
            } else {
                $("#costo_volqueta").val("0.00")
            }

        })
        $("#cmb_vol").change()
        $("#cmb_chof").change(function () {
            if ($("#cmb_chof").val() != "-1") {
                var datos = "fecha=" + $("#fecha_precios").val() + "&ciudad=" + $("#ciudad").val() + "&ids=" + $("#cmb_chof").val()
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'getPreciosTransporte')}",
                    data     : datos,
                    success  : function (msg) {
                        var precios = msg.split("&")
                        for (i = 0; i < precios.length; i++) {
                            var parts = precios[i].split(";")
                            if (parts.length > 1)
                                $("#costo_chofer").val(parts[1].trim())

                        }
                    }
                });
            } else {
                $("#costo_chofer").val("0.00")
            }

        })
        $("#cmb_chof").change()

        $(".item_row").dblclick(function () {
            var row = $(this)
            var hijos = row.children()
            var desc = $(hijos[1]).html()
            var cant
            var codigo = $(hijos[0]).html()
            var unidad
            var rendimiento
            var item
            var tipo = row.attr("tipo")
            for (i = 2; i < hijos.length; i++) {

                if ($(hijos[i]).hasClass("cant"))
                    cant = $(hijos[i]).html()
                if ($(hijos[i]).hasClass("col_unidad"))
                    unidad = $(hijos[i]).html()
                if ($(hijos[i]).hasClass("col_rend"))
                    rendimiento = $(hijos[i]).attr("valor")
                if ($(hijos[i]).hasClass("col_tarifa"))
                    item = $(hijos[i]).attr("id")
                if ($(hijos[i]).hasClass("col_precioUnit"))
                    item = $(hijos[i]).attr("id")
                if ($(hijos[i]).hasClass("col_jornal"))
                    item = $(hijos[i]).attr("id")

            }
            item = item.replace("i_", "")
            $("#item_cantidad").val(cant.toString().trim())
            if (rendimiento)
                $("#item_rendimiento").val(rendimiento.toString().trim())
            $("#item_id").val(item)
            $("#item_id").attr("tipo",tipo)
            $("#cdgo_buscar").val(codigo)
            $("#item_desc").val(desc)
            $("#item_unidad").val(unidad)
        });

        $("#selClase").change(function () {
            var clase = $(this).val();
            var $subgrupo = $("<select id='selSubgrupo' class='span12'></select>");
            $("#selSubgrupo").replaceWith($subgrupo);
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'gruposPorClase')}",
                data    : {
                    id : clase
                },
                success : function (msg) {
                    $("#selGrupo").replaceWith(msg);
                }
            });
        });
        $("#selGrupo").change(function () {
            var grupo = $(this).val();
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'subgruposPorGrupo')}",
                data    : {
                    id : grupo
                },
                success : function (msg) {
                    $("#selSubgrupo").replaceWith(msg);
                }
            });
        });

        $(".tipoPrecio").click(function () {
            if (!$(this).hasClass("active")) {
                var tipo = $(this).attr("id");
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'ciudadesPorTipo')}",
                    data    : {
                        id : tipo
                    },
                    success : function (msg) {
                        $("#ciudad").replaceWith(msg);
                    }
                });
            }
        });

        $("#calcular").click(function () {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active")
                $(".col_delete").show()
                $(".col_unidad").show()
                $(".col_tarifa").hide()
                $(".col_hora").hide()
                $(".col_total").hide()
                $(".col_jornal").hide()
                $(".col_precioUnit").hide()
                $(".col_vacio").hide()
                $(".total").remove()
                $("#tabla_indi").html("")
                $("#tabla_costos").html("")
                $("#tabla_transporte").html("")
            } else {
                $(this).addClass("active")
                var fecha = $("#fecha_precios").val()

                if (fecha.length < 8) {
                    $.box({
                        imageClass : "box_info",
                        text       : "Seleccione una fecha para determinar la lista de precios",
                        title      : "Alerta",
                        iconClose  : false,
                        dialog     : {
                            resizable : false,
                            draggable : false,
                            buttons   : {
                                "Aceptar" : function () {
                                }
                            },
                            width     : 500
                        }
                    });
                    $(this).removeClass("active")
                } else {
                    var items = $(".item_row")
                    if (items.size() < 1) {
                        $.box({
                            imageClass : "box_info",
                            text       : "Añada items a la composición del rubro antes de calcular los precios",
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                draggable : false,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                },
                                width     : 500
                            }
                        });
                        $(this).removeClass("active")
                    } else {
                        var tipo = "C"
                        if ($("#V").hasClass("active"))
                            tipo = "V"
                        var listas = ""
                        listas += $("#lista_1").val() + "#" + $("#lista_2").val() + "#" + $("#lista_3").val() + "#" + $("#lista_4").val() + "#" + $("#lista_5").val() + "#" + $("#ciudad").val()

                        var datos = "fecha=" + $("#fecha_precios").val() + "&ciudad=" + $("#ciudad").val() + "&tipo=" + tipo + "&listas=" + listas + "&ids="
                        $.each(items, function () {
                            datos += $(this).attr("id") + "#"
                        });
//                        //console.log(datos)
                        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'getPrecios')}",
                            data     : datos,
                            success  : function (msg) {
                                var precios = []
                                precios = msg.split("&")
//                                //console.log(precios)
                                if (precios.length > 1)
                                    for (i = 0; i < precios.length; i++) {

                                        var parts = precios[i].split(";")
                                        var celda = $("#i_" + parts[0])
                                        celda.html(number_format(parts[1], 5, ".", ""))
                                        var padre = celda.parent()
//                                    //console.log(parts,padre)
                                        var celdaRend = padre.find(".col_rend")
                                        var celdaTotal = padre.find(".col_total")
                                        var celdaCant = padre.find(".cant")
                                        var celdaHora = padre.find(".col_hora")
                                        var rend = 1;
                                        if (celdaHora.hasClass("col_hora")) {
                                            celdaHora.html(number_format(parseFloat(celda.html()) * parseFloat(celdaCant.html()), 5, ".", ""))
                                        }
                                        if (celdaRend.html()) {
                                            rend = celdaRend.attr("valor") * 1
//                                            console.log("rend ",celdaRend,rend)
                                        }
                                        celdaTotal.html(number_format(parseFloat(celda.html()) * parseFloat(celdaCant.html()) * parseFloat(rend), 5, ".", ""))

                                    }
                                calcularTotales()

                            }
                        });

                        $(".col_delete").hide()
                        $(".col_tarifa").show()
                        $(".col_hora").show()
                        $(".col_total").show()
                        $(".col_jornal").show()
                        $(".col_precioUnit").show()
                        $(".col_vacio").show()
                    }
                }
            }
        });

        $("#btn_copiarComp").click(function () {
            if ($("#rubro__id").val() * 1 > 0) {

                /*----*/
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'verificaRubro')}",
                    data     : "id=${rubro?.id}",
                    success  : function (msg) {
                        $("#dlgLoad").dialog("close")
                        if(msg=="1"){
                            var d =   $.box({
                                imageClass : "box_info",
                                text       : "Este rubro ya forma parte de una obra.",
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
                                    buttons   : {
                                        "Cancelar":function(){

                                        }
                                    }
                                }
                            });
                        }else{
                            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
                            $("#modalTitle").html("Lista de rubros");
                            $("#modalFooter").html("").append(btnOk);
                            $(".contenidoBuscador").html("")
                            $("#tipos").hide()
                            $("#btn_reporte").show()
                            $("#btn_excel").show()
                            $("#modal-rubro").modal("show");
                            $("#buscarDialog").unbind("click")
                            $("#buscarDialog").bind("click", enviarCopiar)

                        }
                    }
                });
            } else {
                $.box({
                    imageClass : "box_info",
                    text       : "Primero guarde el rubro o seleccione uno para editar",
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        },
                        width     : 500
                    }
                });
            }
        });

        $(".borrarItem").click(function () {
//            $(".item_row").dblclick()
            var tr = $(this).parent().parent()
            var boton = $(this)
            if (confirm("Esta seguro de eliminar este registro? Esta acción es irreversible")) {
                $("#dlgLoad").dialog("open")
                $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'verificaRubro')}",
                    data     : "id=${rubro?.id}",
                    success  : function (msg) {
                        $("#dlgLoad").dialog("close")
                        var resp = msg.split('_')
                        if(resp[0] == "1"){
                            var d =   $.box({
                                imageClass : "box_info",
                                text       : "Este rubro ya forma parte de la(s) obra(s):" + resp[1] + "</br> <strong> * Si desea eliminar el item, necesita crear el historico del rubro </strong>",
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    width: '500px',
                                    draggable : false,
                                    buttons   : {
                                        "Cancelar":function(){

                                        }
                                    }
                                }
                            });
                        }else{
                            $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'eliminarRubroDetalle')}",
                                data     : "id=" + boton.attr("iden"),
                                success  : function (msg) {
                                    if (msg == "Registro eliminado") {
                                        tr.remove()
                                    }

                                    $.box({
                                        imageClass : "box_info",
                                        text       : msg,
                                        title      : "Alerta",
                                        iconClose  : false,
                                        dialog     : {
                                            resizable : false,
                                            draggable : false,
                                            buttons   : {
                                                "Aceptar" : function () {
                                                }
                                            }
                                        }
                                    });
                                }
                            });

                        }
                    }
                });
            }
        });

        $(".infoItem").click(function () {

            var tr = $(this).parent().parent()
            var boton = $(this)

            $("#dlgLoad").dialog("open")
            $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'verificaRubro')}",
                data     : "id=${rubro?.id}",
                success  : function (msg) {
                    $("#dlgLoad").dialog("close")
                    var resp = msg.split('_')
                    if(resp[0] == "1"){
                        var d =   $.box({
                            imageClass : "box_info",
                            text       : "Este rubro forma parte de la(s) obra(s):" + resp[1],
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                width: '500px',
                                draggable : false,
                                buttons   : {
                                    "Cancelar":function(){

                                    }
                                }
                            }
                        });
                    }else{
                        var d =   $.box({
                            imageClass : "box_info",
                            text       : "Este rubro no forma parte de ninguna obra",
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                width: '500px',
                                draggable : false,
                                buttons   : {
                                    "Cancelar":function(){

                                    }
                                }
                            }
                        });
                    }
                }
            });
        });

        $("#btn_lista").click(function () {
            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
            $("#modalTitle").html("Lista de rubros");
            $("#modalFooter").html("").append(btnOk);
            $(".contenidoBuscador").html("")
            $("#tipos").hide()
            $("#btn_reporte").show()
            $("#btn_excel").show()
            $("#modal-rubro").modal("show");
            $("#buscarDialog").unbind("click")
            $("#buscarDialog").bind("click", enviar)
            setTimeout( function() { $( '#criterio' ).focus() }, 500 );
        }); //click btn new

        %{--$("#cdgo_buscar").dblclick(function () {--}%
        %{--    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');--}%
        %{--    $("#modalTitle").html("Lista de items");--}%
        %{--    $("#modalFooter").html("").append(btnOk);--}%
        %{--    $(".contenidoBuscador").html("")--}%
        %{--    $("#tipos").show()--}%
        %{--    $("#btn_reporte").hide()--}%
        %{--    $("#btn_excel").hide()--}%
        %{--    $("#modal-rubro").modal("show");--}%
        %{--    $("#buscarDialog").unbind("click")--}%
        %{--    $("#buscarDialog").bind("click", enviarItem)--}%
        %{--    setTimeout( function() { $( '#criterio' ).focus() }, 500 );--}%
        %{--});--}%

        %{--$("#cdgo_buscar").blur(function () {--}%
        %{--    if ($("#item_id").val() == "" && $("#cdgo_buscar").val() != "") {--}%
        %{--        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'buscarRubroCodigo')}",--}%
        %{--            data     : "codigo=" + $("#cdgo_buscar").val(),--}%
        %{--            success  : function (msg) {--}%
        %{--                if (msg != "-1") {--}%
        %{--                    var parts = msg.split("&&")--}%
        %{--                    $("#item_tipoLista").val(parts[1])--}%
        %{--                    $("#item_id").val(parts[0])--}%
        %{--                    $("#item_desc").val(parts[2])--}%
        %{--                    $("#item_unidad").val(parts[3])--}%
        %{--                } else {--}%
        %{--                    $("#item_tipoLista").val("")--}%
        %{--                    $("#item_id").val("")--}%
        %{--                    $("#item_desc").val("")--}%
        %{--                    $("#item_unidad").val("")--}%
        %{--                }--}%
        %{--            }--}%
        %{--        });--}%
        %{--    }--}%
        %{--});--}%

        $("#cdgo_buscar").keydown(function (ev) {
            if (ev.keyCode * 1 != 9 && (ev.keyCode * 1 < 37 || ev.keyCode * 1 > 40)) {
                $("#item_tipoLista").val("");
                $("#item_id").val("");
                $("#item_desc").val("");
                $("#item_unidad").val("")
            }
        });

        $("#rubro_registro").click(function () {
            if ($(this).hasClass("active")) {
                if (confirm("Esta seguro de desregistrar este rubro?")) {
                    $("#registrado").val("N");
                    $("#fechaReg").val("")
                }
            } else {
                if (confirm("Esta seguro de registrar este rubro?")) {
                    $("#registrado").val("R");
                    var fecha = new Date();
                    $("#fechaReg").val(fecha.toString("dd/mm/yyyy"))
                }
            }
        });

        $("#guardar").click(function () {
            var cod = $("#input_codigo").val();
            var desc = $("#input_descripcion").val();
            var subGr = $("#selSubgrupo").val();
            var msg = "";
            var resp = $("#selResponsable").val();
            var espec = $("#input_codigo_es").val();

            if (cod.trim().length > 30 || cod.trim().length < 2) {
                msg = "<br><strong>Error:</strong> La propiedad código debe tener entre 2 y 30 caracteres."
            }

            if (resp == "-1") {
                msg += "<br><strong>Error:</strong> Seleccione un responsable."
            }

            $.ajax({
                type : "POST",
                url : "${g.createLink(controller: 'rubro', action:'repetido')}",
                async    : false,
                data     : "codigo=" + cod + "&id=" + $("#rubro__id").val(),
                success  : function (retorna) {

                    if (retorna == "no") {
                        msg = "<br><strong>Error:</strong> el código " + cod.toUpperCase() + " está repetido"
                    }
                    if (desc.trim().length > 160 || desc.trim().length < 1) {
                        msg += "<br>La propiedad descripción debe tener entre 1 y 160 caracteres."
                    }

                    if (isNaN(subGr) || subGr * 1 < 1) {
                        msg += "<br>Seleccione un subgrupo usando las listas de Dirección, Grupo y Subgrupo"
                    }

                    if (msg != "") {
                        $.box({
                            imageClass : "box_info",
                            text       : msg,
                            title      : "Errores de validación",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                draggable : false,
                                width     : 500,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                }
                            }
                        });
                    } else {
                        $("#frmRubro").submit()
                    }
                }
            });
        });

        <g:if test="${rubro}">
        $("#btn_agregarItem").click(function () {
            if($('#item_desc').val().length == 0)  {
                $.box({
                    imageClass : "box_info",
                    text       : "No hay item que agregar al APU",
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        }
                    }
                });
                return false
            }
            if ($("#calcular").hasClass("active")) {
                $.box({
                    imageClass : "box_info",
                    text       : "Antes de agregar items, por favor desactive la opción calcular precios en el menú superior.",
                    title      : "Alerta",
                    iconClose  : false,
                    dialog     : {
                        resizable : false,
                        draggable : false,
                        buttons   : {
                            "Aceptar" : function () {
                            }
                        }
                    }
                });
                return false
            }
            $("#dlgLoad").dialog("open")
            $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'verificaRubro')}",
                data     : "id=${rubro?.id}",
                success  : function (msg) {
                    $("#dlgLoad").dialog("close")
                    var resp = msg.split('_')
                    if(resp[0] == "1"){
                        var d =   $.box({
                            imageClass : "box_info",
                            text       : "Este rubro ya forma parte de la(s) obra(s):" + resp[1] + "Desea crear una nueva versión de este rubro, y hacer una versión histórica?",
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable : false,
                                width: '500px',
                                draggable : false,
                                buttons   : {
                                    "Cancelar":function(){

                                    },
                                    "Aceptar" : function () {
                                        $("#dlgLoad").dialog("open")
                                        $.ajax({type : "POST", url : "${g.createLink(controller: 'rubro',action:'copiaRubro')}",
                                            data     : "id=${rubro?.id}",
                                            success  : function (msg) {
                                                $("#dlgLoad").dialog("close")
                                                if(msg=="true"){
                                                    alert("Error al generar historico del rubro, comunique este error al administrador del sistema")
                                                }else{
                                                    $("#boxHiddenDlg").dialog("close")
                                                    agregar(msg,"H");

                                                }
                                            }
                                        });
                                    }

                                }
                            }
                        });
                    }else{
                        agregar('${rubro?.id}',"");
                    }
                }
            });
        });
        </g:if>
        <g:else>
        $("#btn_agregarItem").click(function () {
            $.box({
                imageClass : "box_info",
                text       : "Primero guarde el rubro o seleccione uno para editar",
                title      : "Alerta",
                iconClose  : false,
                dialog     : {
                    resizable : false,
                    draggable : false,
                    buttons   : {
                        "Aceptar" : function () {
                        }
                    },
                    width     : 500
                }
            });
        });
        </g:else>

        $("#imprimirTransporteDialog").dialog({

            autoOpen  : false,
            resizable : false,
            modal     : true,
            dragable  : false,
            width     : 470,
            height    : 200,
            position  : 'center',
            title     : 'Imprimir Rubro',
            buttons   : {
                "Si VAE" : function () {
                    var dsp0 = $("#dist_p1").val();
                    var dsp1 = $("#dist_p2").val();
                    var dsv0 = $("#dist_v1").val();
                    var dsv1 = $("#dist_v2").val();
                    var dsv2 = $("#dist_v3").val();
                    var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val()
                    var volqueta = $("#costo_volqueta").val();
                    var chofer = $("#costo_chofer").val();
                    var fechaSalida = $("#fechaSalidaId").val();

                    datos = "dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2
                        + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val()
                        + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof=" + $("#cmb_chof").val() + "&volq="
                        + $("#cmb_vol").val() + "&indi=" + $("#costo_indi").val() + "&fechaSalida=" + fechaSalida;
                    location.href = "${g.createLink(controller: 'reportesRubros',action: 'reporteRubrosV2')}?" + datos;

                    $("#imprimirTransporteDialog").dialog("close");
                },
                "No VAE" : function () {
                    var dsp0 = $("#dist_p1").val();
                    var dsp1 = $("#dist_p2").val();
                    var dsv0 = $("#dist_v1").val();
                    var dsv1 = $("#dist_v2").val();
                    var dsv2 = $("#dist_v3").val();
                    var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val();
                    var volqueta = $("#costo_volqueta").val();
                    var chofer = $("#costo_chofer").val();
                    var fechaSalida = $("#fechaSalidaId").val();

                    datos = "dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2
                        + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val()
                        + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof=" + $("#cmb_chof").val() + "&volq="
                        + $("#cmb_vol").val() + "&indi=" + $("#costo_indi").val() + "&trans=no" + "&fechaSalida=" + fechaSalida;
                    location.href = "${g.createLink(controller: 'reportesRubros',action: 'reporteRubrosV2')}?" + datos;

                    $("#imprimirTransporteDialog").dialog("close");
                },
                "Si" : function () {
                    var dsp0 = $("#dist_p1").val();
                    var dsp1 = $("#dist_p2").val();
                    var dsv0 = $("#dist_v1").val();
                    var dsv1 = $("#dist_v2").val();
                    var dsv2 = $("#dist_v3").val();
                    var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val();
                    var volqueta = $("#costo_volqueta").val();
                    var chofer = $("#costo_chofer").val();
                    var fechaSalida = $("#fechaSalidaId").val();

                    datos = "dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2
                        + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val()
                        + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof="
                        + $("#cmb_chof").val() + "&volq=" + $("#cmb_vol").val() + "&indi=" + $("#costo_indi").val() + "&fechaSalida=" + fechaSalida;
                    location.href = "${g.createLink(controller: 'reportesRubros',action: 'reporteRubrosTransporteV2')}?" + datos;

                    $("#imprimirTransporteDialog").dialog("close");
                },
                "No" : function () {
                    var dsp0 = $("#dist_p1").val();
                    var dsp1 = $("#dist_p2").val();
                    var dsv0 = $("#dist_v1").val();
                    var dsv1 = $("#dist_v2").val();
                    var dsv2 = $("#dist_v3").val();
                    var listas = $("#lista_1").val() + "," + $("#lista_2").val() + "," + $("#lista_3").val() + "," + $("#lista_4").val() + "," + $("#lista_5").val() + "," + $("#ciudad").val();
                    var volqueta = $("#costo_volqueta").val();
                    var chofer = $("#costo_chofer").val();
                    var fechaSalida = $("#fechaSalidaId").val();

                    datos = "dsp0=" + dsp0 + "&dsp1=" + dsp1 + "&dsv0=" + dsv0 + "&dsv1=" + dsv1 + "&dsv2=" + dsv2 + "&prvl=" + volqueta + "&prch=" + chofer + "&fecha=" + $("#fecha_precios").val()
                        + "&id=${rubro?.id}&lugar=" + $("#ciudad").val() + "&listas=" + listas + "&chof=" + $("#cmb_chof").val() + "&volq=" + $("#cmb_vol").val()
                        + "&indi=" + $("#costo_indi").val() + "&trans=no" + "&fechaSalida=" + fechaSalida;
                    location.href = "${g.createLink(controller: 'reportesRubros',action: 'reporteRubrosTransporteV2')}?" + datos;


                    $("#imprimirTransporteDialog").dialog("close");
                },
                "Cancelar" :  function () {
                    $("#imprimirTransporteDialog").dialog("close");
                }
            }
        });
    });
</script>
</body>
</html>