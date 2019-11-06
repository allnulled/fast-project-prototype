
class RestRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/RestRouter.configure.js";
	}
}
module.exports = RestRouter;