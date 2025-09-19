import type { Plugin } from "@opencode-ai/plugin"
import { $ } from "bun";

export const MyPlugin: Plugin = async ({ project, client, $, directory, worktree }) => {
  return {
    event: async ({event}) => {
      if (event.type == "session.idle"){
        // const pwd = await $`pwd`
        //
        // // If we're in the transcend/main directory, run pre-commit
        // if (pwd.text().includes("transcend/main")){
        //   // TODO: We need this to not output to the console
        //   const preCommit = await $`git add -A && pre-commit run && git add -A`
        //
        //   if (preCommit.exitCode != 0){
        //     throw new Error(`Pre-commit failed:\n${preCommit.text()}`)
        //   }
        //
        // }
      }
    }
  }
}
