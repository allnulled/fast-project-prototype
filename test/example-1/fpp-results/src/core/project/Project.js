
const BaseProject = require(__dirname + "/base/BaseProject.js");
const App = require(process.env.PROJECT_ROOT + "/core/app/App.js");
class Project extends BaseProject {
	static get defaultApp() {
		return App;
	}
}
module.exports = Project;