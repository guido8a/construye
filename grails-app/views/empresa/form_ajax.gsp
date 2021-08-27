<%@ page import="janus.construye.Empresa" %>

<g:if test="${!empresaInstance}">
    <elm:notFound elem="Empresa" genero="o" />
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmSave-Empresa" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${empresaInstance?.id}" />

            <table cellpadding="5">
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Nombre
                        </span>
                    </td>
                    <td colspan="4">
                        <g:textField name="nombre" maxlength="63" required="" class="form-control required" value="${empresaInstance?.nombre}" style="width: 630px;"/>
                        <p class="help-block ui-helper-hidden"></p>
                        <span class="mandatory">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            RUC
                        </span>
                    </td>
                    <td width="250px">
                        <g:textField name="ruc" maxlength="13" minlength="10" required="" class="allCaps form-control required" value="${empresaInstance?.ruc}"/>
                        <p class="help-block ui-helper-hidden"></p>
                        <span class="mandatory">*</span>
                    </td>
                    <td width="100px">
                        <span class="control-label label label-inverse">
                            Sigla
                        </span>
                    </td>
                    <td>
                        <g:textField name="sigla" maxlength="8" class="allCaps form-control" value="${empresaInstance?.sigla}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Descripción
                        </span>
                    </td>
                    <td colspan="4">
                        <g:textField name="descripcion"  maxlength="255" class=" required form-control" value="${empresaInstance?.descripcion}"  style="width: 630px;"/>
                        <p class="help-block ui-helper-hidden"></p>
                        <span class="mandatory">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Dirección
                        </span>
                    </td>
                    <td colspan="4">
                        <g:textArea name="direccion"  maxlength="255" class=" form-control" value="${empresaInstance?.direccion}"  style="width: 630px; resize: none"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Ciudad
                        </span>
                    </td>
                    <td colspan="2">
                        <g:textField name="lugar" maxlength="63" class="required form-control" value="${empresaInstance?.lugar}" style="width: 210px;"/>
                        <p class="help-block ui-helper-hidden"></p>
                        <span class="mandatory">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Teléfono
                        </span>
                    </td>
                    <td width="250px">
                        <g:textField name="telefono" class="form-control" value="${empresaInstance?.telefono}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </td>
                    <td width="100px">
                        <span class="control-label label label-inverse">
                            Email
                        </span>
                    </td>
                    <td>
                        <g:textField name="email" maxlength="63" class="email mail form-control" value="${empresaInstance?.email}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <span class="control-label label label-inverse">
                            Observaciones
                        </span>
                    </td>
                    <td colspan="4">
                        <g:textArea name="observaciones"  maxlength="255" class=" form-control" value="${empresaInstance?.observaciones}"  style="width: 630px; resize: none"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </td>
                </tr>
            </table>



        %{--            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaInicio', 'error')} ">--}%
        %{--                <span class="grupo">--}%
        %{--                    <label for="fechaInicio" class="col-md-2 control-label">--}%
        %{--                        Fecha Inicio--}%
        %{--                    </label>--}%
        %{--                    <div class="col-md-5">--}%
        %{--                        <elm:datepicker name="fechaInicio"  class="datepicker form-control" value="${empresaInstance?.fechaInicio}" default="none" noSelection="['': '']" />--}%
        %{--                    </div>--}%

        %{--                </span>--}%
        %{--            </div>--}%

        %{--            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaFin', 'error')} ">--}%
        %{--                <span class="grupo">--}%
        %{--                    <label for="fechaFin" class="col-md-2 control-label">--}%
        %{--                        Fecha Fin--}%
        %{--                    </label>--}%
        %{--                    <div class="col-md-5">--}%
        %{--                        <elm:datepicker name="fechaFin"  class="datepicker form-control" value="${empresaInstance?.fechaFin}" default="none" noSelection="['': '']" />--}%
        %{--                    </div>--}%

        %{--                </span>--}%
        %{--            </div>--}%


        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmEmpresa").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            }

            %{--, rules          : {--}%

            %{--    email: {--}%
            %{--        remote: {--}%
            %{--            url: "${createLink(action: 'validar_unique_email_ajax')}",--}%
            %{--            type: "post",--}%
            %{--            data: {--}%
            %{--                id: "${empresaInstance?.id}"--}%
            %{--            }--}%
            %{--        }--}%
            %{--    }--}%

            %{--},--}%
            %{--messages : {--}%

            %{--    email: {--}%
            %{--        remote: "Ya existe Email"--}%
            %{--    }--}%

            %{--}--}%

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormEmpresa();
                return false;
            }
            return true;
        });
    </script>

</g:else>