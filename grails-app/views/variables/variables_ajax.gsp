<style type="text/css">
.tab {
    height     : 415px !important;
    overflow-x : hidden;
    overflow-y : hidden;
}

.inputVar {
    width : 65px;
}

.ui-front {
    z-index: 1060 !important;
}

.margen {
    margin-left : 40px;
    width       : 500px;
}

</style>

<g:form controller="variables" action="saveVar_ajax" name="frmSave-var">
    <g:hiddenField name="id_lgarMO" value="${obra?.listaManoObra?.id}"/>
    <div id="tabs" style="height: 465px;">
        <ul>
            <li><a href="#tab-transporte">Transporte</a></li>
            <li><a href="#tab-precios">Precios</a></li>
            <li><a href="#tab-factores">Factores</a></li>
            <li><a href="#tab-indirecto">Costos Indirectos</a></li>
            <li class="desglose"><a href="#tab-desglose">Desglose Eq. FP</a></li>
            <li class="especial"><a href="#tab-especial">Tranp. Especial</a></li>
        </ul>

        <div id="tab-transporte" class="tab">
            <div class="row-fluid">
                <div class="span2">
                    Vehículo
                </div>

                <div class="span6">
                    <g:select name="volquete.id" id="cmb_vol" from="${volquetes2}" optionKey="id" optionValue="nombre" class="num"
                              noSelection="${['': 'Seleccione']}" value="${(obra.volquete) ? obra?.volqueteId : par?.volquete?.id}"
                              style="width: 300px; margin-left: -30px"/>
                </div>

                <div class="span1" style="margin-left: -20px;">
                    Costo
                </div>

                <div class="span2">
                    <g:textField class="inputVar num" style="width: 80px" disabled="" name="costo_volqueta" value=""/>
                </div>

                <div class="span1">
                    <g:textField name="unidad_volqueta" id="uni_vol" value="${(obra.volquete?.unidad) ? obra?.volquete?.unidad : par?.volquete?.unidad}" readonly="true" style="width: 20px; margin-left: 5px"/>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span2">
                    Chofer
                </div>

                <div class="span6">
                    <g:select name="chofer.id" id="cmb_chof" from="${choferes}" optionKey="id" optionValue="nombre" class="num"
                              noSelection="${['': 'Seleccione']}" value="${(obra.chofer) ? obra?.choferId : par?.chofer?.id}"
                              style="width: 300px; margin-left: -30px"/>
                </div>

                <div class="span1" style="margin-left: -20px;">
                    Costo
                </div>

                <div class="span2">
                    <g:textField class="inputVar num" name="costo_chofer" disabled="" style="width: 80px"/>
                </div>

                <div class="span1">
                    <g:textField name="unidad_chofer" id="uni_chof" value="${(obra.chofer?.unidad) ? obra?.chofer?.unidad : par?.chofer?.unidad}" readonly="true" style="width: 20px; margin-left: 5px"/>
                </div>
            </div>


            <div class="span6" style="margin-bottom: 20px; margin-top: 5px">
                <div class="span3" style="font-weight: bold;">
                    Distancias al Peso
                </div>

                <div class="span2" style="font-weight: bold;">
                    Distancias al Volumen
                </div>
            </div>


            <div class="row-fluid">
                <div class="span3">
                    Capital de Cantón (km)
                </div>

                <div class="span2">
                    <g:textField type="text" name="distanciaPeso" class="inputVar num"
                                 value="${g.formatNumber(number: obra?.distanciaPeso, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"
                                 title="Distancia de la Obra a la capital del Cantón"/>
                </div>

                <div class="span5">
                    Pétreos para Hormigones (km)
                </div>

                <div class="span1">
                    <g:textField type="text" name="distanciaVolumen" class="inputVar num"
                                 value="${g.formatNumber(number: obra?.distanciaVolumen, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"
                                 title="Distancia de la Obra a la mina"/>
                </div>

            </div>

            <div class="row-fluid">

                <div class="span3">
                    Especial (km)
                </div>

                <div class="span2">
                    <g:textField type="text" name="distanciaPesoEspecial" class="inputVar num"
                                 value="${g.formatNumber(number: obra?.distanciaPesoEspecial, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"
                                 title="Distancia de la Obra a la fábrica o proveedor especial"/>
                </div>

                <div class="span5">
                    Pétreos para Mejoramiento (km)
                </div>

                <div class="span1">
                    <g:textField type="text" name="distanciaVolumenMejoramiento" class="inputVar num"
                                 value="${g.formatNumber(number: obra?.distanciaVolumenMejoramiento, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"
                                 title="Distancia de la Obra a la mina"/>
                </div>
            </div>

            <div class="row-fluid">

                <div class="span3"></div>
                <div class="span2"></div>
                <div class="span5">
                    Pétreos para Carpeta Asfáltica (km)
                </div>

                <div class="span1">
                    <g:textField type="text" name="distanciaVolumenCarpetaAsfaltica" class="inputVar num"
                                 value="${g.formatNumber(number: obra?.distanciaVolumenCarpetaAsfaltica, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"
                                 title="Distancia de la Obra a la mina"/>
                </div>

            </div>

            <div style="margin: 5px; font-weight: bold; text-align: center">
                Listas de Precios para Peso y Volumen
            </div>

            <div class="row-fluid" style="margin-top: 10px; width: 640px">

                <div class="span2" style="width: 70px;">
                    Cantón
                </div>

                <div class="span4">
                    <g:select name="lugar.id" from="${janus.Lugar.findAll('from Lugar  where tipoLista=1')}"
                              optionKey="id" optionValue="descripcion" value="${obra?.lugar?.id}" class="span10"
                              noSelection="['null': 'Seleccione...']"/>
                </div>

                <div class="span4" style="margin-left: -20px; width: 150px;">
                    Petreos Hormigones
                </div>

                <div class="span4">
                    <g:select name="listaVolumen0.id" from="${janus.Lugar.findAll('from Lugar  where tipoLista=3')}"
                              optionKey="id" optionValue="descripcion" value="${obra?.listaVolumen0?.id}"
                              class="span10" noSelection="['null': 'Seleccione...']" style="margin-left: -10px;"/>
                </div>

            </div>

            <div class="row-fluid" style="margin-top: 10px; width: 640px">

                <div class="span2" style="width: 70px;">
                    Especial
                </div>

                <div class="span4">
                    <g:select name="listaPeso1.id" from="${janus.Lugar.findAll('from Lugar  where tipoLista=2')}"
                              optionKey="id" optionValue="descripcion" value="${obra?.listaPeso1?.id}" class="span10"
                              noSelection="['null': 'Seleccione...']"/>
                </div>

                <div class="span4" style="margin-left: -20px; width: 150px;">
                    Mejoramiento
                </div>

                <div class="span4">
                    <g:select name="listaVolumen1.id" from="${janus.Lugar.findAll('from Lugar  where tipoLista=4')}"
                              optionKey="id" optionValue="descripcion" value="${obra?.listaVolumen1?.id}"
                              class="span10" noSelection="['null': 'Seleccione...']" style="margin-left: -10px;"/>
                </div>

            </div>

            <div class="row-fluid" style="margin-top: 10px; width: 640px">

                <div class="span3" style="margin-left: 265px">
                    Carpeta Asfáltica
                </div>

                <div class="span4">
                    <g:select name="listaVolumen2.id" from="${janus.Lugar.findAll('from Lugar  where tipoLista=5')}"
                              optionKey="id" optionValue="descripcion" value="${obra?.listaVolumen2?.id}"
                              class="span10" noSelection="['null': 'Seleccione...']"/>
                </div>

            </div>

        </div>

        <div id="tab-precios" class="tab">
            <div class="row-fluid margen" style="margin-top: 20px;">
                <div class="span5">
                    Porcentaje para Mano de Obra
                </div>

                <div class="span2" style="display: inline-block">
                    <g:textField type="text" name="precioManoObra" class="inputVar num"
                                 value="${obra?.precioManoObra}"/>
                </div>
                <div class="span2" style="display: inline-block">
                    %
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Porcentaje para Materiales
                </div>

                <div class="span2">
                    <g:textField type="text" name="precioMateriales" class="inputVar num"
                                 value="${obra?.precioMateriales}"/>
                </div>
                <div class="span2" style="display: inline-block">
                    %
                </div>

            </div>

            <div class="row-fluid margen" style="margin-top: 60px; color: #0c4c85">
                <div class="span8">
                    Lista de precios seleccionada para Mano de Obra:
                </div>

                <div class="span4" style="border-radius: 4px; border-color: #444; border-style: solid; border-width: 1px">
                    ${obra?.listaManoObra.descripcion}
                </div>
            </div>

            <div class="row-fluid margen" style="margin-top: 20px; color: #0c4c85">
                <div class="span8">
                    Lista de precios seleccionada para Materiales:
                </div>

                <div class="span4" style="border-radius: 4px; border-color: #444; border-style: solid; border-width: 1px">
                    ${obra?.lugar.descripcion}
                </div>
            </div>

%{--
            <div class="row-fluid margen" style="margin-top: 60px">
                <div class="span6">
                    <g:link controller="variables" action="actualizaPrecios"
                            id="${obra.id}" style="color: #fff"
                            class="btn btn-info"><i class="icon-ok"></i> Actualizar Precios</g:link></div>
            </div>
--}%

        </div>

        <div id="tab-factores" class="tab">
            <div class="row-fluid margen" style="margin-top: 20px;">
                <div class="span5">
                    Factor de reducción
                </div>

                <div class="span2">
                    <g:textField type="text" name="factorReduccion" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.factorReduccion) ?: par.factorReduccion.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Velocidad
                </div>

                <div class="span2">
                    <g:textField type="text" name="factorVelocidad" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.factorVelocidad) ?: par.factorVelocidad.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Capacidad Volquete
                </div>

                <div class="span2">
                    <g:textField type="text" name="capacidadVolquete" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.capacidadVolquete) ?: par.capacidadVolquete.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">

                <div class="span5">
                    Factor Tiempo
                </div>

                <div class="span2">
                    <g:textField type="text" name="factorReduccionTiempo" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.factorReduccionTiempo) ?: par.factorReduccionTiempo.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Factor Volumen
                </div>

                <div class="span2">
                    <g:textField type="text" name="factorVolumen" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.factorVolumen) ?: par.factorVolumen.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Factor Peso
                </div>

                <div class="span2">
                    <g:textField type="text" name="factorPeso" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.factorPeso) ?: par.factorPeso.replace('.',','), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>
        </div>

        <div id="tab-indirecto" class="tab">
            <div class="row-fluid" style="margin-top: 20px;">
                <div class="span4">
                    Dirección de la obra
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosObra" class="inputVar sum2 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosObra), maxFractionDigits: 2,
                                         minFractionDigits: 2, format: '##,##0')}" tabindex="1"/>
                </div>

                <div class="span4">
                    Garantías
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosGarantias" class="inputVar num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosGarantias),
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="7"/>
                </div>
            </div>

            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span4">
                    Cargos Administrativos
                </div>

                <div class="span2">
                    <g:textField type="text" name="administracion" class="inputVar sum1 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.administracion), maxFractionDigits: 2,
                                         minFractionDigits: 2, format: '##,##0')}" tabindex="2"/>
                </div>

                <div class="span4">
                    Seguros
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceSeguros" class="inputVar  num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceSeguros),
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" />
                </div>
            </div>

            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span4">
                    Locales provisionales
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceAlquiler" class="inputVar sum1 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceAlquiler), maxFractionDigits: 2,
                                         minFractionDigits: 2, format: '##,##0')}" tabindex="3"/>
                </div>

                <div class="span4">
                    Costos financieros
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosCostosFinancieros" class="inputVar num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosCostosFinancieros),
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="8"/>
                </div>
            </div>

            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span4">
                    Vehículos
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosVehiculos" class="inputVar sum1 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosVehiculos),
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="4"/>
                </div>

                <div class="span4">
                    Prevención de accidentes
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceSeguridad" class="inputVar num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceSeguridad), maxFractionDigits: 2,
                                         minFractionDigits: 2, format: '##,##0')}" tabindex="9"/>
                </div>
            </div>

%{--
            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span4">
                    Seguros
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceSeguros" class="inputVar sum1 num"
                                 value="${g.formatNumber(number: (obra?.indiceSeguros), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="5"/>
                </div>

                <div class="span4 bold" style="border-top: solid 1px #D3D3D3;">
                    Gasto Administración de Campo
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceGastoObra" style="font-weight: bold" class="inputVar sum2 num"
                                 value="${g.formatNumber(number: (total2), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="10" readonly=""/>
                </div>
            </div>
--}%

            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span4">
                    Servicios públicos
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosTimbresProvinciales" class="inputVar sum1 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosTimbresProvinciales),
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}" tabindex="6"/>
                </div>

                <div class="span4 bold">
                    Gasto Administración de Obra
                </div>
            <div class="span2">
                <g:textField type="text" name="indiceGastoObra" style="font-weight: bold" class="inputVar sum2 num"
                             value="${g.formatNumber(number: (total1), maxFractionDigits: 2, minFractionDigits: 2,
                                     format: '##,##0')}" tabindex="10" readonly=""/>
            </div>
        </div>
%{--
            </div>

                <div class="span2">
                    <g:textField type="text" name="impreso" class="inputVar sum2 num"
                                 value="${g.formatNumber(number: (obra?.impreso) ?: 0, maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>
--}%

            <div class="row-fluid"  style="margin-top: 10px;">
                <div class="span4">
                    Promoción
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceCostosIndirectosPromocion" class="inputVar sum2 num sumAO sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceCostosIndirectosPromocion) ?: 0,
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>

                <div class="span4">
                    Utilidad
                </div>

                <div class="span2">
                    <g:textField type="text" name="indiceUtilidad" class="inputVar sum2 num sumTI"
                                 value="${g.formatNumber(number: (obra?.indiceUtilidad) ?: 0,
                                         maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid"  style="margin-top: 10px;">
                <div class="span4">
                </div>

                <div class="span2">
                </div>

                <div class="span4 bold" style="border-top: solid 1px #D3D3D3;">
                    Costo total de Indirectos
                </div>

                <div class="span2">
                    <g:textField type="text" style="font-weight: bold" name="totales" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.totales) ?: 0, maxFractionDigits: 2,
                                         minFractionDigits: 2, format: '##,##0')}" readonly=""/>
                </div>
            </div>

            <div class="row-fluid" style="margin-top: 10px;">
                <div class="span2" style="margin-left: 0px; width: 160px;">
                    <g:link controller="reportes2" action="reporteCostosIndirectosNuevo"
                    id="${obra.id}" style="margin-left: 0px; margin-top: -60px; color: #fff"
                    class="btn btn-info"><i class="icon-print"></i> Desglose</g:link></div>

            </div>
        </div>

        <div id="tab-desglose" class="tab">

            <div class="row-fluid margen">
                <div class="span5">
                    Equipos
                </div>

                <div class="span2">
                    <g:textField type="text" name="desgloseEquipo" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.desgloseEquipo), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Repuestos
                </div>

                <div class="span2">
                    <g:textField type="text" name="desgloseRepuestos" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.desgloseRepuestos), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>


            <div class="row-fluid margen">
                <div class="span5">
                    Combustibles
                </div>

                <div class="span2">
                    <g:textField type="text" name="desgloseCombustible" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.desgloseCombustible), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">

                <div class="span5">
                    Mecánico
                </div>

                <div class="span2">
                    <g:textField type="text" name="desgloseMecanico" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.desgloseMecanico), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>
            </div>

            <div class="row-fluid margen">
                <div class="span5">
                    Saldo
                </div>

                <div class="span2">
                    <g:textField type="text" name="desgloseSaldo" class="inputVar num"
                                 value="${g.formatNumber(number: (obra?.desgloseSaldo), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>

            </div>

            <div class="row-fluid margen" style="margin-bottom: 5px">
                ______________________________________

            </div>

            <div class="row-fluid margen">

                <div class="span5">
                    Total Desglose:
                </div>

                <div class="span2">
                    %{--<g:textField type="text" name="totalDesglose" class="inputVar num" value="${g.formatNumber(number: (obra?.desgloseSaldo + obra?.desgloseMecanico + obra?.desgloseCombustible + obra?.desgloseRepuestos + obra?.desgloseEquipo), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0', locale: 'ec')}"/>--}%
                    <input type="text" id="totalDesglose" class="inputVar num" value="0.0" readonly/>
                </div>
            </div>
        </div>

        %{--/* TODO: poner en obra los id de los item de tranposte camioneta y transporte acemila */--}%
        <div id="tab-especial" class="tab">
            <div class="row-fluid">
                <div class="span3">
                    Transporte Camioneta
                </div>

                <div class="span6">
                    %{--<g:select name="transporteCamioneta.id" id="trcm" from="${transporteCamioneta}" optionKey="id" optionValue="nombre"--}%
                    <g:select name="transporteCamioneta.id" from="${transporteCamioneta}" optionKey="id" optionValue="nombre" id="transporteCam"
                              value="${obra?.transporteCamioneta?.id}" style="width: 300px; margin-left: -10px" noSelection="${['null': 'Seleccione']}"/>
                </div>

                <div class="span2">
                    %{--<g:textField class="inputVar num2" name="distanciaCamioneta" style="width: 60px" type="number" maxlength="12" value="${obra?.distanciaCamioneta}"/>--}%
                    <g:textField class="inputVar num3" name="distanciaCamioneta" style="width: 60px" type="number" maxlength="6"
                                 value="${g.formatNumber(number: (obra?.distanciaCamioneta), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>

                <div class="span1">
                    <g:textField name="unidad_camioneta" id="uni_trcm" value="${"Km"}" readonly="true" style="width: 30px; margin-left: 5px"/>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span3">
                    Transporte Acémila
                </div>

                <div class="span6">
                    %{--<g:select name="transporteAcemila.id" id="trac" from="${transporteAcemila}" optionKey="id" optionValue="nombre"--}%
                    <g:select name="transporteAcemila.id" from="${transporteAcemila}" optionKey="id" optionValue="nombre"  id="transporteAce"
                              value="${obra?.transporteAcemila?.id}" style="width: 300px; margin-left: -10px" noSelection="${['null': 'Seleccione']}"/>
                </div>

                <div class="span2">
                    <g:textField class="inputVar num3" name="distanciaAcemila" style="width: 60px" type="number" maxlength="6"
                                 value="${g.formatNumber(number: (obra?.distanciaAcemila), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>

                <div class="span1">
                    <g:textField name="unidad_acemila" id="uni_trac" value="${"Km"}" readonly="true" style="width: 30px; margin-left: 5px"/>
                </div>
            </div>
            <div class="row-fluid" style="margin-top: 20px">
                <div class="span9">
                    Distancia de desalojo de materiales
                </div>

                <div class="span2">
                    <g:textField class="inputVar num3" name="distanciaDesalojo" style="width: 60px" type="number" maxlength="6"
                                 value="${g.formatNumber(number: (obra?.distanciaDesalojo), maxFractionDigits: 2, minFractionDigits: 2, format: '##,##0')}"/>
                </div>

                <div class="span1">
                    <g:textField name="unidad_camioneta" id="uni_trcm" value="${"Km"}" readonly="true" style="width: 30px; margin-left: 5px"/>
                </div>
            </div>

        </div>

    </div>
</g:form>




<script type="text/javascript">

    function validarNum(ev) {
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
        ev.keyCode == 190 || ev.keyCode == 110 ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 188 );
    }

    $(".sum1, .sum2, .num, .sumAO, sumTI").keydown(function (ev) {
        if (ev.keyCode == 190 || ev.keyCode == 188) {
            if ($(this).val().indexOf(".") > -1) {
                return false
            }
        }
        return validarNum(ev);
    });

    $(".num2").keydown(function (ev) {
        if (ev.keyCode == 190 || ev.keyCode == 188 || ev.keyCode == 110) {
            if ($(this).val().indexOf(".") > -1) {
                return false
            }
        }
        return validarNum(ev);
    });

    $(".num3").bind({
        keydown : function (ev) {
            // esta parte valida el punto: si empieza con punto le pone un 0 delante, si ya hay un punto lo ignora
            if (ev.keyCode == 190 || ev.keyCode == 110) {
                var val = $(this).val();
                if (val.length == 0) {
                    $(this).val("0");
                }
                return val.indexOf(".") == -1;
            } else {
                // esta parte valida q sean solo numeros, punto, tab, backspace, delete o flechas izq/der
                return validarNum(ev);
            }
        }, //keydown
        keyup   : function () {
            var val = $(this).val();
            // esta parte valida q no ingrese mas de 2 decimales
            var parts = val.split(".");
            if (parts.length > 1) {
                if (parts[1].length > 2) {
                    parts[1] = parts[1].substring(0, 2);
                    val = parts[0] + "." + parts[1];
                    $(this).val(val);
                }
            }
        }
    });

    function suma(items, update) {
        var sum1 = 0;
        items.each(function () {
            sum1 += parseFloat($(this).val().replace(',', '.'));
        });
        update.val(number_format(sum1, 2, ".", ""));
    }

    function costoItem($campo, $update) {
        var id = $campo.val();
        var fecha = $("#fechaPreciosRubros").val();
        /*var ciudad = $("#lugar\\.id").val();*/
        var ciudad = $("#id_lgarMO").val();
//        ////console.log(id, fecha, ciudad);
        if (id != "" && fecha != "" && ciudad != "") {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action:'getPreciosTransporte')}",
                data    : {
                    fecha  : fecha,
                    ciudad : ciudad,
                    ids    : id
                },
                success : function (msg) {
                    var precios = msg.split("&");
                    for (var i = 0; i < precios.length; i++) {
                        if ($.trim(precios[i]) != "") {
                            var parts = precios[i].split(";");
                            if (parts.length > 1) {
                                $update.val(parts[1].toString().trim());
                            }
                        }
                    }
                }
            });
        } else {
            $update.val("0.00");
        }
    }

    function unidadItem($campo, $update) {
        var id = $campo.val();
        if (id != "") {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action:'getUnidad')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    $update.val(msg.toString().trim());
                }
            })

        } else {

            $update.val(" ");
        }

    }

    $(function () {
        $(".sumAO").keyup(function (ev) {
            suma($(".sumAO"), $("#indiceGastoObra"));
        }).blur(function () {
            suma($(".sumAO"), $("#indiceGastoObra"));
        });

        $(".sumAO").blur();


        $(".sumTI").keyup(function (ev) {
            suma($(".sumTI"), $("#totales"));
        }).blur(function () {
            suma($(".sumTI"), $("#totales"));
        });

        $(".sumTI").blur();


        $("#tabs").tabs({
            heightStyle : "fill"
        });


        costoItem($("#cmb_vol"), $("#costo_volqueta"));
        costoItem($("#cmb_chof"), $("#costo_chofer"));

        $("#cmb_vol").change(function () {
            costoItem($(this), $("#costo_volqueta"));
            unidadItem($(this), $("#uni_vol"))
        });
        $("#cmb_chof").change(function () {
            costoItem($(this), $("#costo_chofer"));
            unidadItem($(this), $("#uni_chof"))
        });
    });

    $(function () {
        $(".desglose").click(function () {
            sumaDesglose();
        });
        $("#desgloseEquipo").keyup(function () {
            sumaDesglose();
        });
        $("#desgloseRepuestos").keyup(function () {
            sumaDesglose();
        });
        $("#desgloseCombustible").keyup(function () {
            sumaDesglose();
        });
        $("#desgloseMecanico").keyup(function () {
            sumaDesglose();
        });
        $("#desgloseSaldo").keyup(function () {
            sumaDesglose();
        });
    });

    function sumaDesglose() {
        var smDesglose = 0.0
        //console.log("sumadesglose")
        smDesglose = parseFloat($("#desgloseEquipo").val().replace(',', '.')) + parseFloat($("#desgloseRepuestos").val().replace(',', '.')) +
        parseFloat($("#desgloseCombustible").val().replace(',', '.')) + parseFloat($("#desgloseMecanico").val().replace(',', '.')) +
        parseFloat($("#desgloseSaldo").val().replace(',', '.'))
        console.log('deasglose:', $("#desgloseEquipo").val(), smDesglose)
        $("#totalDesglose").val(number_format(smDesglose, 3, ",", ""));
    }




</script>