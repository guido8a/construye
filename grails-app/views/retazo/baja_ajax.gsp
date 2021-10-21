<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/10/21
  Time: 16:04
--%>

<%@ page import="construye.Retazo" %>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmBaja" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${retazo?.id}" />

        <table cellpadding="5">
            <tr>
                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Cantidad  a usar
                    </span>
                </td>
                <td colspan="1">
                    <g:textField name="cantidad" style="width: 50px" value="${retazo?.cantidad}" class="number form-control required" required=""/>
                </td>

                <td colspan="1">
                    <span class="control-label label label-inverse">
                        Disponible
                    </span>
                </td>
                <td width="100px">
                    ${retazo?.cantidad}
                </td>

            </tr>
        </table>
    </g:form>
</div>

<script type="text/javascript">
    var validator = $("#frmBaja").validate({
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
    // $(".form-control").keydown(function (ev) {
    //     if (ev.keyCode == 13) {
    //         submitFormRetazo();
    //         return false;
    //     }
    //     return true;
    // });
</script>
