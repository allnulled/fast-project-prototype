# fast-project-prototype

Small syntax to fastly create projects with lots of files from 1 file.

## Installation

`$ npm i -g fast-project-prototype`

## Usage

From CLI or API.

### API usage

```
const fpp = require("fast-project-prototype");

const source = `# Project:
# Filename:/hello/world.txt
Hello, world from FPP!
`;

fpp.parse(source); // This will generate /hello/world.txt
```

### CLI usage

`$ fpp myproject.fpp`

## Syntax

Start always with `# Project:` sentence, then append all the files or directories you want (you do not need to create the previous directories):

```
# Project:
# Filename: my/welcome/file.txt
This is content of my welcome file!
# Directory: my/folder
```

## Notes

The path of the output is always relative to the process.cwd + `fpp-results`.



