import Fluent
import Vapor

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("product")
        products.get(use: getAll)
        products.post(use: create)
        products.group(":productID") { product in
            product.delete(use: delete)
        }
    }

    func getAll(req: Request) throws -> [Product] {
        let sampleProducts: [Product] = readSampleProductsFromJson()
        sampleProducts.forEach { try product in
            try product.save(on: req.db).wait()
        }
        return sampleProducts
    }

    func create(req: Request) throws -> EventLoopFuture<Product> {
        let product = try req.content.decode(Product.self)
        return product.save(on: req.db).map { product }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Product.find(req.parameters.get("productID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func readSampleProductsFromJson() -> [Product] {
        let jsonDecoder = JSONDecoder()
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: "Resources/sample-products.json"))
        let products = try! jsonDecoder.decode([Product].self, from: jsonData)
    
        return products
    }
}
