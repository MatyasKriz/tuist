import Foundation
import TuistCore
import TuistSupport

struct CloudHEADResponse: Decodable {
    public init() {}

    public static func existsResource(hash: String, config: Config) throws -> HTTPResource<CloudResponse<CloudHEADResponse>, CloudHEADResponseError> {
        guard let configCloud = config.cloud else { throw CacheAPIError.missingCloudConfig }
        let url = try URL.apiCacheURL(hash: hash, cloudURL: configCloud.url, projectId: configCloud.projectId)
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        return HTTPResource(request: { request },
                            parse: { _, _ in CloudResponse(status: "HEAD", data: CloudHEADResponse()) },
                            parseError: { _, _ in CloudHEADResponseError() })
    }
}
