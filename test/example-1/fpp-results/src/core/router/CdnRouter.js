
class CdnRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/CdnRouter.configure.js";
	}
}
module.exports = CdnRouter;