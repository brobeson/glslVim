" Vim completion script
" Language:		OpenGL Shading Language (GLSL)
" Maintainer:	Brendan Robeson (https://github.com/brobeson/glslVim)
" Last Change:	2015 August 8

let s:cpo_save = &cpo
set cpo&vim

" GLSL built ins {{{
" start with the macros (kind = d)
let s:glsl_builtins = [
	\ { 'kind': 'd', 'word': '__FILE__',                 'abbr': '__FILE__',                 'info': 'Integer representing the current source string.' },
	\ { 'kind': 'd', 'word': '__LINE__',                 'abbr': '__LINE__',                 'info': 'The line number where the macro is used.' },
	\ { 'kind': 'd', 'word': '__VERSION__',              'abbr': '__VERSION__',              'info': 'Integer representing the GLSL version used.' },
	\ { 'kind': 'v', 'word': 'gl_ClipDistance',          'abbr': 'gl_ClipDistance',          'info': "Vertex shader output: the distance from the vertex to each clipping half-space.\nTessallation control shader input/output: the distance from the vertex to each clipping half-space.\nTessallation evaluation shader input/output: the distance from the vertex to each clipping half-space.\nGeometry shader input/output: the distance from the vertex to each clipping half-space.\nFragment shader input: the interpolated clipping plane half-spaces." },
	\ { 'kind': 'd', 'word': 'GL_compatibility_profile', 'abbr': 'GL_compatibility_profile', 'info': 'Defined as 1 if the shader profile was set to "compatibility"' },
	\ { 'kind': 'd', 'word': 'GL_core_profile',          'abbr': 'GL_core_profile',          'info': 'Defined as 1 if the shader profile was set to "core".' },
	\ { 'kind': 'v', 'word': 'gl_CullDistance',          'abbr': 'gl_CullDistance',          'info': "no documentation available" },
	\ { 'kind': 'd', 'word': 'GL_es_profile',            'abbr': 'GL_es_profile',            'info': 'Defined as 1 if the shader profile was set "es".' },
	\ { 'kind': 'v', 'word': 'gl_FragCoord',             'abbr': 'gl_FragCoord',             'info': "Fragment shader input: The fragment's location in window space." },
	\ { 'kind': 'v', 'word': 'gl_FragDepth',             'abbr': 'gl_FragDepth',             'info': "Fragment shader output: The depth of the fragment." },
	\ { 'kind': 'v', 'word': 'gl_FrontFacing',           'abbr': 'gl_FrontFacing',           'info': "Fragment shader input: True if the fragment is front facing, false if it is back facing." },
	\ { 'kind': 'v', 'word': 'gl_GlobalInvocationID',    'abbr': 'gl_GlobalInvocationID',    'info': "Compute shader input: The unique ID for an invocation of a compute shader, with a work group." },
	\ { 'kind': 'v', 'word': 'gl_HelperInvocation',      'abbr': 'gl_HelperInvocation',      'info': "no documentation available" },
	\ { 'kind': 'v', 'word': 'gl_in',                    'abbr': 'gl_in',                    'info': "Tessallation control shader input: The instance of gl_PerVertex.\nTessallation evaluation shader input: The instance of gl_PerVertex.\nGeometry shader input: The instance if gl_PerVertex." },
	\ { 'kind': 'v', 'word': 'gl_InstanceID',            'abbr': 'gl_InstanceID',            'info': "Vertex shader input: the index of the current instance when using instanced rendering. 0 otherwise." },
	\ { 'kind': 'v', 'word': 'gl_InvocationID',          'abbr': 'gl_InvocationID',          'info': "Tessallation control shader input: the index of the TCS invocation in this patch.\nGeometry shader input: the current instance." },
	\ { 'kind': 'v', 'word': 'gl_Layer',                 'abbr': 'gl_Layer',                 'info': "Geometry shader output: the layer to which a primitive goes to.\nFragment shader input: the layer for the fragment, output by the geometry shader." },
	\ { 'kind': 'v', 'word': 'gl_LocalGroupSize',        'abbr': 'gl_LocalGroupSize',        'info': "no documentation available" },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationID',     'abbr': 'gl_LocalInvocationID',     'info': "Compute shader input: the current invocation of the shader within the work group." },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationIndex',  'abbr': 'gl_LocalInvocationIndex',  'info': "Compute shader input: the (1D) index of the shader invocation within the work group." },
	\ { 'kind': 'v', 'word': 'gl_NumWorkGroups',         'abbr': 'gl_NumWorkGroups',         'info': "Compute shader input; the number of work groups used when dispatching the compute shader." },
	\ { 'kind': 'v', 'word': 'gl_out',                   'abbr': 'gl_out',                   'info': "Tessalation control shader output: the instance of gl_PerVertex." },
	\ { 'kind': 'v', 'word': 'gl_PatchVerticesIn',       'abbr': 'gl_PatchVerticesIn',       'info': "Tessallation control shader inputs: the number of vertices in the input patch.\nTessallation evaluation shader input: the number of vertices for the patch being processed." },
	\ { 'kind': 'v', 'word': 'gl_PerVertex',             'abbr': 'gl_PerVertex',             'info': "Vertex shader output: an unnamed interface block for vertex shader output.\nTessallation control shader input: the named interface block of data from the vertex shader.\nTessallation control shader output: the named interface block for (optional) TCS output.\nTessalation evaluation shader input: the named interface block for data from the TCS.\nTessallation evaluation shader output: an unnamed interface block for output data.\nGeometry shader input: the named interface block from a prior shading stage.\nGeometry shader output: the required, unnamed interface block for output to the FS" },
	\ { 'kind': 'v', 'word': 'gl_PointCoord',            'abbr': 'gl_PointCoord',            'info': "Fragment shader input: the location within a point primitive of the fragment." },
	\ { 'kind': 'v', 'word': 'gl_PointSize',             'abbr': 'gl_PointSize',             'info': "Vertex shader output:\nTessallation control shader input/output:\nTessallation evaluation shader input/output:\nGeometry shader input/output:\n   the pixel width and height of the point being rasterized." },
	\ { 'kind': 'v', 'word': 'gl_Position',              'abbr': 'gl_Position',              'info': 'Vertex shader output:\nTessallation control shader input/output:Tessallation evaluation shader input/output:Geometry shader input/output:\n    the clipping space output position of the vertex.' },
	\ { 'kind': 'v', 'word': 'gl_PrimitiveID',           'abbr': 'gl_PrimitiveID',           'info': "Tessallation control shader input:\n    the index of the current patch.\nGeometry shader output:\n    the primitive ID to send to the fragement shader.\nFragment shader input:\n    the index of the current primitive." },
	\ { 'kind': 'v', 'word': 'gl_PrimitiveIDIn',         'abbr': 'gl_PrimitiveIDIn',         'info': "Geometry shader input: the ID of the current input primitive." },
	\ { 'kind': 'v', 'word': 'gl_SampleID',              'abbr': 'gl_SampleID',              'info': "Fragment shader input: the ID of the current sample within a fragment." },
	\ { 'kind': 'v', 'word': 'gl_SampleMask',            'abbr': 'gl_SampleMask',            'info': "Fragment shader output: the sample mask for the fragment, when using multisampled rendering." },
	\ { 'kind': 'v', 'word': 'gl_SampleMaskIn',          'abbr': 'gl_SampleMaskIn',          'info': "Fragment shader input: bitfield for the sample mask of the current fragment." },
	\ { 'kind': 'v', 'word': 'gl_SamplePosition',        'abbr': 'gl_SamplePosition',        'info': "Fragment shader input: the location of the current sample within the current fragment." },
	\ { 'kind': 'v', 'word': 'gl_TessCoord',             'abbr': 'gl_TessCoord',             'info': "Tessallation evaluation shader input: the location of a vertex within the tessallated abstract patch." },
	\ { 'kind': 'v', 'word': 'gl_TessLevelInner',        'abbr': 'gl_TessLevelInner',        'info': "Tessallation control shader output: the inner tessallation level.\nTessallation evaluation shader input: the inner tessallation level from the TCS." },
	\ { 'kind': 'v', 'word': 'gl_TessLevelOuter',        'abbr': 'gl_TessLevelOuter',        'info': "Tessallation control shader output: the outer tessallation level.\nTessallation evaluation shader input: the outer tessallation level from the TCS." },
	\ { 'kind': 'v', 'word': 'gl_VertexID',              'abbr': 'gl_VertexID',              'info': "Vertex shader input:\n    the index of the vertex currently being processed." },
	\ { 'kind': 'v', 'word': 'gl_ViewportIndex',         'abbr': 'gl_ViewportIndex',         'info': "Geometry shader output: specifies which viewport to use for the primitive.\nFragment shader input: 0, or the viewport index for the primitive from the GS." },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupID',           'abbr': 'gl_WorkGroupID',           'info': "Compute shader input: the current work group for the shader invocation." },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupSize',         'abbr': 'gl_WorkGroupSize',         'info': "Compute shader constant: the size of the local work group." }
	\ ]
" }}}

" GLSL built in constants {{{
let s:constants =	[	"gl_MaxAtomicCounterBindings",
					\	"gl_MaxAtomicCounterBufferSize",
					\	"gl_MaxClipDistances",
					\	"gl_MaxCombinedAtomicCounterBuffers",
					\	"gl_MaxCombinedAtomicCounters",
					\	"gl_MaxCombinedClipAndCullDistances",
					\	"gl_MaxCombinedImageUnitsAndFragmentOutputs",
					\	"gl_MaxCombinedImageUniforms",
					\	"gl_MaxCombinedShaderOutputResources",
					\	"gl_MaxCombinedTextureImageUnits",
					\	"gl_MaxComputeAtomicGounterBuffers",
					\	"gl_MaxComputeAtomicCounters",
					\	"gl_MaxComputeImageUniforms",
					\	"gl_MaxComputeTextureImageUnits",
					\	"gl_MaxComputeUniformComponents",
					\	"gl_MaxComputeWorkGroupCount",
					\	"gl_MaxComputeWorkGroupSize",
					\	"gl_MaxCullDistances",
					\	"gl_MaxProgramTexelOffset",
					\	"gl_MaxDrawBuffers",
					\	"gl_MaxFragmentAtomicCounterBuffers",
					\	"gl_MaxFragmentAtomicCounters",
					\	"gl_MaxFragmentImageUniforms",
					\	"gl_MaxFragmentInputComponents",
					\	"gl_MaxFragmentUniformComponents",
					\	"gl_MaxFragmentUniformVectors",
					\	"gl_MaxGeometryAtomicCounterBuffers",
					\	"gl_MaxGeometryAtomicCounters",
					\	"gl_MaxGeometryImageUniforms",
					\	"gl_MaxGeometryInputComponents",
					\	"gl_MaxGeometryOutputComponents",
					\	"gl_MaxGeometryOutputVertices",
					\	"gl_MaxGeometryTextureImageUnits",
					\	"gl_MaxGeometryTotalOutputComponents",
					\	"gl_MaxGeometryUniformComponents",
					\	"gl_MaxGeometryVaryingComponents",
					\	"gl_MaxImageSamples",
					\	"gl_MaxImageUnits",
					\	"gl_MaxPatchVertices",
					\	"gl_MaxSamples",
					\	"gl_MaxTessControlAtomicCounterBuffers",
					\	"gl_MaxTessControlAtomicCounters",
					\	"gl_MaxTessControlImageUniforms",
					\	"gl_MaxTessControlInputComponents",
					\	"gl_MaxTessControlOutputComponents",
					\	"gl_MaxTessControlTextureImageUnits",
					\	"gl_MaxTessControlTotalOutputComponents",
					\	"gl_MaxTessControlUniformComponents",
					\	"gl_MaxTessEvaluationAtomicCounterBuffers",
					\	"gl_MaxTessEvaluationAtomicCounters",
					\	"gl_MaxTessEvaluationImageUniforms",
					\	"gl_MaxTessEvaluationInputComponents",
					\	"gl_MaxTessEvaluationOutputComponents",
					\	"gl_MaxTessEvaluationTextureImageUnits",
					\	"gl_MaxTessEvaluationUniformComponents",
					\	"gl_MaxTessGenLevel",
					\	"gl_MaxTessPatchComponents",
					\	"gl_MaxTextureImageUnits",
					\	"gl_MaxTransformFeedbackBuffers",
					\	"gl_MaxTransformFeedbackInterleavedComponents",
					\	"gl_MaxVaryingComponents",
					\	"gl_MaxVaryingVectors",
					\	"gl_MaxVertexAtomicCounterBuffers",
					\	"gl_MaxVertexAtomicCounters",
					\	"gl_MaxVertexAttribs",
					\	"gl_MaxVertexImageUniforms",
					\	"gl_MaxVertexOutputComponents",
					\	"gl_MaxVertexTextureImageUnits",
					\	"gl_MaxVertexUniformComponents",
					\	"gl_MaxVertexUniformVectors",
					\	"gl_MaxViewports",
					\	"gl_MinProgramTexelOffset" ]
"}}}

" GLSL built in functions {{{
let s:functions =	[	"abs",
					\	"acos",
					\	"acosh",
					\	"any",
					\	"asin",
					\	"asinh",
					\	"atan",
					\	"atanh",
					\	"atomicCounter",
					\	"atomicCounterDecrement",
					\	"atomicCounterIncrement",
					\	"atomicAdd",
					\	"atomicAnd",
					\	"atomicCompSwap",
					\	"atomicExchange",
					\	"atomicMax",
					\	"atomicMin",
					\	"atomicOr",
					\	"atomicXor",
					\	"barrier",
					\	"bitCount",
					\	"bitfieldExtract",
					\	"bitfieldInsert",
					\	"bitfieldReverse",
					\	"ceil",
					\	"clamp",
					\	"cos",
					\	"cosh",
					\	"cross",
					\	"degrees",
					\	"determinant",
					\	"dFdx",
					\	"dFdxCoarse",
					\	"dFdxFine",
					\	"dFdy",
					\	"dFdyCoarse",
					\	"dFdyFine",
					\	"distance",
					\	"dot",
					\	"EmitStreamVertex",
					\	"EmitVertex",
					\	"EndPrimitive",
					\	"EndStreamPrimitive",
					\	"equal",
					\	"exp",
					\	"exp2",
					\	"faceforward",
					\	"findLSB",
					\	"findMSB",
					\	"floatBitsToInt",
					\	"floatBitsToUint",
					\	"floor",
					\	"fma",
					\	"fract",
					\	"frexp",
					\	"fwidth",
					\	"fwidthCoarse",
					\	"fwidthFine",
					\	"greaterThan",
					\	"greaterThanEqual",
					\	"groupMemoryBarrier",
					\	"imageAtomicAdd",
					\	"imageAtomicAnd",
					\	"imageAtomicCompSwap",
					\	"imageAtomicExchange",
					\	"imageAtomicMax",
					\	"imageAtomicMin",
					\	"imageAtomicOr",
					\	"imageAtomicXor",
					\	"imageLoad",
					\	"imageSamples",
					\	"imageSize",
					\	"imageStore",
					\	"imulExtended",
					\	"intBitsToFloat",
					\	"interpolateAtCentroid",
					\	"interpolateAtOffset",
					\	"interpolateAtSample ",
					\	"inverse",
					\	"inversesqrt",
					\	"isinf",
					\	"isnan",
					\	"ldexp",
					\	"length",
					\	"lessThan",
					\	"lessThanEqual",
					\	"log",
					\	"log2",
					\	"matrixCompMult",
					\	"max",
					\	"memoryBarrier",
					\	"memoryBarrierAtomicCounter",
					\	"memoryBarrierBuffer",
					\	"memoryBarrierImage",
					\	"memoryBarrierShared",
					\	"min",
					\	"mix",
					\	"mod",
					\	"modf",
					\	"noise1",
					\	"noise2",
					\	"noise3",
					\	"noise4",
					\	"normalize",
					\	"not",
					\	"notEqual",
					\	"outerProduct",
					\	"packDouble2x32",
					\	"packHalf2x16",
					\	"packSnorm2x16",
					\	"packSnorm4x8",
					\	"packUnorm2x16",
					\	"packUnorm4x8",
					\	"pow",
					\	"radians",
					\	"reflect",
					\	"refract",
					\	"round",
					\	"roundEven",
					\	"sign",
					\	"sin",
					\	"sinh",
					\	"smoothstep",
					\	"sqrt",
					\	"step",
					\	"tan",
					\	"tanh",
					\	"texelFetch",
					\	"texelFetchOffset",
					\	"texture",
					\	"textureGather",
					\	"textureGatherOffset",
					\	"textureGatherOffsets",
					\	"textureGrad",
					\	"textureGradOffset",
					\	"textureLod",
					\	"textureLodOffset",
					\	"textureOffset",
					\	"textureProj",
					\	"textureProjGrad",
					\	"textureProjGradOffset",
					\	"textureProjLod",
					\	"textureProjLodOffset",
					\	"textureProjOffset",
					\	"textureQueryLod",
					\	"textureQueryLevels",
					\	"textureSamples",
					\	"textureSize",
					\	"transpose",
					\	"trunc",
					\	"uaddCarry",
					\	"uintBitsToFloat",
					\	"umulExtended",
					\	"unpackDouble2x32",
					\	"unpackHalf2x16",
					\	"unpackSnorm2x16",
					\	"unpackSnorm4x8",
					\	"unpackUnorm2x16",
					\	"unpackUnorm4x8",
					\	"usubBorrow",
					\	"contained" ]
"}}}

" GLSL built in variables {{{
let s:variables =	[	"gl_ClipDistance",
					\	"gl_CullDistance",
					\	"gl_FragCoord",
					\	"gl_FragDepth",
					\	"gl_FrontFacing",
					\	"gl_GlobalInvocationID",
					\	"gl_HelperInvocation",
					\	"gl_in",
					\	"gl_InstanceID",
					\	"gl_InvocationID",
					\	"gl_Layer",
					\	"gl_LocalGroupSize",
					\	"gl_LocalInvocationID",
					\	"gl_LocalInvocationIndex",
					\	"gl_NumWorkGroups",
					\	"gl_out",
					\	"gl_PatchVerticesIn",
					\	"gl_PerVertex",
					\	"gl_PointCoord",
					\	"gl_PointSize",
					\	"gl_Position",
					\	"gl_PrimitiveID",
					\	"gl_PrimitiveIDIn",
					\	"gl_SampleID",
					\	"gl_SampleMask",
					\	"gl_SampleMaskIn",
					\	"gl_SamplePosition",
					\	"gl_TessCoord",
					\	"gl_TessLevelInner",
					\	"gl_TessLevelOuter",
					\	"gl_VertexID",
					\	"gl_ViewportIndex",
					\	"gl_WorkGroupID",
					\	"gl_WorkGroupSize" ]
"}}}

" This function is used for the 'omnifunc' option.
function! glslcomplete#Complete(findstart, base)
	if a:findstart
		" Locate the start of the item
		let line = getline('.')
		let start = col('.') - 1
		while (0 < start) && (line[start - 1] =~'\w')
			let start -= 1
		endwhile
		let g:glsl_cache = start
		return start
	endif

	" Return list of matches.
	" Don't do anything for an empty base, would result in all the tags in the
	" tags file.
	if a:base == ''
		return []
	endif

	let base_pattern = '^' . a:base
	let matches = []
	for builtin in s:glsl_builtins
		if builtin['abbr'] =~ base_pattern
			call add(matches, builtin)
		endif
	endfor
	for variable in s:variables
		if variable =~ base_pattern
			call add(matches, variable)
		endif
	endfor
	for builtinf in s:functions
		if builtinf =~ base_pattern
			call add(matches, builtinf)
		endif
	endfor
	for constant in s:constants
		if constant =~ base_pattern
			call add(matches, constant)
		endif
	endfor

	return matches
endfunc

let &cpo = s:cpo_save
unlet s:cpo_save

