import Fluent

struct CreateProduct: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("product")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("price", .double, .required)
            .field("image_url", .string, .required)
            .field("quantity", .int, .required)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("product").delete()
    }
}
