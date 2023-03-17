import Foundation

@testable import NetworkInterface

enum DataTaskMocks {
    static var validData: Data? {
        """
        {
            "id": 804,
            "main": "Clouds",
            "description": "overcast clouds",
            "icon": "04d"
        }
        """.data(using: .utf8)
    }

    static var HTTPURLResponse200: HTTPURLResponse? {
        .init(
            url: URL(string: "medialab.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
    }

    static var HTTPURLResponse300: HTTPURLResponse? {
        .init(
            url: URL(string: "medialab.com")!,
            statusCode: 300,
            httpVersion: nil,
            headerFields: nil
        )
    }

    struct ValidResponse: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct InvalidResponse: Codable {
        let weatherDescription: String
    }

    struct NetworkRequestDummy: NetworkRequest {
        let path: String = ""
        let method: HTTPMethod = .get
    }
}
