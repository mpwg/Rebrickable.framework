import Foundation
import Swifter

extension Swifter.HttpResponse {
    public static func encode(value: some Encodable) -> Swifter.HttpResponse {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let encodedDate = ISO8601DateFormatter().string(from: date)
            try container.encode(encodedDate)
        }
        guard let data = try? encoder.encode(value) else {
            return HttpResponse.internalServerError
        }
        return HttpResponse.ok(HttpResponseBody.data(data))
    }

    static func encode(_ value: some Encodable, statusCode: Int) -> Swifter.HttpResponse {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let encodedDate = ISO8601DateFormatter().string(from: date)
            try container.encode(encodedDate)
        }
        guard let data = try? encoder.encode(value) else {
            return HttpResponse.internalServerError
        }

        return HttpResponse.raw(statusCode, "", nil) { writer in
            try? writer.write(data)
        }
    }
}
