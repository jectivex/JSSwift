import JXKit
import Foundation
import Dispatch

extension JXContext {
    /// Installs the `esprima.js` JavaScript parser into `exports.esprima`
    @discardableResult public func installEsprima() throws -> JXValType {
        let exports = self.globalObject(property: "exports")
        if exports["esprima"].isUndefined {
            let _ = try installModule(named: "esprima", in: .module)
        }
        let esprima = exports["esprima"] // esprima installs itself into "exports", so fetch it from there
        if !esprima.isObject {
            throw Errors.evaluationError(esprima)
        }
        return esprima
    }
}
