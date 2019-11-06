
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