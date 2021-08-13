<%=packageName%>
<% import grails.persistence.Event %>
<script type="text/javascript" src="\${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="\${!${propertyName}}">
    <elm:notFound elem="${domainClass.propertyName.capitalize()}" genero="o" />
</g:if>
<g:else>
    <%  excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
    persistentPropNames = domainClass.persistentProperties*.name
    boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
    if (hasHibernate) {
        def GrailsDomainBinder = getClass().classLoader.loadClass('org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder')
        if (GrailsDomainBinder.newInstance().getMapping(domainClass)?.identity?.generator == 'assigned') {
            persistentPropNames << domainClass.identifier.name
        }
    }
    props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
    uniques = []
    %>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frm${domainClass.propertyName.capitalize()}" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="\${${propertyName}?.id}" />

            <%
                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                for (p in props) {
                    if (p.embedded) {
                        def embeddedPropNames = p.component.persistentProperties*.name
                        def embeddedProps = p.component.properties.findAll { embeddedPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                        Collections.sort(embeddedProps, comparator.constructors[0].newInstance([p.component] as Object[]))
            %><fieldset class="embedded"><legend><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></legend><%
                for (ep in p.component.properties) {
                    renderFieldForProperty(ep, p.component, "${p.name}.")
                }
        %></fieldset><%
                } else {
                    renderFieldForProperty(p, domainClass)
                }
            }
            private renderFieldForProperty(p, owningClass, prefix = "") {
                boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
                boolean display = true
                boolean required = false
                boolean number = false
                boolean date = false
                boolean unique = false
                int size = 6
                if (hasHibernate) {
                    cp = owningClass.constrainedProperties[p.name]
                    display = (cp ? cp.display : true)
                    required = (cp ? !(cp.propertyType in [boolean, Boolean]) && !cp.nullable : false)
                    number = (cp ? Number.isAssignableFrom(cp.propertyType) || (cp.propertyType?.isPrimitive() && cp. propertyType != boolean) : false)
                    date = (cp ? (cp.propertyType == Date || cp.propertyType == java.sql.Date || cp.propertyType == java.sql.Time || cp.propertyType == Calendar) : false)
                    unique = p.name.contains('codigo') || p.name.contains('login') || p.name.contains('mail') || p.name.contains('email')
                    if(unique) {
                        uniques += p
                    }
                    if(number){
                        size = 2
                    } else if(date) {
                        size = 4
                    }
                    if(props.size() >= 10) {
                        size = size + 1
                    }
                }
                if (display) { %>
            <div class="form-group keeptogether \${hasErrors(bean: ${propertyName}, field: '${prefix}${p.name}', 'error')} ${required ? 'required' : ''}">
                <span class="grupo">
                    <label for="${prefix}${p.name}" class="col-md-2 control-label">
                        ${p.naturalName}
                    </label>
                    <div class="col-md-${size}">
                        ${renderEditor(p)}
                    </div>
                    <% if (required) { %> *<% } %>
                </span>
            </div>
            <% }   } %>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = \$("#frm${domainClass.propertyName.capitalize()}").validate({
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
            <% if(uniques.size() > 0) { %>
            , rules          : {
        <% int i=0
                for (p in uniques) { %>
        ${p.name}: {
            remote: {
                url: "\${createLink(action: 'validar_unique_${p.name}_ajax')}",
                    type: "post",
                    data: {
                    id: "\${${propertyName}?.id}"
                }
            }
        }${i < uniques.size()-1 ? ',' : ''}
        <% i++
                } %>
        },
        messages : {
            <% i=0
                for (p in uniques) { %>
            ${p.name}: {
                remote: "Ya existe ${p.naturalName}"
            }${i < uniques.size()-1 ? ',' : ''}
            <% i++
                } %>
        }
        <% } %>
        });
        \$(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm${domainClass.propertyName.capitalize()}();
                return false;
            }
            return true;
        });
    </script>

</g:else>