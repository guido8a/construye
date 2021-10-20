<%@ page import="construye.Retazo" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
<g:if test="${!retazoInstance}">
    <elm:notFound elem="Retazo" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmRetazo" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${retazoInstance?.id}" />

            
            <div class="form-group keeptogether ${hasErrors(bean: retazoInstance, field: 'bodega', 'error')} required">
                <span class="grupo">
                    <label for="bodega" class="col-md-2 control-label">
                        Bodega
                    </label>
                    <div class="col-md-6">
%{--                        <g:select id="bodega" name="bodega.id" from="${janus.construye.Bodega.list()}" optionKey="id" required="" value="${retazoInstance?.bodega?.id}" class="many-to-one form-control"/>--}%
                    </div>
                     *
                </span>
            </div>
            
            <div class="form-group keeptogether ${hasErrors(bean: retazoInstance, field: 'item', 'error')} required">
                <span class="grupo">
                    <label for="item" class="col-md-2 control-label">
                        Item
                    </label>
                    <div class="col-md-6">
%{--                        <g:select id="item" name="item.id" from="${janus.Item.list()}" optionKey="id" required="" value="${retazoInstance?.item?.id}" class="many-to-one form-control"/>--}%
                    </div>
                     *
                </span>
            </div>
            
            <div class="form-group keeptogether ${hasErrors(bean: retazoInstance, field: 'fecha', 'error')} required">
                <span class="grupo">
                    <label for="fecha" class="col-md-2 control-label">
                        Fecha
                    </label>
                    <div class="col-md-4">
                        <elm:datepicker name="fecha" title="fecha"  class="datepicker form-control required" value="${retazoInstance?.fecha}"  />
                    </div>
                     *
                </span>
            </div>
            
            <div class="form-group keeptogether ${hasErrors(bean: retazoInstance, field: 'cantidad', 'error')} required">
                <span class="grupo">
                    <label for="cantidad" class="col-md-2 control-label">
                        Cantidad
                    </label>
                    <div class="col-md-2">
                        <g:field name="cantidad" type="number" value="${fieldValue(bean: retazoInstance, field: 'cantidad')}" class="number form-control  required" required=""/>
                    </div>
                     *
                </span>
            </div>
            
            <div class="form-group keeptogether ${hasErrors(bean: retazoInstance, field: 'estado', 'error')} required">
                <span class="grupo">
                    <label for="estado" class="col-md-2 control-label">
                        Estado
                    </label>
                    <div class="col-md-6">
                        <g:textField name="estado" required="" class="allCaps form-control required" value="${retazoInstance?.estado}"/>
                    </div>
                     *
                </span>
            </div>
            
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

</g:else>