
const BaseApp = require(__dirname + "/base/BaseApp.js");
class App extends BaseApp {
	get mainDatabaseFilepath() {
		return process.env.PROJECT_ROOT + "/core/database/db.js";
	}
}
module.exports = App;