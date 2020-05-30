import FluentPostgreSQL //1
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider()) //2

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .memory) //3

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let config = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "aditya.shinde", database: "crudoperations", password: nil, transport: .cleartext) //4
    
    let postgres = PostgreSQLDatabase(config: config) //5
    databases.add(database: postgres, as: .psql)//6
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Pet.self, database: .psql) //7
    services.register(migrations)
}
