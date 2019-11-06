
const ErrorManager = require(process.env.PROJECT_ROOT + "/core/helper/ErrorManager.js");
const ReflectionUtils = require(process.env.PROJECT_ROOT + "/core/helper/ReflectionUtils.js");
const OverridableClass = require(process.env.PROJECT_ROOT + "/core/helper/OverridableClass.js");
const BaseRouter = require(process.env.PROJECT_ROOT + "/core/router/base/BaseRouter.js");
class BaseApp extends OverridableClass {
	//////////////////////////////////////////////////////
	getMainDatabaseFile() {
		throw new ErrorManager.classes.MustOverrideMethod("BaseApp#mainDatabaseFilepath()");
	}
	getOtherDatabaseFiles() {
		return [];
	}
	//////////////////////////////////////////////////////
	constructor(options = {}, callback = undefined) {
		super(options, callback);
		if(!this.project instanceof BaseProject) {
			throw new ErrorManager.classes.RequiredTypeError("BaseApp#project must be a BaseProject instance");
		}
		if(!this.router instanceof BaseRouter) {
			throw new ErrorManager.classes.RequiredTypeError("BaseApp#router must be a BaseRouter instance");
		}
		if(!this.$app) {
			this.$app = express();
		}
		if(!this.$router) {
			this.$router = express.Router();
		}
	}
	//////////////////////////////////////////////////////
	getLoadMethods() {
		return [
			"stepSkipConditionally",
			"stepLoadSettings",
			"~stepLoadDatabases",
			"stepLoadApp",
			"stepLoadRequestPrototype",
			"stepLoadResponsePrototype",
			"stepLoadRouter",
			"stepLoadServer",
			"stepLoadSecureServer",
		]
	}
	getStartMethods() {
		return [
			"stepStartServer",
			"stepStartSecureServer",
		]
	}
	//////////////////////////////////////////////////////
	load(parameters = {}) {
		return ReflectionUtils.gateway(this, this.getLoadMethods(), new ParametersManager(parameters));
	}
	start(parameters = {}) {
		ReflectionUtils.gateway(this, this.getLoadMethods(), new ParametersManager(parameters));
		return ReflectionUtils.gateway(this, this.getStartMethods(), new ParametersManager(parameters));
	}
	stepSkipConditionally(_) {}
	stepLoadSettings(_) {}
	async stepLoadDatabases(_) {}
	stepLoadApp(_) {}
	stepLoadRequestPrototype(_) {}
	stepLoadResponsePrototype(_) {}
	stepLoadRouter(_) {}
	stepLoadServer(_) {}
	stepLoadSecureServer(_) {}
	async stepStartServer(_) {}
	async stepStartSecureServer(_) {}
}
module.exports = BaseApp;