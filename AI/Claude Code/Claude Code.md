[Claude Code cheat sheet](https://cc.storyfox.cz)
# Slash Commands

| Command                | Description                                                                                                                                                             |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| /resume                | Resumes a previous conversation.                                                                                                                                        |
| /login                 | _If you have to ask, you likely have bigger problems ahead of you._                                                                                                     |
| /rename <session_name> | Rename a current session if you want to continue later. e.g., /resume my_session                                                                                        |
| /status                | Shows header data for the project                                                                                                                                       |
| /usage                 | Shows usage statistics of Claude Code                                                                                                                                   |
| /context               | Shows context window details.                                                                                                                                           |
| /mcp                   | View connected MCP servers.                                                                                                                                             |
| /init                  | Initializes the directory for Claude Code.                                                                                                                              |
| /doctor                | Diagnostics. "Is everything working?"                                                                                                                                   |
| /model                 | Allows one to change the model is use: Opus, Sonnet, Haiku.                                                                                                             |
| /stats                 | To view usage patterns.                                                                                                                                                 |
| /effort                | Allows one to select the balance between Speed and Intelligence. Default: High                                                                                          |
| /compact               | Manual trigger for summarization. Info + context will get lost. Use carefully.                                                                                          |
| /btw                   | Allows user to ask questions in parallel. No tool use; only basic stuff.                                                                                                |
| /export                | Copy the conversation to the clipboard.                                                                                                                                 |
| /statusline            | Allows one to generate custom status lines in the CLI based on the prompt provided.                                                                                     |
| /sandbox               | Enables sandbox mode and installs needed security dependencies. N.B., that sandbox mode only blocks the `bash` tool. Other tools can still be freely used by the agent. |

# Hotkeys

| Hotkey      | Description                                      |
| ----------- | ------------------------------------------------ |
| CTRL + L    | Clear terminal. Session/Conversation unaffected. |
| CTRL + T    | Toggle task list.                                |
| SHIFT + TAB | Toggle permission mode.                          |
| CTRL + O    | For history (of changes?)                        |

# Claude Code Essentials

![[../media/AI/agentic-loop.png]]
The agentic loop is powered by:
* The model --> Sonnet: coding; Opus: reasoning
* Tools --> file ops, search, execute, web, code intelligence.

Claude has access to:
* Project directory, recursively
* Terminal commands
* Git state
* Claude.md --> sessions are ephemeral
* Configured extensions, MCP servers

Choice of models:
* Default
* Sonnet
* Opus
* Haiku
* Sonnet\[1m\]
* OpusPlan
* Fable 5

Model tier-list
![[models-tier.png]]

* `settings.json` covers multiple scoped levels for Claude Code settings. Comprehensive configurations like language, verbs, permissions, etc. can be done here. Note that permissions tiered at the tool-level (Bash, WebFetch, MCP, agents). The Claude Code core tool names are as follows: (anything with an * means it requires permissions to do)
	* WebFetch, WebSearch
	* Bash
	* Read, Write, Edit
	* mcp__\<toolname\>
	* Glob
	* Grep
	* Task*
	* Notebook*
	* ...and more tools. [Full list here](https://code.claude.com/docs/en/tools-reference)
* The scoped levels are as follows:
	* Managed settings --> organization-wide instructions managed by IT/DevOps.
	* User settings --> personal preferences for all projects.
	* Project settings --> team-shared instructions for the project.
	* Local settings --> personal project-specific preferences, not checked into git.
## Glossary
* Agentic Loop:
* Agentic Harness: 
	* The surrounding program that makes an LLM into an agent include features such as: engineered prompts, tools, and a sandbox.
* Coding Agent: 
	* The same meaning as _Agentic Harness._
* Context Window:
	* The total _working memory_ a model can hold at once. It includes input and output measured in tokens. This is functionally the _length limit_ of a session.
	* As of 2026. Haiku, Sonnet, and Opus are capped at 200k tokens for all tiers (except enterprise).
	* Opus\[1m\] has 1,000,000 tokens, but is in beta.
* Retrieval Augmented Generation (RAG):
* Sessions
	* Can be thought of as a single conversation with Claude. These conversations can span over multiple I/Os but within the same context.
	* Sessions only last 30 days.
* Tools
	* _Code functions_ that an agent is aware of and can invoke to complete their tasks.
	* Tools often call external programs and in turn let the agent interact outside its environment and predefined knowledge.
	* Without tools, the model would not be able to do anything; it would just be talking to you.
* Usage Limit:
	* Effectively your conversation budget. How much you can interact w/ Claude over a specific time. This is a rolling 5 hour window.
	* Usage of all different Claude product surfaces counts towards the same usage limit.
	* Not to be confused with _length limit_. Check _Context Window_.
# Sal-Nomad's notes
## Short Summary

Khalid Alharthi has a good breadth of knowledge on the subject. I had a meeting with him on 2026-01-20 regarding his set up and all of the features that he uses. He showed me one of the websites that he made for teaching courses on the topic. The whole website was made in only 2 days! He mentioned that he has not actively coded in quite some time and he was able to make a fully functioning, hosted website that is actively used. They had about 40+ customers so I can see that it is definitely working.

He mentioned that when subscribing to Claude Code, I should get the $100/month subscription (Max 5x). The $30 one he found to be too limiting. He also advised against using Replit or or Lovable as those are more suited towards making mockups and prototypes; not necessarily fully functioning apps.

Some other important details:
1. Claude has a plan mode and active mode. Use plan mode for understanding what will be done. This can also be supplemented with a learning feature that uses Claude to help you fill in the gaps for active learning. Needs to be explored.
2. Skills are a feature that allows the LLM to work better completing certain tasks like converting an HTML page to PPTX or PDF. They can be found in Anthropic’s github repo under skills. Here’s the link: https://github.com/anthropics/skills
3. It is important to be as specific as possible when designing the website. The more detail, the better the output.
4. To reduce hallucinations and the use of outdated packages or code, use Context7 to keep the LLM update to date. Link is here for the set up: [https://github.com/upstash/context7](https://github.com/upstash/context7)
5. There are various plugins within the CLI that can be used. Their use is not immediately clear yet to me.
6. You can ask Claude to give you a graphical breakdown of the architecture, database designs, and basically any facet of the app.
7. Claude accepts colloquial language surprisingly well.
8. Tools provides various command-like utilities within Claude that allow the LLM to behave differently such as AskUserQuestionTool which allows the LLM to ask you questions if there is any ambiguity. Research more on what tools are available.
9. Subagents are useful for creating agents that are automatically packed with their own custom prompts, context window, custom system prompt, and specific tools. E.g., you could make a ‘code reviewer’ agent, a ‘code simplifier’ agent, a ‘security reviewer’, etc.

## Writing Eval Prompts
[Reference to section](https://posthog.com/blog/stop-ai-slop?utm_source=posthog-newsletter&utm_medium=post&utm_campaign=guide_to_pm)

Some best practices for writing evaluation prompts
1. Set the domain expertise (“you are a world class sommelier” or “you are evaluating whether a user is attempting to manipulate an LLM”).
2. Be specific about pass/fail criteria.
3. Include examples of good vs. bad and edge cases when relevant.
4. Keep prompts concise and specific (avoid trying to evaluate multiple things in one shot).

Here is an example:

You are a \[DOMAIN\] evaluator judging whether an assistant response satisfies the requirement below.

Requirement:
\[One sentence describing the single behavior being evaluated.\]

Guidelines:
- This is a strict binary evaluation: only return "pass" if the requirement is clearly satisfied.
- Evaluate only the \[requirement\]. Do not grade style, tone, politeness, or creativity unless explicitly required.
- Do not assume missing information. Judge only what is present in the \<output\>.
- Return true only if the requirement is clearly satisfied.
- Return false if the response partially satisfies, avoids, or contradicts the requirement.

Examples:
- \[Pass example\]
- \[Fail example\]
- \[Edge case example\]

## Plugins
### Impeccable
[https://impeccable.style](https://impeccable.style)
Appears to be for styling and audit in frontend designs.
### Caveman
[https://github.com/JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman
For reduction in token usage when making prompts or receiving messages.
### Superpowers
[https://www.claudepluginhub.com/plugins/obra-superpowers-2](https://www.claudepluginhub.com/plugins/obra-superpowers-2)