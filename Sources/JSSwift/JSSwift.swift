import JXKit
import Foundation
import Dispatch

extension JXContext {
    /// Installs the `esprima.js` JavaScript parser
    public func installEsprima() throws {
        try installModule(named: "esprima", in: .module)
    }
}
