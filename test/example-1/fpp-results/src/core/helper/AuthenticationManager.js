
const AuthenticationLogger = require(process.env.PROJECT_ROOT + "/core/helper/logger.js").create("AuthenticationManager: ", ["yellow", "bold"]);
class DoesRequestQuery {
	constructor(request) {
		AuthenticationLogger.debug("DoesRequestQuery.constructor");
		this.request = request;
	}
	havePermissionTo(permissionNameOrId) {
		AuthenticationLogger.debug("DoesRequestQuery.havePermissionTo");
		// @TODO
	}
	belongToCommunity(communityNameOrId) {
		AuthenticationLogger.debug("DoesRequestQuery.belongToCommunity");
		// @TODO
	}
	belongToRole(roleNameOrId) {
		AuthenticationLogger.debug("DoesRequestQuery.belongToRole");
		// @TODO
	}
}
class AuthenticationManager {
	static doesRequest(request) {
		AuthenticationLogger.debug("doesRequest");
		if(!SessionManager.hasRequestSession(request)) {
			return false;
		}
		return new DoesRequestQuery(request);
	}
}
module.exports = AuthenticationManager;