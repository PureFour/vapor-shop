import Fluent
import Vapor

struct CartController: RouteCollection {
    /*
    POST localhost:8080/cart/addProduct?id="id" 
    DELETE localhost:8080/cart/deleteProduct?id="id" 
    GET localhost:8080/produkt
    PUT localhost:8080/cart/changeProductQuantity?id="id"?quantity=2 
    DELETE localhost:8080/cart
    GET localhost:8080/cart
    */
    func boot(routes: RoutesBuilder) throws {
        let cartRoot = routes.grouped("cart")
        cartRoot.get(use: getCart)
    }

    func getCart(req: Request) throws -> EventLoopFuture<Cart> {
        return Cart.query(on: req.db).first().unwrap(or: Abort(.notFound))
    }
}
