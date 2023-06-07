--!nocheck
-- Common Package initialiser
export type Package<T> = {
	Name: string,
	Version: number
} & T

local PACKAGE_MT = {
	__tostring = function(self)
		return `CatLibsPackage<{self.Name}>`
	end
}

type PackageMetadata = {
	Name: string,
	Version: string
}

local function CatLibsPackage<T>(package: T, metadata: PackageMetadata, deps: {string}?): () -> Package<T>
	local pack = {}
	package.Name = metadata.Name
	package.Version = metadata.Version

	if deps then
		local missing = {}
		for _, dep in deps do
			if not script.Parent:FindFirstChild(dep) then
				table.insert(missing, dep)
			end
		end

		local count = #missing
		if count > 0 then
			local dep = `\n* {table.concat(missing, "\n* ")}`
			error(`Cannot load package {package.Name} because the following {count} dependency(ies) are missing:{dep}`)
		end
	end

	return function()
		setmetatable(package, PACKAGE_MT)
		table.freeze(package)
		return package
	end
end

return CatLibsPackage