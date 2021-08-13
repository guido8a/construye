import kerberos.AuditLogListener
import kerberos.AuditLogListenerUtil
import kerberos.AuditLoggingUtils
import org.grails.datastore.mapping.core.Datastore

class Kerberos8GrailsPlugin {
    // the plugin version
    def version = "1.0"
    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "2.5 > *"
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
        "grails-app/views/error.gsp"
    ]

    // TODO Fill in these fields
    def title = "Kerberos8 Plugin" // Headline display name of the plugin
    def author = "Your name"
    def authorEmail = ""
    def description = '''\
  --  kerberos. --
'''


    def dependsOn = [:]
    def loadAfter = ['core', 'dataSource']

    def doWithApplicationContext = { applicationContext ->
        // due to next line, Grails 2.0 is not supported anymore.
        // We need to obtain all datastores in ORM agnostic way, but in Grails 2.0.x, the DataStore is not obtainable from ctx.
        applicationContext.getBeansOfType(Datastore).values().each { Datastore datastore ->
            // Don't register the listener if we are disabled
            log.debug("Registering AuditLogListeners to datastores")
            // Note: Some datastores do not hold config property (e.g. mongodb)
            boolean dataStoreDisabled = datastore.hasProperty("config") ? datastore.config.auditLog.disabled : false
            if (!application.config.auditLog.disabled && !dataStoreDisabled) {
                log.debug("Registering AuditLogListeners to datastore $datastore")
                def listener = new AuditLogListener(datastore)
                listener.with {
                    grailsApplication = application
                    stampEnabled = application.config.auditLog.stampEnabled ?: true
                    stampAlways = application.config.auditLog.stampAlways ?: false
                    stampCreatedBy = application.config.auditLog.stampCreatedBy ?: 'createdBy'
                    stampLastUpdatedBy = application.config.auditLog.stampLastUpdatedBy ?: 'lastUpdatedBy'
                    verbose = application.config.auditLog.verbose ?: false
                    nonVerboseDelete = application.config.auditLog.nonVerboseDelete ?: false
                    logFullClassName = application.config.auditLog.logFullClassName ?: false
                    transactional = application.config.auditLog.transactional ?: false
                    sessionAttribute = application.config.auditLog.sessionAttribute ?: ""
                    actorKey = application.config.auditLog.actorKey ?: ""
                    truncateLength = application.config.auditLog.truncateLength ?: determineDefaultTruncateLength(applicationContext)
                    actorKey = application.config.auditLog.actorKey ?: ""
                    actorClosure = application.config.auditLog.actorClosure ?: AuditLogListenerUtil.actorDefaultGetter
                    defaultIgnoreList = application.config.auditLog.defaultIgnore?.asImmutable() ?: ['version', 'lastUpdated'].asImmutable()
                    defaultMaskList = application.config.auditLog.defaultMask?.asImmutable() ?: ['password'].asImmutable()
                    propertyMask = application.config.auditLog.propertyMask ?: "**********"
                    replacementPatterns = application.config.auditLog.replacementPatterns
                    logIds = application.config.auditLog.logIds ?: false
                }
                applicationContext.addApplicationListener(listener)
            }
        }
    }




    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/kerberos8"

    // Extra (optional) plugin metadata

    // License: one of 'APACHE', 'GPL2', 'GPL3'
//    def license = "APACHE"

    // Details of company behind the plugin (if there is one)
//    def organization = [ name: "My Company", url: "http://www.my-company.com/" ]

    // Any additional developers beyond the author specified above.
//    def developers = [ [ name: "Joe Bloggs", email: "joe@bloggs.net" ]]

    // Location of the plugin's issue tracker.
//    def issueManagement = [ system: "JIRA", url: "http://jira.grails.org/browse/GPMYPLUGIN" ]

    // Online location of the plugin's browseable source code.
//    def scm = [ url: "http://svn.codehaus.org/grails-plugins/" ]

    def doWithWebDescriptor = { xml ->
        // TODO Implement additions to web.xml (optional), this event occurs before
    }


    def doWithDynamicMethods = { ctx ->
        // TODO Implement registering dynamic methods to classes (optional)
    }


    def onChange = { event ->
        // TODO Implement code that is executed when any artefact that this plugin is
        // watching is modified and reloaded. The event contains: event.source,
        // event.application, event.manager, event.ctx, and event.plugin.
    }

    def onConfigChange = { event ->
        // TODO Implement code that is executed when the project configuration changes.
        // The event is the same as for 'onChange'.
    }

    def onShutdown = { event ->
        // TODO Implement code that is executed when the application shuts down (optional)
    }

    /**
     * The default truncate length is 255 unless we are using the largeValueColumnTypes, then we allow up to the column size
     */
    private Integer determineDefaultTruncateLength(ctx) {
        String confAuditDomainClassName = AuditLoggingUtils.auditConfig.auditDomainClassName
        if (confAuditDomainClassName == null){
            throw new IllegalArgumentException("Please configure auditLog.auditDomainClassName in Config.groovy")
        }
        String auditClassName = AuditLoggingUtils.auditConfig.auditDomainClassName
        def dc = ctx.grailsApplication.getDomainClass(auditClassName)
        if (!dc) {
            throw new IllegalArgumentException("The configured audit logging domain class '$auditClassName' is not a domain class")
        }
        Class AuditLogEvent = dc.clazz
        AuditLogEvent.constraints.oldValue?.maxSize ?: 255
    }

}
