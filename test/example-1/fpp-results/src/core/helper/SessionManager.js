
const SessionLogger = require(process.env.PROJECT_ROOT + "/core/helper/logger.js").create("SessionManager: ", ["yellow", "bold"]);
class SessionManager {
	static hasRequestSession(request) {
		SessionLogger.debug("hasRequestSession");
		// @TODO
		return false;
	}
	async static startSessionRequest(request) {
		SessionLogger.debug("startSessionRequest");
		try {
			if(this.hasRequestSession(request)) {
				return;
			}
			// @TODO
		} catch(error) {
			throw error;
		}
	}
	async static closeSession(request) {
		SessionLogger.debug("closeSession");
		try {
			if(!this.hasRequestSession(request)) {
				return true;
			}
			// @TODO
		} catch(error) {
			throw error;
		}	
	}

}
module.exports = SessionManager;