/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

struct Car : Codable {
	let reviewAvg : Double?
	let fuelType : String?
	let createdAt : String?
	let ownerId : String?
	let year : Int?
	let reviewCount : Int?
	let make : String?
	let gear : String?
	let bodyType : String?
	let model : String?
	let seats : Int?
	let allowed : [String]?
	let accessories : [String]?
	let images : [String]?

	enum CodingKeys: String, CodingKey {

		case reviewAvg = "reviewAvg"
		case fuelType = "fuelType"
		case createdAt = "createdAt"
		case ownerId = "ownerId"
		case year = "year"
		case reviewCount = "reviewCount"
		case make = "make"
		case gear = "gear"
		case bodyType = "bodyType"
		case model = "model"
		case seats = "seats"
		case allowed = "allowed"
		case accessories = "accessories"
		case images = "images"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		reviewAvg = try values.decodeIfPresent(Double.self, forKey: .reviewAvg)
		fuelType = try values.decodeIfPresent(String.self, forKey: .fuelType)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		ownerId = try values.decodeIfPresent(String.self, forKey: .ownerId)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
		reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
		make = try values.decodeIfPresent(String.self, forKey: .make)
		gear = try values.decodeIfPresent(String.self, forKey: .gear)
		bodyType = try values.decodeIfPresent(String.self, forKey: .bodyType)
        
        
        var model : String?
        do {
            model = try values.decodeIfPresent(String.self, forKey: .model)
        } catch {
            print(error, "model is not a String")
        }
        
        if(model == nil) {
            do {
                let intModel = try values.decodeIfPresent(Int.self, forKey: .model)
                model = "\(String(describing: intModel))"
            } catch {
                print(error, "model is not an Int")
            }
        }
        self.model = model
		seats = try values.decodeIfPresent(Int.self, forKey: .seats)
		allowed = try values.decodeIfPresent([String].self, forKey: .allowed)
		accessories = try values.decodeIfPresent([String].self, forKey: .accessories)
		images = try values.decodeIfPresent([String].self, forKey: .images)
	}

}
