dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.postgresql.Driver"
    dialect = org.hibernate.dialect.PostgreSQLDialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    cache.region.factory_class = 'org.hibernate.cache.SingletonEhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.SingletonEhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}


// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
          /** consugez **/
//            url = "jdbc:postgresql://127.0.0.1:5432/consugez"  //ok
            url = "jdbc:postgresql://127.0.0.1:5432/cngz_brre"  //ok

            username = "postgres"
            password = "postgres"
        }
//        dataSource_oferentes {
//            dialect = org.hibernate.dialect.PostgreSQLDialect
//            driverClassName = 'org.postgresql.Driver'
//            username = 'postgres'
//            password = 'postgres'
//            url = 'jdbc:postgresql://127.0.0.1:5432/ofrt_brre'
//            dbCreate = 'update'
//        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://127.0.0.1:5432/gadlr"
            username = "postgres"
            password = "postgres"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://127.0.0.1:5432/obras"
            username = "postgres"
            password = "steinsgate"
            properties {
               // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
               jmxEnabled = true
               initialSize = 5
               maxActive = 10
               minIdle = 5
               maxIdle = 5
               maxWait = 10000
               maxAge = 10 * 60000
               timeBetweenEvictionRunsMillis = 5000
               minEvictableIdleTimeMillis = 60000
               validationQuery = "SELECT 1"
               validationQueryTimeout = 3
               validationInterval = 15000
               testOnBorrow = true
               testWhileIdle = true
               testOnReturn = false
               jdbcInterceptors = "ConnectionState"
               defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }

/*
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            url = "jdbc:postgresql://127.0.0.1:5432/oferentes"
            username = "postgres"
            password = "januslr"
            dbCreate = 'update'
        }
*/
    }

    servicio {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://127.0.0.1:5432/construye"
            username = "postgres"
            password = "steinsgate"
            properties {
               // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
               jmxEnabled = true
               initialSize = 5
               maxActive = 10
               minIdle = 5
               maxIdle = 5
               maxWait = 10000
               maxAge = 10 * 60000
               timeBetweenEvictionRunsMillis = 5000
               minEvictableIdleTimeMillis = 60000
               validationQuery = "SELECT 1"
               validationQueryTimeout = 3
               validationInterval = 15000
               testOnBorrow = true
               testWhileIdle = true
               testOnReturn = false
               jdbcInterceptors = "ConnectionState"
               defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}
