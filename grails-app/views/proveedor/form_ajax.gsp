
<%@ page import="janus.pac.Proveedor" %>

<div id="create-Proveedor" class="span" role="main">
<g:form class="form-horizontal" name="frmSave-Proveedor" action="save">
    <g:hiddenField name="id" value="${proveedorInstance?.id}"/>

    <table cellpadding="5">
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Especialidad
                </span>
            </td>
            <td width="250px">
                <g:select id="especialidad" name="especialidad.id" from="${janus.EspecialidadProveedor.list()}" optionKey="id" optionValue="descripcion" class="many-to-one " value="${proveedorInstance?.especialidad?.id}"/>
                <p class="help-block ui-helper-hidden"></p>
                <span class="mandatory">*</span>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                    Tipo
                </span>
            </td>
            <td>
                <g:select id="tipo" name="tipo.id" from="${['J' : 'Jurídica', 'N': 'Natural', 'E' : 'Empresa Pública']}" optionKey="key" optionValue="value" class="many-to-one " value="${proveedorInstance?.tipo}"/>
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
                <g:textField name="ruc" maxlength="13" class="required" value="${proveedorInstance?.ruc}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                    Estado
                </span>
            </td>
            <td>
                <g:select name="estado" from="${[1 : 'Activo', 0: 'Inactivo']}" optionKey="key" optionValue="value" class="many-to-one " value="${proveedorInstance?.estado}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Nombre
                </span>
            </td>
            <td colspan="3">
                <g:textField name="nombre" maxlength="63" class="required" value="${proveedorInstance?.nombre}" style="width: 430px"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Nombre Contacto
                </span>
            </td>
            <td width="250px">
                <g:textField name="nombreContacto" maxlength="31" class="required" value="${proveedorInstance?.nombreContacto}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                    Apellido Contacto
                </span>
            </td>
            <td>
                <g:textField name="apellidoContacto" maxlength="31" class="" value="${proveedorInstance?.apellidoContacto}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Dirección
                </span>
            </td>
            <td colspan="3">
                <g:textField name="direccion" maxlength="60" class="" value="${proveedorInstance?.direccion}" style="width: 650px; resize: none"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Teléfono
                </span>
            </td>
            <td width="250px">
                <g:textField name="telefonos" maxlength="40" class="" value="${proveedorInstance?.telefonos}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                    Email
                </span>
            </td>
            <td>
                <g:textField name="email" maxlength="40" class="email mail" value="${proveedorInstance?.email}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Gerente
                </span>
            </td>
            <td width="250px">
                <g:textField name="garante" maxlength="40" class="" value="${proveedorInstance?.garante}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                    Título
                </span>
            </td>
            <td>
                <g:textField name="titulo" maxlength="4" class="" value="${proveedorInstance?.titulo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
%{--        <tr>--}%
%{--            <td colspan="1">--}%
%{--                <span class="control-label label label-inverse">--}%
%{--                    Licencia--}%
%{--                </span>--}%
%{--            </td>--}%
%{--            <td width="250px">--}%
%{--                <g:textField name="licencia" maxlength="10" class="" value="${proveedorInstance?.licencia}"/>--}%
%{--                <p class="help-block ui-helper-hidden"></p>--}%
%{--            </td>--}%
%{--            <td width="100px">--}%
%{--                <span class="control-label label label-inverse">--}%
%{--                    Registro--}%
%{--                </span>--}%
%{--            </td>--}%
%{--            <td>--}%
%{--                <g:textField name="registro" maxlength="7" class="" value="${proveedorInstance?.registro}"/>--}%
%{--                <p class="help-block ui-helper-hidden"></p>--}%
%{--            </td>--}%
%{--        </tr>--}%
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Origen
                </span>
            </td>
            <td width="250px">
                <g:select name="origen" from="${['N' : 'Nacional', 'E': 'Extranjero', 'M' : 'Multinacional']}" optionKey="key" optionValue="value" class="many-to-one " value="${proveedorInstance?.origen}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
            <td width="100px">
                <span class="control-label label label-inverse">
                   Pago
                </span>
            </td>
            <td>
                <g:textField name="nombreCheque" maxlength="63" class="" value="${proveedorInstance?.pagarNombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <span class="control-label label label-inverse">
                    Observaciones
                </span>
            </td>
            <td colspan="3">
                <g:textArea name="observaciones" maxlength="127" class="" value="${proveedorInstance?.observaciones}" style="width: 650px; resize: none"/>
                <p class="help-block ui-helper-hidden"></p>
            </td>
        </tr>
    </table>

</g:form>

<script type="text/javascript">
    // $("#frmSave-Proveedor").validate({
    //     errorPlacement : function (error, element) {
    //         element.parent().find(".help-block").html(error).show();
    //     },
    //     success        : function (label) {
    //         label.parent().hide();
    //     },
    //     errorClass     : "label label-important",
    //     submitHandler  : function(form) {
    //         $(".btn-success").replaceWith(spinner);
    //         form.submit();
    //     }
    // });
    //
    // $("input").keyup(function (ev) {
    //     if (ev.keyCode == 13) {
    //         submitForm($(".btn-success"));
    //     }
    // });
</script>
