" Vim completion script
" Language:		OpenGL Shading Language (GLSL)
" Maintainer:	Brendan Robeson (https://github.com/brobeson/glslVim)
" Last Change:	2015 August 8

let s:cpo_save = &cpo
set cpo&vim

" GLSL built ins {{{
" start with the macros (kind = d)
let s:glsl_builtins = [
	\ { 'kind': 'd', 'word': '__FILE__',                 'abbr': '__FILE__',                 'info': "\/\/ Integer representing the current source string" },
	\ { 'kind': 'd', 'word': '__LINE__',                 'abbr': '__LINE__',                 'info': "\/\/ The line number where the macro is used" },
	\ { 'kind': 'd', 'word': '__VERSION__',              'abbr': '__VERSION__',              'info': "\/\/ Integer representing the GLSL version used" },
	\ { 'kind': 'v', 'word': 'gl_ClipDistance',          'abbr': 'gl_ClipDistance',          'info': "\/\/ tessallation control, tessallation evaulation, geometry:\n" .
																									\"\/\/     the distance from the vertex to each clipping half-space\n" .
																									\"\/\/ fragment: the interpolated clipping plane half-spaces\n" .
																									\"in float gl_ClipDistance[];\n\n" .
																									\"\/\/ vertex, tessallation control, tessallation evaluation, geometry:\n" .
																									\"\/\/     the distance from the vertex to each clipping half-space\n" .
																									\"out float gl_ClipDistance[];" },
	\ { 'kind': 'd', 'word': 'GL_compatibility_profile', 'abbr': 'GL_compatibility_profile', 'info': "\/\/ Defined as 1 if the shader profile was set to \"compatibility\"" },
	\ { 'kind': 'd', 'word': 'GL_core_profile',          'abbr': 'GL_core_profile',          'info': "\/\/ Defined as 1 if the shader profile was set to \"core\"" },
	\ { 'kind': 'v', 'word': 'gl_CullDistance',          'abbr': 'gl_CullDistance',          'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
																									\"\/\/     no documentation available\n" .
																									\"out float gl_CullDistance[];\n\n" .
																									\"\/\/ tessallation control & evaluation, geometry, fragment:\n" .
																									\"\/\/     no documentation available\n" .
																									\"in float gl_CullDistance[];" },
	\ { 'kind': 'd', 'word': 'GL_es_profile',            'abbr': 'GL_es_profile',            'info': "\/\/ Defined as 1 if the shader profile was set \"es\"" },
	\ { 'kind': 'v', 'word': 'gl_FragCoord',             'abbr': 'gl_FragCoord',             'info': "\/\/ fragment: the fragment's location in window space\n" .
																									\"in vec4 gl_FragCoord;" },
	\ { 'kind': 'v', 'word': 'gl_FragDepth',             'abbr': 'gl_FragDepth',             'info': "\/\/ fragment: The depth of the fragment\n" .
																									\"out float gl_FragDepth;" },
	\ { 'kind': 'v', 'word': 'gl_FrontFacing',           'abbr': 'gl_FrontFacing',           'info': "\/\/ fragment: true if the fragment is front facing, false if it is\n" .
																									\"\/\/           back facing\n" .
																									\"in bool gl_FrontFacing;" },
	\ { 'kind': 'v', 'word': 'gl_GlobalInvocationID',    'abbr': 'gl_GlobalInvocationID',    'info': "\/\/ compute input: the unique ID for an invocation of a compute\n" .
																									\"\/\/                shader, with a work group\n" .
																									\"in uvec3 gl_GlobalInvocationID;" },
	\ { 'kind': 'v', 'word': 'gl_HelperInvocation',      'abbr': 'gl_HelperInvocation',      'info': "\/\/ fragment: no documentation available\n" .
																									\"in bool gl_HelperInvocation;" },
	\ { 'kind': 'v', 'word': 'gl_in',                    'abbr': 'gl_in',                    'info': "\/\/ tessallation control, tessallation evaluation, geometry:\n" .
																									\"\/\/     the instance of gl_PerVertex\n" .
																									\"in gl_PerVertex { /*...*/ } gl_in[];" },
	\ { 'kind': 'v', 'word': 'gl_InstanceID',            'abbr': 'gl_InstanceID',            'info': "\/\/ vertex: the index of the current instance when using instanced\n" .
																									\"\/\/         rendering, 0 otherwise\n" .
																									\"in int gl_InstanceID;" },
	\ { 'kind': 'v', 'word': 'gl_InvocationID',          'abbr': 'gl_InvocationID',          'info': "\/\/ tessallation control: the index of the TCS invocation in this patch\n" .
																									\"\/\/ geometry input: the current instance\n" .
																									\"in int gl_InvocationID;\n" },
	\ { 'kind': 'v', 'word': 'gl_Layer',                 'abbr': 'gl_Layer',                 'info': "\/\/ geometry: the layer to which a primitive goes\n" . 
																									\"out int gl_Layer;\n\n" .
																									\"\/\/ fragment: the layer for the fragment, output by the geometry shader\n" .
																									\"in int gl_Layer;" },
	\ { 'kind': 'v', 'word': 'gl_LocalGroupSize',        'abbr': 'gl_LocalGroupSize',        'info': "\/\/ compute: no documentation available\n" .
																									\"in uvec3 gl_LocalGroupSize;" },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationID',     'abbr': 'gl_LocalInvocationID',     'info': "\/\/ compute: the current invocation of the shader within the work group\n" .
																									\"in uvec3 gl_LocalInvocationID;" },
	\ { 'kind': 'v', 'word': 'gl_LocalInvocationIndex',  'abbr': 'gl_LocalInvocationIndex',  'info': "\/\/ compute: the (1-D) index of the shader invocation within the work group\n" .
																									\"in uint gl_LocalInvocationIndex;" },
	\ { 'kind': 'v', 'word': 'gl_NumWorkGroups',         'abbr': 'gl_NumWorkGroups',         'info': "\/\/ compute: the number of work groups used when dispatching the compute shader\n" .
																									\"in uvec3 gl_NumWorkGroups;" },
	\ { 'kind': 'v', 'word': 'gl_out',                   'abbr': 'gl_out',                   'info': "\/\/ tessalation control: the instance of gl_PerVertex for output\n" .
																									\"out gl_PerVertex { /*...*/ } gl_out[];" },
	\ { 'kind': 'v', 'word': 'gl_PatchVerticesIn',       'abbr': 'gl_PatchVerticesIn',       'info': "\/\/ tessallation control & evaluation: the number of vertices in the\n" .
																									\"\/\/                                    input patch\n" .
																									\"in int gl_PatchVerticesIn;" },
	\ { 'kind': 'v', 'word': 'gl_PerVertex',             'abbr': 'gl_PerVertex',             'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
																									\"\/\/     an unnamed interface block for per vertex output\n" .
																									\"out gl_PerVertex { /*...*/ };\n\n" .
																									\"\/\/ tessallation control & evaluation, geometry:\n" .
																									\"\/\/     an unnamed interface block for per vertex input\n" .
																									\"in gl_PerVertex { /*...*/ };" },
	\ { 'kind': 'v', 'word': 'gl_PointCoord',            'abbr': 'gl_PointCoord',            'info': "\/\/ fragment: the location of a fragment within a point primitive\n" .
																									\"in vec2 gl_PointCoord;" },
	\ { 'kind': 'v', 'word': 'gl_PointSize',             'abbr': 'gl_PointSize',             'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
																									\"\/\/    the pixel width and height of the point being rasterized\n" .
																									\"out float gl_PointSize;\n\n" .
																									\"\/\/ tessallation control & evaluation, geometry:\n" .
																									\"\/\/    the pixel width and height of the point being rasterized\n" .
																									\"in float gl_PointSize;" },
	\ { 'kind': 'v', 'word': 'gl_Position',              'abbr': 'gl_Position',              'info': "\/\/ vertex, tessallation control & evaluation, geometry:\n" .
																									\"\/\/    the clipping space output position of the vertex\n" .
																									\"out vec4 gl_Position;\n\n" .
																									\"\/\/ tessallation control & evaluation, geometry:\n" .
																									\"\/\/    the clipping space input position of the vertex\n" .
																									\"int vec4 gl_Position;" },
	\ { 'kind': 'v', 'word': 'gl_PrimitiveID',           'abbr': 'gl_PrimitiveID',           'info': "\/\/ tessallation control: the index of the current patch\n" .
																									\"\/\/ fragment: the index of the current primitive\n" .
																									\"in int gl_PrimitiveID;\n\n" .
																									\"\/\/ geometry output: the primitive ID to send to the fragement shader\n" .
																									\"out int gl_PrimitiveID;" },
	\ { 'kind': 'v', 'word': 'gl_PrimitiveIDIn',         'abbr': 'gl_PrimitiveIDIn',         'info': "\/\/ geometry: the ID of the current input primitive\n" .
																									\"in int gl_PrimitiveIDIn;" },
	\ { 'kind': 'v', 'word': 'gl_SampleID',              'abbr': 'gl_SampleID',              'info': "\/\/ fragment: the ID of the current sample within a fragment\n" .
																									\"in int gl_SampleID;" },
	\ { 'kind': 'v', 'word': 'gl_SampleMask',            'abbr': 'gl_SampleMask',            'info': "\/\/ fragment: the sample mask for the fragment, when using\n" .
																									\"\/\/           multisampled rendering\n" .
																									\"out int gl_SampleMask[];" },
	\ { 'kind': 'v', 'word': 'gl_SampleMaskIn',          'abbr': 'gl_SampleMaskIn',          'info': "\/\/ fragment: bitfield for the sample mask of the current fragment\n" .
																									\"in int gl_SampleMaskIn[];" },
	\ { 'kind': 'v', 'word': 'gl_SamplePosition',        'abbr': 'gl_SamplePosition',        'info': "\/\/ fragment: the location of the current sample within the current fragment\n" .
																									\"in vec2 gl_SamplePosition;" },
	\ { 'kind': 'v', 'word': 'gl_TessCoord',             'abbr': 'gl_TessCoord',             'info': "\/\/ tessallation evaluation: the location of a vertex within the\n" .
																									\"\/\/                          tessallated abstract patch\n" .
																									\"in vec3 gl_TessCoord;" },
	\ { 'kind': 'v', 'word': 'gl_TessLevelInner',        'abbr': 'gl_TessLevelInner',        'info': "\/\/ tessallation control: the inner tessallation level\n" .
																									\"patch out float gl_TessLevelInner[2];\n\n" .
																									\"\/\/ tessallation evaluation: the inner tessallation level from the\n" .
																									\"\/\/                          tessallation control shader\n" .
																									\"patch in float gl_TessLevelInner[2];" },
	\ { 'kind': 'v', 'word': 'gl_TessLevelOuter',        'abbr': 'gl_TessLevelOuter',        'info': "\/\/ tessallation control: the outer tessallation level\n" .
																									\"patch out float gl_TessLevelOuter[4];\n\n" .
																									\"\/\/ tessallation evaluation: the outer tessallation level from the\n" .
																									\"\/\/                          tessallation control shader\n" .
																									\"patch in float gl_TessLevelOuter[4];" },
	\ { 'kind': 'v', 'word': 'gl_VertexID',              'abbr': 'gl_VertexID',              'info': "\/\/ vertex: the index of the vertex currently being processed\n" .
																									\"in int gl_VertexID;" },
	\ { 'kind': 'v', 'word': 'gl_ViewportIndex',         'abbr': 'gl_ViewportIndex',         'info': "\/\/ geometry: specifies which viewport to use for the primitive\n" .
																									\"out int gl_ViewportIndex;\n\n" .
																									\"\/\/ fragment: 0, or the viewport index for the primitive from the\n" .
																									\"\/\/           geometry shader\n" .
																									\"in  int gl_ViewportIndex;" },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupID',           'abbr': 'gl_WorkGroupID',           'info': "\/\/ compute: the current work group for the shader invocation\n" .
																									\"in uvec3 gl_WorkGroupID;" },
	\ { 'kind': 'v', 'word': 'gl_WorkGroupSize',         'abbr': 'gl_WorkGroupSize',         'info': "\/\/ compute: the size of the local work group\n" .
																									\"const uvec3 gl_WorkGroupSize;" }
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

"au! CursorHold *.[ch] nested call PreviewWord()
function! glslcomplete#preview_highlight()
"  if &previewwindow			" don't do this in the preview window
"    return
"  endif
"  let w = expand("<cword>")		" get the word under cursor
"  if w =~ '\a'			" if the word contains a letter
"
    " Delete any existing highlight before showing another tag
    "silent! wincmd P			" jump to preview window
	wincmd P
    if &previewwindow			" if we really get there...
		set filetype=glsl
"      match none			" delete existing highlight
      wincmd p			" back to old window
    endif
"
"    " Try displaying a matching tag for the word under the cursor
"    try
"       exe "ptag " . w
"    catch
"      return
"    endtry
"
"    silent! wincmd P			" jump to preview window
"    if &previewwindow		" if we really get there...
"	 if has("folding")
"	   silent! .foldopen		" don't want a closed fold
"	 endif
"	 call search("$", "b")		" to end of previous line
"	 let w = substitute(w, '\\', '\\\\', "")
"	 call search('\<\V' . w . '\>')	" position cursor on match
"	 " Add a match highlight to the word at this position
"      hi previewWord term=bold ctermbg=green guibg=green
"	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
"      wincmd p			" back to old window
"    endif
"  endif
endfunction


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

	return matches
endfunc

let &cpo = s:cpo_save
unlet s:cpo_save

