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
	\ { 'kind': 'v', 'word': 'gl_ClipDistance',          'abbr': 'gl_ClipDistance',          'info': 'Distance from the vertex to each clipping half-space. Ouput from the vertex shader, IO for the tessalation and geometry shaders, and input for the fragment shader.' },
	\ { 'kind': 'd', 'word': 'GL_compatibility_profile', 'abbr': 'GL_compatibility_profile', 'info': 'Defined as 1 if the shader profile was set to "compatibility"' },
	\ { 'kind': 'd', 'word': 'GL_core_profile',          'abbr': 'GL_core_profile',          'info': 'Defined as 1 if the shader profile was set to "core".' },
	\ { 'kind': 'v', 'word': 'gl_CullDistance',          'abbr': 'gl_CullDistance',          'info': '' },
	\ { 'kind': 'd', 'word': 'GL_es_profile',            'abbr': 'GL_es_profile',            'info': 'Defined as 1 if the shader profile was set "es".' },
	\ { 'kind': 'v', 'word': 'gl_FragCoord',             'abbr': 'gl_FragCoord',             'info': '' },
	\ { 'kind': 'v', 'word': 'gl_FragDepth',             'abbr': 'gl_FragDepth',             'info': '' },
	\ { 'kind': 'v', 'word': 'gl_FrontFacing',           'abbr': 'gl_FrontFacing',           'info': '' },
	\ { 'kind': 'v', 'word': 'gl_GlobalInvocationID',    'abbr': 'gl_GlobalInvocationID',    'info': '' },
	\ { 'kind': 'v', 'word': 'gl_HelperInvocation',      'abbr': 'gl_HelperInvocation',      'info': '' },
	\ { 'kind': 'v', 'word': 'gl_in',                    'abbr': 'gl_in',                    'info': '' },
	\ { 'kind': 'v', 'word': 'gl_InstanceID',            'abbr': 'gl_InstanceID',            'info': 'Vertex shader input: the index of the current instance when using instanced rendering. 0 otherwise.' },
	\ { 'kind': 'v', 'word': 'gl_InvocationID',          'abbr': 'gl_InvocationID',          'info': 'Tessallation Control Shader Input: The index of the TCS invocation in this patch.\nGeometry Shader Input: The current instance.' },
	\ { 'kind': 'v', 'word': 'gl_Layer',                 'abbr': 'gl_Layer',                 'info': '' },
	\ { 'kind': 'v', 'word': 'gl_LocalGroupSize',        'abbr': 'gl_LocalGroupSize',        'info': '' },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationID',     'abbr': 'gl_LocalInvocationID',     'info': '' },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationIndex',  'abbr': 'gl_LocalInvocationIndex',  'info': '' },
	\ { 'kind': 'v', 'word': 'gl_NumWorkGroups',         'abbr': 'gl_NumWorkGroups',         'info': '' },
	\ { 'kind': 'v', 'word': 'gl_out',                   'abbr': 'gl_out',                   'info': '' },
	\ { 'kind': 'v', 'word': 'gl_PatchVerticesIn',       'abbr': 'gl_PatchVerticesIn',       'info': 'Tessallation Control & Evaluation Shader Inputs: The number vertices in the input patch.' },
	\ { 'kind': 'v', 'word': 'gl_PerVertex',             'abbr': 'gl_PerVertex',             'info': "An interface block for vertex shader outputs. Unnamed output from the vertex shader. Named IO for the tessalation control shader. Unnamed IO for the tessalation evaluation shader.\nTessalation Control Shader Input: A named interface block of data from the vertex shader." },
	\ { 'kind': 'v', 'word': 'gl_PointCoord',            'abbr': 'gl_PointCoord',            'info': '' },
	\ { 'kind': 'v', 'word': 'gl_PrimitiveIDIn',         'abbr': 'gl_PrimitiveIDIn',         'info': '' },
	\ { 'kind': 'v', 'word': 'gl_SampleID',              'abbr': 'gl_SampleID',              'info': '' },
	\ { 'kind': 'v', 'word': 'gl_SampleMask',            'abbr': 'gl_SampleMask',            'info': '' },
	\ { 'kind': 'v', 'word': 'gl_SampleMaskIn',          'abbr': 'gl_SampleMaskIn',          'info': '' },
	\ { 'kind': 'v', 'word': 'gl_SamplePosition',        'abbr': 'gl_SamplePosition',        'info': '' },
	\ { 'kind': 'v', 'word': 'gl_TessCoord',             'abbr': 'gl_TessCoord',             'info': '' },
	\ { 'kind': 'v', 'word': 'gl_TessLevelInner',        'abbr': 'gl_TessLevelInner',        'info': '' },
	\ { 'kind': 'v', 'word': 'gl_TessLevelOuter',        'abbr': 'gl_TessLevelOuter',        'info': '' },
	\ { 'kind': 'v', 'word': 'gl_ViewportIndex',         'abbr': 'gl_ViewportIndex',         'info': '' },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupID',           'abbr': 'gl_WorkGroupID',           'info': '' },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupSize',         'abbr': 'gl_WorkGroupSize',         'info': '' }
	\ ]
	"\ { 'kind': 'v', 'word': 'gl_PerVertex',             'abbr': 'gl_PerVertex',             'info': 'Vertex Shader Output: Unnamed interface block for vertex shader outputs.\nTessalation Control Shader Input: A named interface block of data from the vertex shader.' },
	"\ { 'kind': 'v', 'word': 'gl_PointSize',             'abbr': 'gl_PointSize',             'info': 'Vertex Shader Output: The pixel width and height of the point being rasterized.' },
	"\ { 'kind': 'v', 'word': 'gl_Position',              'abbr': 'gl_Position',              'info': 'Vertex Shader Output: The clipping space output position of the vertex.' },
	"\ { 'kind': 'v', 'word': 'gl_PrimitiveID',           'abbr': 'gl_PrimitiveID',           'info': 'Tessallation Control Shader Input: The index of the current patch.' },
	"\ { 'kind': 'v', 'word': 'gl_VertexID',              'abbr': 'gl_VertexID',              'info': 'The index of the vertex currently being processed.' },
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

