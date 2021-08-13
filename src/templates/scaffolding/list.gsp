<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de ${className}</title>
</head>
<body>

<elm:message tipo="\${flash.tipo}" clase="\${flash.clase}">\${flash.message}</elm:message>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-default btnCrear">
            <i class="fa fa-file-o"></i> Crear
        </a>
    </div>
    <div class="btn-group pull-right col-md-3">
        <div class="input-group">
            <input type="text" class="form-control input-search" placeholder="Buscar" value="\${params.search}">
            <span class="input-group-btn">
                <g:link controller="${className.toLowerCase()}" action="list" class="btn btn-default btn-search">
                    <i class="fa fa-search"></i>&nbsp;
                </g:link>
            </span>
        </div><!-- /input-group -->
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover">
    <thead>
    <tr>
        <%
            int cant = 0
            excludedProps = Event.allEvents.toList() << 'id' << 'version' << 'password' << 'pass'
            allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
//                    cant = props.size()
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.eachWithIndex { p, i ->
                cant = (int)cant+1
                if (i < 6) {
                    if (p.isAssociation()) { %>
        <th>${p.naturalName}</th>
        <%      } else { %>
        <g:sortableColumn property="${p.name}" title="${p.naturalName}" />
        <%  }   }   } %>
    </tr>
    </thead>
    <tbody>
    <g:if test="\${${propertyName}Count > 0}">
        <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
            <tr data-id="\${${propertyName}.id}">
                <%  props.eachWithIndex { p, i ->

                    boolean bool = p.type == Boolean || p.type == boolean
                    boolean number = Number.isAssignableFrom(p.type) || (p.type?.isPrimitive() && p. type != boolean)
                    boolean date = p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar

                    if (i == 0) { %>
                <td>\${${propertyName}.${p.name}}</td>
                <%      } else if (i < 6) {
                    if (bool) { %>
                <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" false="No" true="Sí" /></td>
                <%          } else if (date) { %>
                <td><g:formatDate date="\${${propertyName}.${p.name}}" format="dd-MM-yyyy" /></td>
                <%          } else if (number) { %>
                <td><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></td>
                <%          } else { %>
                <td><elm:textoBusqueda busca="\${params.search}"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></elm:textoBusqueda></td>
                <%  }   }   } %>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr class="danger">
            <td class="text-center" colspan="${cant}">
                <g:if test="\${params.search && params.search!= ''}">
                    No se encontraron resultados para su búsqueda
                </g:if>
                <g:else>
                    No se encontraron registros que mostrar
                </g:else>
            </td>
        </tr>
    </g:else>
    </tbody>
</table>

<elm:pagination total="\${${domainClass.propertyName}InstanceCount}" params="\${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm${domainClass.propertyName.capitalize()}() {
        var \$form = \$("#frm${className}");
        var \$btn = \$("#dlgCreateEdit").find("#btnSave");
        if (\$form.valid()) {
        \$btn.replaceWith(spinner);
            openLoader("Guardando ${className}");
                    \$.ajax({
                type    : "POST",
                url     : \$form.attr("action"),
                data    : \$form.serialize(),
                success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                setTimeout(function() {
                    if (parts[0] == "SUCCESS") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith(\$btn);
                        return false;
                    }
                }, 1000);
            }
        });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar el ${className} seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        openLoader("Eliminando ${className}");
                                \$.ajax({
                            type    : "POST",
                            url     : '\${createLink(controller:'${domainClass.propertyName.toLowerCase()}', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function() {
                                        location.reload(true);
                                    }, 1000);
                                } else {
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
                \$.ajax({
            type    : "POST",
            url     : "\${createLink(controller:'${domainClass.propertyName.toLowerCase()}', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " ${className}",
                    <% if(cant >= 10) { %>
                    class   : "modal-lg",
                    <% } %>
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    \$(function () {

        \$(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

                \$("tbody>tr").contextMenu({
            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                ver      : {
                    label  : "Ver",
                    icon   : "fa fa-search",
                    action : function (\$element) {
            var id = \$element.data("id");
                                \$.ajax({
                type    : "POST",
                url     : "\${createLink(controller:'${domainClass.propertyName.toLowerCase()}', action:'show_ajax')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    bootbox.dialog({
                        title   : "Ver ${className}",
                        message : msg,
                        buttons : {
                            ok : {
                                label     : "Aceptar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            }
                        }
                    });
                }
            });
        }
    },
        editar   : {
            label  : "Editar",
                icon   : "fa fa-pencil",
                action : function (\$element) {
                var id = \$element.data("id");
                createEditRow(id);
            }
        },
        eliminar : {
            label            : "Eliminar",
                icon             : "fa fa-trash-o",
                separator_before : true,
                action           : function (\$element) {
                var id = \$element.data("id");
                deleteRow(id);
            }
        }
    },
        onShow : function (\$element) {
        \$element.addClass("success");
        },
        onHide : function (\$element) {
        \$(".success").removeClass("success");
        }
    });
    });
</script>

</body>
</html>
