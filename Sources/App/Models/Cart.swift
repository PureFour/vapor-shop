import Fluent
import Vapor

final class Cart: Model, Content {
    static let schema = "cart"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "products_ids")
    var products_ids: [String]
    
    @Field(key: "total_price")
    var total_price: Double

    init() { }

    init(id: UUID? = nil, products_ids: [String], total_price: Double) {
        self.id = id
        self.products_ids = products_ids
        self.total_price = total_price
    }
}
