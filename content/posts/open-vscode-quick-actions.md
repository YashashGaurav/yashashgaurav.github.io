---
title: "Open VSCode using Quick Actions"
date: 2022-06-08
draft: false
tags: ["VSCode", "Quick Actions", "Shortcuts"]
categories: ["Automation"]
author: "Yashash Gaurav"
showToc: false
description: "Set up a macOS Quick Action to open any folder in VS Code with a right-click — using the Shortcuts app, no Automator needed."
cover:
  image: "/images/posts/open-vscode-quick-actions_cover.png"
  alt: "Windows right-click context menu showing Open with Code option"
---

I have been struggling with dragging and dropping folders onto open VS Code instances to open folders for some time. I liked how you could right-click and open a folder on VS Code directly from the Right-Click Popup Menu on my Windows Machine (fig below):

So I found a way using MacOS' Shortcuts! (Without using Automator)

Here are the steps:

1. Open the 'Shortcuts' app on your Mac
2. On the Left Pane, navigate to 'Quick Actions'
3. On the top bar, press the ➕ button to add New Shortcut.
4. Click on 'Any' and change to 'Files and Folders' by selecting only those from the dropdown that appears on clicking the 'Any' field.

   ![Shortcut input set to receive Files and Folders from Quick Actions](/images/posts/open-vscode-quick-actions_step-01.png)

5. Click on 'Action Library' on the right pane and search for 'shell'. Drag and drop the 'Run Shell Script' onto the main pane. This will add the action to the Shortcut's flow.

   ![Action Library with shell script search results](/images/posts/open-vscode-quick-actions_step-02.png)

6. In the shortcut details (on the right pane), make sure Use as Quick Action is ticked and so are 'Finder' and 'Service Menu'.

   ![Shortcut details pane with Quick Action settings enabled](/images/posts/open-vscode-quick-actions_step-03.png)

7. In the newly added action called 'Run Shell Script' write `code ` and right-click to get the below pop-up, go ahead 'Insert variable' and then 'Shortcut Input'

   ![Run Shell Script action with Insert Variable popup](/images/posts/open-vscode-quick-actions_step-04.png)

8. Click on the 'Shortcut Input' tag that appears. A pop-up must appear, choose 'File Path' and just click anywhere else. This will change the tag to 'File Path'

   ![Shortcut Input tag showing File Path selection](/images/posts/open-vscode-quick-actions_step-05.png)

9. Set 'Pass Input:' option to 'as arguments'

   ![Pass Input set to as arguments](/images/posts/open-vscode-quick-actions_step-06.png)

10. Be sure to set a cool name for your new Shortcut! I named mine a boring "Open in VSCode". 😅

    ![Shortcut named Open in VSCode](/images/posts/open-vscode-quick-actions_step-07.png)

11. Open a new 'Finder' Instance, right-click on a folder, go to 'Quick Actions' > 'Customize...' (ignore my already added Open in VSCode Shortcut)

    ![Finder right-click showing Quick Actions menu](/images/posts/open-vscode-quick-actions_step-08.png)

12. Make sure your Shortcut's Name is selected. Exit the dialogue and Test!
