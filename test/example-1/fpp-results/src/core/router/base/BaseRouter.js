
const importFresh = require("import-fresh");
const App = require(process.env.PROJECT_ROOT + "/core/app/App.js");
class BaseRouter {
	static get defaultConfigureFile() {
		throw new ErrorManager.MustOverrideError("BaseRouter[.constructor].defaultConfigureFile must be overriden");
	}
	static get defaultApp() {
		return App;
	}
	mountRouter(router, path = "*", middleware = []) {
		// @TODO
	}
	mountMiddleware(middleware, path = "*", middleware = []) {
		// @TODO
	}
	mountController(controller, path = "*", middleware = []) {
		// @TODO
	}
	configure() {
		const router = importFresh(this.constructor.defaultConfigureFile);
		this.$router = router;
	}
}
module.exports = Project;