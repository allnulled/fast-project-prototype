{

	const generateTree = function(tree) {
		const fs = require("fs");
		const fsExtra = require("fs-extra");
		const path = require("path");
		const rimraf = require("rimraf");
		const max = tree.length;
		const outputFolder = path.resolve(process.cwd(), "fpp-results");
		console.log(`Deleting previous contents from: ${outputFolder}...`);
		rimraf.sync(outputFolder);
		tree.forEach((node, index) => {
			const filepath = path.resolve(outputFolder, node.name.replace(/^\//g, ""));
			console.log(`Generating ${node.type} (node ${index}/${max})...`);
			if(node.type === "Directory") {
				try {
					fsExtra.ensureDirSync(filepath);
				} catch(error) {
					console.log("Error: ", filepath, error.message);
				}
			} else if(node.type === "Filename") {
				try {
					fsExtra.outputFileSync(filepath, node.contents);
				} catch(error) {
					console.log("Error: ", filepath, error.message);
				}
			}
		});
		console.log(`Finished with the ${max} nodes.`);
	}

}
L = "# Project:" s:S* EOS* {return generateTree(s)}
S = F
F = EOS+ "# " type:("Filename"/"Directory") ":" [ ]* name:FN contents:FC {return {type, name, contents}}
FN = (!(EOS).)+ {return text()}
FC = (!(F).)* {return text().replace(/\r\n|\n/g,"")}
EOS = "\n" / "\r\n"