//
//  BaseNetworkProvider.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation
import Alamofire

// MARK: - Class
class BaseNetworkProvider {
    /// Main session manager
    var sessionManager: Session = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            kAPIURL: PinnedCertificatesTrustEvaluator(certificates: [],
                                                      acceptSelfSignedCertificates: false,
                                                      performDefaultValidation: true,
                                                      validateHost: true),
            "selfsignedserver.com": DisabledTrustEvaluator()
        ]

        // Create custom manager
        var configuration = URLSessionConfiguration.af.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = kTimeoutIntervalForRequest
        configuration.timeoutIntervalForResource = kTimeoutIntervalForResource
        configuration.httpMaximumConnectionsPerHost = 2

        let manager = ServerTrustManager(evaluators: serverTrustPolicies)
        let session = Session(configuration: configuration)

        return session
    }()
}

// MARK: - Enums

/// Available API endpoints
enum APIEndpoint {
    
    case signIn
    case signOut
    case signUp

    /// Endpoint string
    var endpointUrl: String {
        switch self {
        case .signIn:
            return kAPIURL+"login"
        case .signOut:
            return kAPIURL+"logout"
        case .signUp:
            return kAPIURL+"register"
        }
    }
}

/// Network errors
enum NetworkError: Error, LocalizedError {
    
    case generic(String)
    case badResponse
    case badData

    /// Localized description
    var localizedDescription: String {
        switch self {
        case .generic(let localizableDescription):
            return localizableDescription
        case .badResponse:
            return "network_error_parsing_description".localizedString()
        case .badData:
            return "network_error_bad_data".localizedString()
        }
    }
}
