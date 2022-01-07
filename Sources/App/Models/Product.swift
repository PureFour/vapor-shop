import Fluent
import Vapor

final class Product: Model, Content {
    static let schema = "product"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "price")
    var price: Double
    
    @Field(key: "image_url")
    var image_url: String
    
    @Field(key: "quantity")
    var quantity:  Int

    
    init() { }

    init(id: UUID? = nil, title: String, description: String, price: Double, image_url: String, quantity: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.image_url = image_url
        self.quantity = quantity
    }
}
