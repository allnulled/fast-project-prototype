# Project:
# Directory: /cmd
# Filename: /cmd/add-file.js
# Filename: /cmd/change-branch.js
# Filename: /cmd/clean-rest.js
# Filename: /cmd/clone-project.js
# Filename: /cmd/commit-code.js
# Filename: /cmd/compile-books.js
# Filename: /cmd/compile-diagrams.js
# Filename: /cmd/compile-docs.js
# Filename: /cmd/compile-umls.js
# Filename: /cmd/create-branch.js
# Filename: /cmd/create-controller.js
# Filename: /cmd/create-dbbackup.js
# Filename: /cmd/create-error.js
# Filename: /cmd/create-helper.js
# Filename: /cmd/create-middleware.js
# Filename: /cmd/create-template.js
# Filename: /cmd/create-vue.js
# Filename: /cmd/do.js
# Filename: /cmd/import-file.js
# Filename: /cmd/import-url.js
# Filename: /cmd/print-tree.js
# Filename: /cmd/pull-code.js
# Filename: /cmd/push-code.js
# Filename: /cmd/remove-file.js
# Filename: /cmd/show-errors.js
# Filename: /cmd/show-logs.js
# Filename: /cmd/show-routes.js
# Filename: /cmd/show-status.js
# Filename: /cmd/show-timings.js
# Filename: /cmd/show-todos.js
# Filename: /cmd/test-e2e.js
# Filename: /cmd/test-unit.js
# Filename: /cmd/update-docs.js
# Filename: /cmd/update-i18n.js
# Directory: /cmd/update-rest
# Filename: /cmd/update-rest/BaseController.js.ejs
# Filename: /cmd/update-rest/BaseModel.js.ejs
# Filename: /cmd/update-rest/cached.json
# Filename: /cmd/update-rest/Controller.js.ejs
# Filename: /cmd/update-rest/controllers.ejs
# Filename: /cmd/update-rest/export.json
# Filename: /cmd/update-rest/Model.js.ejs
# Filename: /cmd/update-rest/models.ejs
# Filename: /cmd/update-rest/postman-collection.ejs
# Directory: /cmd/update-rest/template
# Filename: /cmd/update-rest.js
# Directory: /data
# Filename: /data/db.sql
# Filename: /dev.bat
# Filename: /dev.sh
# Filename: /do.bat
# Filename: /do.sh
# Directory: /doc
# Filename: /doc/app.expolium.postman_collection.json
# Filename: /expolium.config.js
# Directory: /log
# Filename: /log/error.log
# Filename: /log/info.log
# Filename: /package-lock.json
# Filename: /package.json
# Filename: /README.md
# Filename: /script.import-dependencies.bat
# Directory: /src
# Directory: /src/core
# Directory: /src/core/project
# Directory: /src/core/project/base

# Filename: /src/core/project/base/BaseProject.js
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

# Filename: /src/core/project/Project.js
const BaseProject = require(__dirname + "/base/BaseProject.js");
const App = require(process.env.PROJECT_ROOT + "/core/app/App.js");
class Project extends BaseProject {
	static get defaultApp() {
		return App;
	}
}
module.exports = Project;

# Filename: /src/core/app/base/BaseApp.js
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

# Filename: /src/core/app/App.js
const BaseApp = require(__dirname + "/base/BaseApp.js");
class App extends BaseApp {
	get mainDatabaseFilepath() {
		return process.env.PROJECT_ROOT + "/core/database/db.js";
	}
}
module.exports = App;

# Filename: /src/core/router/base/BaseRouter.js
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

# Filename: /src/core/router/CdnRouter.configure.js
module.exports = function() {
	// @TODO:
};

# Filename: /src/core/router/CdnRouter.js
class CdnRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/CdnRouter.configure.js";
	}
}
module.exports = CdnRouter;

# Filename: /src/core/router/LiveRouter.configure.js
module.exports = function() {
	// @TODO:
};
# Filename: /src/core/router/LiveRouter.js
class LiveRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/LiveRouter.configure.js";
	}
}
module.exports = LiveRouter;

# Filename: /src/core/router/RestRouter.configure.js
module.exports = function() {
	// @TODO:
};

# Filename: /src/core/router/RestRouter.js
class RestRouter extends BaseRouter {
	static get defaultConfigureFile() {
		return __dirname + "/RestRouter.configure.js";
	}
}
module.exports = RestRouter;

# Filename: /src/core/router/WebRouter.configure.js
module.exports = function() {
	// @TODO:
};

# Filename: /src/core/router/WebRouter.js

# Filename: /src/core/router/Router.js
const BaseRouter = require(__dirname + "/base/BaseRouter.js");
class Router extends BaseRouter {}
module.exports = Router;

# Filename: /src/core/router/Router.configure.js
module.exports = function() {
	// @TODO:
};

# Directory: /src/core/config
# Filename: /src/core/config/database-schema.extension.json
# Filename: /src/core/config/database-schema.json
# Filename: /src/core/config/metadata-dependencies.json
# Directory: /src/core/controller
# Directory: /src/core/controller/base
# Filename: /src/core/controller/base/ControllerGroup.js
# Filename: /src/core/controller/base/EjsController.js
# Filename: /src/core/controller/base/EjsPageController.js
# Filename: /src/core/controller/base/Html404Controller.js
# Filename: /src/core/controller/base/JsFileController.js
# Filename: /src/core/controller/base/Json404Controller.js
# Filename: /src/core/controller/base/JsonFileController.js
# Filename: /src/core/controller/base/JsonFileIoController.js
# Filename: /src/core/controller/base/JsonFileIoMasterController.js
# Filename: /src/core/controller/base/ModelController.js
# Filename: /src/core/controller/base/RestController.js
# Filename: /src/core/controller/base/StaticController.js
# Filename: /src/core/controller/base/StaticEjsController.js
# Filename: /src/core/controller/base/Controller.js
# Directory: /src/core/controller/backoffice
# Filename: /src/core/controller/backoffice/BackOfficeController.js
# Directory: /src/core/controller/auth
# Filename: /src/core/controller/auth/LoginController.js
# Filename: /src/core/controller/auth/LoginPageController.js
# Filename: /src/core/controller/auth/LogoutController.js
# Filename: /src/core/controller/auth/RecoverController.js
# Filename: /src/core/controller/auth/RegisterController.js
# Filename: /src/core/controller/auth/UnregisterController.js
# Directory: /src/core/controller/rest
# Directory: /src/core/controller/rest/base
# Filename: /src/core/controller/rest/base/BaseCommunityController.js
# Filename: /src/core/controller/rest/base/BaseEjemplosController.js
# Filename: /src/core/controller/rest/base/BaseMembershipController.js
# Filename: /src/core/controller/rest/base/BasePermissionController.js
# Filename: /src/core/controller/rest/base/BasePermissionPerRoleController.js
# Filename: /src/core/controller/rest/base/BaseRoleController.js
# Filename: /src/core/controller/rest/base/BaseSessionController.js
# Filename: /src/core/controller/rest/base/BaseUserController.js
# Filename: /src/core/controller/rest/CommunityController.js
# Filename: /src/core/controller/rest/EjemplosController.js
# Filename: /src/core/controller/rest/MembershipController.js
# Filename: /src/core/controller/rest/PermissionController.js
# Filename: /src/core/controller/rest/PermissionPerRoleController.js
# Filename: /src/core/controller/rest/RoleController.js
# Filename: /src/core/controller/rest/SessionController.js
# Filename: /src/core/controller/rest/UserController.js
# Filename: /src/core/controller/controllers.js
# Directory: /src/core/database
# Filename: /src/core/database/db.js
let connection = undefined;
module.exports = new Promise((resolve, reject) => {
	if(!connection) {
		// @TODO: the process to get the connection goes here: set the connection variable
	}
	return resolve(connection);
};
# Filename: /src/core/database/db2.js
# Filename: /src/core/database/db3.js
# Directory: /src/core/error
# Directory: /src/core/error/base
# Filename: /src/core/error/base/BaseError.js
# Filename: /src/core/error/ErrorManager.js
# Directory: /src/core/helper
# Directory: /src/core/helper/base
# Filename: /src/core/helper/base/Tools.js
class Tools {
	static get(...toolNames) {
		const tools = {};
		toolNames.forEach(toolName => {
			const tool = require(__dirname + "/../" + toolName + ".js");
			tools[toolName] = tool;
		});
	}
}
module.exports = Tools;
# Filename: /src/core/helper/AuthenticationManager.js
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
# Filename: /src/core/helper/CheckManager.js
# Filename: /src/core/helper/CliUtils.js
# Filename: /src/core/helper/CollectionManager.js
# Filename: /src/core/helper/DBManager.js
# Filename: /src/core/helper/dd.js
# Filename: /src/core/helper/ImportManager.js
# Filename: /src/core/helper/LoggerManager.js
# Filename: /src/core/helper/ModelManager.js
# Filename: /src/core/helper/ParametersManager.js
# Filename: /src/core/helper/ReflectionManager.js
# Filename: /src/core/helper/ResponseManager.js
# Filename: /src/core/helper/SessionManager.js
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
# Filename: /src/core/helper/StoreManager.js
# Filename: /src/core/helper/StringUtils.js
# Filename: /src/core/helper/TemplateManager.js
# Directory: /src/core/middleware
# Directory: /src/core/middleware/base
# Filename: /src/core/middleware/base/BaseMiddleware.js
# Filename: /src/core/middleware/AuthMiddleware.js
# Directory: /src/core/model
# Directory: /src/core/model/base
# Filename: /src/core/model/base/BaseCommunity.js
# Filename: /src/core/model/base/BaseEjemplos.js
# Filename: /src/core/model/base/BaseMembership.js
# Filename: /src/core/model/base/BasePermission.js
# Filename: /src/core/model/base/BasePermissionPerRole.js
# Filename: /src/core/model/base/BaseRole.js
# Filename: /src/core/model/base/BaseSession.js
# Filename: /src/core/model/base/BaseUser.js
# Filename: /src/core/model/Community.js
# Filename: /src/core/model/Ejemplos.js
# Filename: /src/core/model/Membership.js
# Filename: /src/core/model/models.js
# Filename: /src/core/model/Permission.js
# Filename: /src/core/model/PermissionPerRole.js
# Filename: /src/core/model/Role.js
# Filename: /src/core/model/Session.js
# Directory: /src/core/public
# Directory: /src/core/public/rendered
# Filename: /src/core/public/rendered/home.ejs
# Directory: /src/core/public/static
# Directory: /src/core/public/static/assets
# Directory: /src/core/public/static/assets/img
# Directory: /src/core/public/static/assets/lib
# Filename: /src/core/public/static/assets/lib/bootstrap.css
# Filename: /src/core/public/static/assets/lib/bootstrap.js
# Filename: /src/core/public/static/assets/lib/custom.rest.css
# Filename: /src/core/public/static/assets/lib/global.1.js
# Filename: /src/core/public/static/assets/lib/jquery.js
# Filename: /src/core/public/static/assets/lib/popper.js
# Directory: /src/core/query
# Directory: /src/core/query/base
# Directory: /src/core/query/base/BaseQuery.js
# Filename: /src/core/query/InsertSessionByUserId.js
# Filename: /src/core/query/SelectUserByNameOrEmail.js
# Filename: /src/core/model/User.js
# Directory: /src/core/store
# Directory: /src/core/store/base
# Filename: /src/core/store/base/BaseStore.js
# Filename: /src/core/store/JsonFileStore.js
# Filename: /src/core/store/RawFileStore.js
# Filename: /src/core/store/TextFileStore.js
# Directory: /src/core/template
# Directory: /src/core/template/html
# Directory: /src/core/template/html/error
# Filename: /src/core/template/html/error/404.ejs
# Directory: /src/core/template/html/auth
# Filename: /src/core/template/html/auth/login.ejs
# Filename: /src/core/template/html/auth/logout.ejs
# Filename: /src/core/template/html/auth/register.ejs
# Filename: /src/core/template/html/auth/remind.ejs
# Directory: /src/core/template/html/page
# Filename: /src/core/template/html/page/home.ejs
# Directory: /src/core/template/html/partial
# Filename: /src/core/template/html/partial/footer.ejs
# Filename: /src/core/template/html/partial/header.ejs
# Filename: /src/core/template/html/partial/menu.ejs
# Directory: /src/core/template/html/menu
# Filename: /src/core/template/html/menu/nav.ejs
# Directory: /src/core/template/html/rest
# Filename: /src/core/template/html/rest/overview.ejs
# Filename: /src/core/template/html/rest/view-many.ejs
# Filename: /src/core/template/html/rest/view-one.ejs
# Filename: /src/env.js
# Filename: /src/load.js
# Filename: /src/start.js
# Directory: /test
# Directory: /test/e2e
# Directory: /test/unit
