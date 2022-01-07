import Fluent

struct CreateCart: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cart")
            .id()
            .field("products_ids", .array(of: .string), .required)
            .field("total_price", .double, .required)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cart").delete()
    }
}
