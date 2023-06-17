<div align=center>
<h1>CatLibs 🐈</h1>
<p>ScriptModule based game framework for Roblox</p>
</div>

# Usage
CatLibs (as an engine), loads `ModuleScripts` with the `ScriptModule` tag. It should
realistically be placed in `ReplicatedFirst` such that you can implement all sorts of
loading behaviour

This allows you to create ModuleScripts that behave like scripts. You can also
disabe ScriptModules by adding an `Enabled` tag and setting it to false.

# Libraries
Under the `Libs` folder lives the main library sourcecode behind CatLibs. If you want
CatLibs just for the libraries, you can remove the `Engine` and export this into
`ReplicatedStorage` as a package.


metatablecat 2023
