-- Example package for creating your own packages
-- This implements a simple MeowService that
-- creates an Action that meows
-- Step 1: Create the package
local Package = require(script.Parent.Package)
local MeowService = {}
local MeowServicePackage = Package(MeowService, {
	Name = "MeowService",
	Version = "0.0.0"
}, {
	"TabbyCoreLib"
})

-- Step 2: Grab Types module (Recomended)
local Types = require(script.Types)

-- Step 3: Create Exports
MeowService.Meower = require(script.Meower)
export type Meower = Types.Meower

-- Step 4: Build and return package
return MeowServicePackage()