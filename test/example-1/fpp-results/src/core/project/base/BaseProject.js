
const BaseProjectLogger = require(process.env.PROJECT_ROOT + "/core/helper/logger.js").create("BaseProjectLogger: ", ["yellow", "bold"]);
const ErrorManager = require(process.env.PROJECT_ROOT + "/core/helper/ErrorManager.js");
const ReflectionUtils = require(process.env.PROJECT_ROOT + "/core/helper/ReflectionUtils.js");
const OverridableClass = require(process.env.PROJECT_ROOT + "/core/helper/OverridableClass.js");
const BaseApp = require(process.env.PROJECT_ROOT + "/core/app/base/BaseApp.js");
class BaseProject extends OverridableClass {
	//////////////////////////////////////////////////////
	static get defaultApp() {
		throw new ErrorManager.classes.MustOverrideError("BaseProject[.constructor].defaultApp");
	}
	constructor(options = {}, callback = undefined) {
		super(options, callback);
		BaseProjectLogger.debug("BaseProject.constructor");
		if(!this.app) {
			this.app = this.constructor.defaultApp;
		}
		if(!this.app instanceof BaseApp) {
			throw new ErrorManager.classes.RequiredTypeError("BaseProject#app must be a BaseApp instance");
		}
	}
	//////////////////////////////////////////////////////
	load(...args) {
		BaseProjectLogger.debug("BaseProject.load");
		return this.app.load(...args);
	}
	start(...args) {
		BaseProjectLogger.debug("BaseProject.start");
		return this.app.start(...args);
	}
}
module.exports = BaseProject;