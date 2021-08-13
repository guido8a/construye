package audit

class Audit implements Serializable {
    private static final long serialVersionUID = 1L

    static auditable = false

    Date dateCreated
    Date lastUpdated

    String actor
    String uri
    String className
    String persistedObjectId
    Long persistedObjectVersion = 0

    String eventName
    String propertyName
    String oldValue
    String newValue

    static constraints = {
        actor(nullable: true)
        uri(nullable: true)
        className(nullable: true)
        persistedObjectId(nullable: true)
        persistedObjectVersion(nullable: true)
        eventName(nullable: true)
        propertyName(nullable: true)

        oldValue(nullable: true)
        newValue(nullable: true)
    }

    static mapping = {
        table 'audit_log'
        cache usage: 'read-only', include: 'non-lazy'
        autoImport false
        version false
    }

    private void readObject(ObjectInputStream input) throws IOException, ClassNotFoundException {
        def map = input.readObject()
        map.each { k, v -> this."$k" = v }
    }

    private void writeObject(ObjectOutputStream out) throws IOException {
        def map = [
                id: id,
                dateCreated: dateCreated,
                lastUpdated: lastUpdated,

                actor: actor,
                uri: uri,
                className: className,
                persistedObjectId: persistedObjectId,
                persistedObjectVersion: persistedObjectVersion,

                eventName: eventName,
                propertyName: propertyName,
                oldValue: oldValue,
                newValue: newValue,
        ]
        out.writeObject(map)
    }

    String toString() {
        String actorStr = actor ? "user ${actor}" : "user ?"
        "audit log ${dateCreated} ${actorStr} " +
                "${eventName} ${className} " +
                "id:${persistedObjectId} version:${persistedObjectVersion}"
    }
}
