const core = require('@actions/core');
const exec = require('@actions/exec');
const tc = require('@actions/tool-cache');
const fs = require('fs');

async function main() {
    const urls = {
        'linux': 'https://firebase.tools/bin/linux/latest',
        'macos': 'https://firebase.tools/bin/macos/latest',
        'win32': 'https://firebase.tools/bin/win/instant/latest',
    };

    const destination = core.getInput('destination', { required: false }) || '.';
    const firebasePath = `${destination}/firebase`;

    if (fs.existsSync(firebasePath)) {
        await exec.exec(`chmod +x ${firebasePath}`);
        return;
    }

    const downloadUrl = urls[process.platform] || '';
    sourceFile = await tc.downloadTool(downloadUrl, firebasePath);
    await exec.exec(`chmod +x ${firebasePath}`);
}

main();
