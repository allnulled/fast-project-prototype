
class LiveRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/LiveRouter.configure.js";
	}
}
module.exports = LiveRouter;