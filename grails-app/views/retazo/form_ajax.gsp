<%@ page import="construye.Retazo" %>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmRetazo" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${retazoInstance?.id}" />
        <g:hiddenField name="ex" value="${existencias}" />

        <table cellpadding="5">
            <tr>
                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Bodega
                    </span>
                </td>
                <td width="150px">
                    <g:hiddenField name="bodega" value="${bodega?.id}"/>
                    ${bodega?.descripcion}
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Item
                    </span>
                </td>
                <td colspan="3">
                    <g:hiddenField name="item" value="${item?.id}"/>
                    ${item?.nombre}
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Cantidad
                    </span>
                </td>
                <td colspan="1">
                    <g:textField name="cantidad" style="width: 50px" value="${retazoInstance?.cantidad}" class="number form-control required" required=""/>
                </td>

                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Disponible
                    </span>
                </td>
                <td width="100px">
                   ${disponible}
                </td>

            </tr>
        </table>
    </g:form>
</div>

<script type="text/javascript">
    var validator = $("#frmRetazo").validate({
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

    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitFormRetazo();
            return false;
        }
        return true;
    });
</script>
