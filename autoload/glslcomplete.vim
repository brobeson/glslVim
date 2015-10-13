" Vim completion script
" Language:		OpenGL Shading Language (GLSL)
" Maintainer:	Brendan Robeson (https://github.com/brobeson/glslVim)
" Last Change:	2015 August 8

let s:cpo_save = &cpo
set cpo&vim

" GLSL built ins {{{
" start with the macros (kind = d)
let s:glsl_builtins = [
	\ { 'kind': 'd',	'word': '__FILE__',
	\					'abbr': '__FILE__',
	\					'info': "\/\/ This is an integer representing the current source string.\n\n" },
	\ { 'kind': 'd',	'word': '__LINE__',
	\					'abbr': '__LINE__',
	\					'info': "\/\/ This represents the line number where the macro is used.\n\n" },
	\ { 'kind': 'd',	'word': '__VERSION__',
	\					'abbr': '__VERSION__',
	\					'info': "\/\/ This represents the GLSL version being used.\n\n" },
	\ { 'kind': 'v',	'word': 'gl_ClipDistance',
	\					'abbr': 'gl_ClipDistance',
	\					'info': "\/\/ Tessallation control, Tessallation evaulation, & Geometry shaders:\n" .
	\							"\/\/     These are the distances from the vertex to each clipping half-space.\n" .
	\							"\/\/ Fragment shader:\n".
	\							"\/\/     These are the interpolated clipping plane half-spaces.\n" .
	\							"in float gl_ClipDistance[];\n\n" .
	\							"\/\/ Vertex, Tessallation control & evaluation, & Geometry shaders:\n" .
	\							"\/\/     These are the distances from the vertex to each clipping half-space.\n" .
	\							"out float gl_ClipDistance[];\n\n" },
	\ { 'kind': 'd',	'word': 'GL_compatibility_profile',
	\					'abbr': 'GL_compatibility_profile',
	\					'info': "\/\/ This is defined as 1 if the shader profile was set to \"compatibility\".\n\n" },
	\ { 'kind': 'd',	'word': 'GL_core_profile',
	\					'abbr': 'GL_core_profile',
	\					'info': "\/\/ This is defined as 1 if the shader profile was set to \"core\".\n\n" },
	\ { 'kind': 'v',	'word': 'gl_CullDistance',
	\					'abbr': 'gl_CullDistance',
	\					'info': "\/\/ Vertex, Tessallation control & evaluation, & Geometry shaders:\n" .
	\							"\/\/     No documentation is available.\n" .
	\							"out float gl_CullDistance[];\n\n" .
	\							"\/\/ Tessallation control & evaluation, Geometry, & Fragment shaders:\n" .
	\							"\/\/     No documentation is available.\n" .
	\							"in float gl_CullDistance[];\n\n" },
	\ { 'kind': 'd',	'word': 'GL_es_profile',
	\					'abbr': 'GL_es_profile',
	\					'info': "\/\/ This is defined as 1 if the shader profile was set \"es\".\n\n" },
	\ { 'kind': 'v',	'word': 'gl_FragCoord',
	\					'abbr': 'gl_FragCoord',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the fragment's location in window space.\n" .
	\							"in vec4 gl_FragCoord;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_FragDepth',
	\					'abbr': 'gl_FragDepth',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the depth of the fragment.\n" .
	\							"out float gl_FragDepth;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_FrontFacing',
	\					'abbr': 'gl_FrontFacing',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     True if the fragment is front-facing, false if it is back-facing.\n" .
	\							"in bool gl_FrontFacing;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_GlobalInvocationID',
	\					'abbr': 'gl_GlobalInvocationID',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     This is the unique ID for this invocation of a compute shader among all\n" .
	\							"\/\/     the invocations for this dispatch. It is equivilant to\n".
	\							"\/\/     gl_GlobelInvocationID = gl_WorkGroupID * gl_WorkGroupSize +\n".
	\							"\/\/                             gl_LocalInvocationID;\n".
	\							"in uvec3 gl_GlobalInvocationID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_HelperInvocation',
	\					'abbr': 'gl_HelperInvocation',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     no documentation available\n" .
	\							"in bool gl_HelperInvocation;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_in',
	\					'abbr': 'gl_in',
	\					'info': "\/\/ Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/     This is input the instance of gl_PerVertex.\n" .
	\							"in gl_PerVertex { /*...*/ } gl_in[];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_InstanceID',
	\					'abbr': 'gl_InstanceID',
	\					'info': "\/\/ Vertex shader:\n".
	\							"\/\/     This is the index of the current instance when using instanced\n" .
	\							"\/\/     rendering, 0 otherwise.\n" .
	\							"in int gl_InstanceID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_InvocationID',
	\					'abbr': 'gl_InvocationID',
	\					'info': "\/\/ Tessallation control shader:\n".
	\							"\/\/     This is the index of the TCS invocation in the current patch.\n" .
	\							"\/\/ Geometry shader:\n".
	\							"\/\/     This is the current instance.\n" .
	\							"in int gl_InvocationID;\n" },
	\ { 'kind': 'v',	'word': 'gl_Layer',
	\					'abbr': 'gl_Layer',
	\					'info': "\/\/ Geometry shader:\n".
	\							"\/\/     This specifies the layer to which a primitive belongs.\n" . 
	\							"out int gl_Layer;\n\n" .
	\							"\/\/ Fragment shader:\n".
	\							"\/\/     This is the fragment's layer, output by the geometry shader.\n" .
	\							"in int gl_Layer;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_LocalGroupSize',
	\					'abbr': 'gl_LocalGroupSize',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     No documentation is available.\n" .
	\							"in uvec3 gl_LocalGroupSize;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_LocalInvocationID',
	\					'abbr': 'gl_LocalInvocationID',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     This is the current invocation of the shader within the work group.\n" .
	\							"in uvec3 gl_LocalInvocationID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_LocalInvocationIndex',
	\					'abbr': 'gl_LocalInvocationIndex',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     This is the 1-D index of the shader invocation within the work group.\n" .
	\							"\/\/     gl_LocalInvocationIndex =\n".
	\							"\/\/         gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y +\n".
	\							"\/\/         gl_LocalInvocationID.y * gl_WorkGroupSize.x +\n".
	\							"\/\/         gl_LocalInvocationID.x;\n".
	\							"in uint gl_LocalInvocationIndex;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_NumWorkGroups',
	\					'abbr': 'gl_NumWorkGroups',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     This is the number of work groups used when dispatching the compute\n".
	\							"\/\/     shader.\n" .
	\							"in uvec3 gl_NumWorkGroups;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_out',
	\					'abbr': 'gl_out',
	\					'info': "\/\/ Tessallation control shader:\n".
	\							"\/\/     These are the instances of gl_PerVertex for output.\n" .
	\							"out gl_PerVertex { /*...*/ } gl_out[];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PatchVerticesIn',
	\					'abbr': 'gl_PatchVerticesIn',
	\					'info': "\/\/ Tessallation control & evaluation shader:\n".
	\							"\/\/     This is the number of vertices in the input patch.\n" .
	\							"in int gl_PatchVerticesIn;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PerVertex',
	\					'abbr': 'gl_PerVertex',
	\					'info': "\/\/ Vertex, Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/     This is an unnamed interface block for per vertex output.\n" .
	\							"out gl_PerVertex { /*...*/ };\n\n" .
	\							"\/\/ Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/     This is an unnamed interface block for per vertex input.\n" .
	\							"in gl_PerVertex { /*...*/ };\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PointCoord',
	\					'abbr': 'gl_PointCoord',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the location of a fragment within a point primitive.\n" .
	\							"in vec2 gl_PointCoord;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PointSize',
	\					'abbr': 'gl_PointSize',
	\					'info': "\/\/ Vertex, Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/    This is the pixel width and height of the point being rasterized.\n" .
	\							"out float gl_PointSize;\n\n" .
	\							"\/\/ Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/    This is the pixel width and height of the point being rasterized.\n" .
	\							"in float gl_PointSize;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_Position',
	\					'abbr': 'gl_Position',
	\					'info': "\/\/ Vertex, Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/    This gives the clipping space output position of the vertex.\n" .
	\							"out vec4 gl_Position;\n\n" .
	\							"\/\/ Tessallation control & evaluation, Geometry shader:\n" .
	\							"\/\/    This gives the clipping space input position of the vertex.\n" .
	\							"int vec4 gl_Position;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PrimitiveID',
	\					'abbr': 'gl_PrimitiveID',
	\					'info': "\/\/ Tessallation control shader:\n".
	\							"\/\/     This is the index of the current patch.\n" .
	\							"\/\/ Fragment shader:\n".
	\							"\/\/     This is the index of the current primitive.\n" .
	\							"in int gl_PrimitiveID;\n\n" .
	\							"\/\/ Geometry shader:\n".
	\							"\/\/     This is the primitive ID to send to the fragement shader.\n" .
	\							"out int gl_PrimitiveID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_PrimitiveIDIn',
	\					'abbr': 'gl_PrimitiveIDIn',
	\					'info': "\/\/ Geometry shader:\n".
	\							"\/\/     This is the ID of the current input primitive.\n" .
	\							"in int gl_PrimitiveIDIn;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_SampleID',
	\					'abbr': 'gl_SampleID',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the ID of the current sample within a fragment.\n" .
	\							"in int gl_SampleID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_SampleMask',
	\					'abbr': 'gl_SampleMask',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the sample mask for the fragment, when using multisampled\n".
	\							"\/\/     rendering.\n" .
	\							"out int gl_SampleMask[];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_SampleMaskIn',
	\					'abbr': 'gl_SampleMaskIn',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     These are the bitfield for the sample mask of the current fragment.\n" .
	\							"in int gl_SampleMaskIn[];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_SamplePosition',
	\					'abbr': 'gl_SamplePosition',
	\					'info': "\/\/ Fragment shader:\n".
	\							"\/\/     This is the location of the current sample within the current fragment.\n" .
	\							"in vec2 gl_SamplePosition;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_TessCoord',
	\					'abbr': 'gl_TessCoord',
	\					'info': "\/\/ Tessallation evaluation shader:\n".
	\							"\/\/     This is the location of a vertex within the tessallated abstract patch.\n" .
	\							"in vec3 gl_TessCoord;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_TessLevelInner',
	\					'abbr': 'gl_TessLevelInner',
	\					'info': "\/\/ Tessallation control shader:\n".
	\							"\/\/     This is the inner tessallation level.\n" .
	\							"patch out float gl_TessLevelInner[2];\n\n" .
	\							"\/\/ Tessallation evaluation shader:\n".
	\							"\/\/     This is the inner tessallation level from the tessallation control\n".
	\							"\/\/     shader.\n" .
	\							"patch in float gl_TessLevelInner[2];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_TessLevelOuter',
	\					'abbr': 'gl_TessLevelOuter',
	\					'info': "\/\/ Tessallation control shader:\n".
	\							"\/\/     These are the outer tessallation level.\n" .
	\							"patch out float gl_TessLevelOuter[4];\n\n" .
	\							"\/\/ Tessallation evaluation shader:\n".
	\							"\/\/     These are the outer tessallation levels from the tessallation control\n".
	\							"\/\/     shader.\n" .
	\							"patch in float gl_TessLevelOuter[4];\n\n" },
	\ { 'kind': 'v',	'word': 'gl_VertexID',
	\					'abbr': 'gl_VertexID',
	\					'info': "\/\/ Vertex shader:\n".
	\							"\/\/     This is the index of the vertex currently being processed.\n" .
	\							"in int gl_VertexID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_ViewportIndex',
	\					'abbr': 'gl_ViewportIndex',
	\					'info': "\/\/ Geometry shader:\n".
	\							"\/\/     This specifies which viewport to use for the primitive.\n" .
	\							"out int gl_ViewportIndex;\n\n" .
	\							"\/\/ Fragment shader:\n".
	\							"\/\/     This is either 0, or the viewport index for the primitive from the\n" .
	\							"\/\/     geometry shader.\n" .
	\							"in int gl_ViewportIndex;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_WorkGroupID',
	\					'abbr': 'gl_WorkGroupID',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/    This is the current work group for the shader invocation.\n" .
	\							"\/\/    It is on the range [0, gl_NumWorkGroups.xyz].\n".
	\							"in uvec3 gl_WorkGroupID;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_WorkGroupSize',
	\					'abbr': 'gl_WorkGroupSize',
	\					'info': "\/\/ Compute shader:\n".
	\							"\/\/     This is the size of the local work group.\n" .
	\							"const uvec3 gl_WorkGroupSize;\n\n" }
	\ ]
" }}}

" GLSL built in constants {{{
	\ { 'kind': 'v',	'word': 'gl_MaxAtomicCounterBindings',
	\					'abbr': 'gl_MaxAtomicCounterBindings',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\							"const int gl_MaxAtomicCounterBindings = 1;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxAtomicCounterBufferSize',
	\					'abbr': 'gl_MaxAtomicCounterBufferSize',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\							"const int gl_MaxAtomicCounterBufferSize = 32;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxClipDistances',
	\					'abbr': 'gl_MaxClipDistances',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxClipDistances = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedAtomicCounterBuffers',
	\					'abbr': 'gl_MaxCombinedAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedAtomicCounterBuffers = 1;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedAtomicCounters',
	\					'abbr': 'gl_MaxCombinedAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedAtomicCounters = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedClipAndCullDistances',
	\					'abbr': 'gl_MaxCombinedClipAndCullDistances',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedClipAndCullDistances = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedImageUnitsAndFragmentOutputs',
	\					'abbr': 'gl_MaxCombinedImageUnitsAndFragmentOutputs',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedImageUnitsAndFragmentOutputs = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedImageUniforms',
	\					'abbr': 'gl_MaxCombinedImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedImageUniforms = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedShaderOutputResources',
	\					'abbr': 'gl_MaxCombinedShaderOutputResources',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedShaderOutputResources = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCombinedTextureImageUnits',
	\					'abbr': 'gl_MaxCombinedTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCombinedTextureImageUnits = 80;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeAtomicCounterBuffers',
	\					'abbr': 'gl_MaxComputeAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxComputeAtomicCounterBuffers = 1;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeAtomicCounters',
	\					'abbr': 'gl_MaxComputeAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxComputeAtomicCounters = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeImageUniforms',
	\					'abbr': 'gl_MaxComputeImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxComputeImageUniforms = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeTextureImageUnits',
	\					'abbr': 'gl_MaxComputeTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxComputeTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeUniformComponents',
	\					'abbr': 'gl_MaxComputeUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxComputeUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeWorkGroupCount',
	\					'abbr': 'gl_MaxComputeWorkGroupCount',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const ivec3 gl_MaxComputeWorkGroupCount = {65535, 65535, 65535};\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxComputeWorkGroupSize',
	\					'abbr': 'gl_MaxComputeWorkGroupSize',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const iv3c3 gl_MaxComputeWorkGroupSize[] = {1024, 1024, 64};\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxCullDistances',
	\					'abbr': 'gl_MaxCullDistances',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxCullDistances = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxProgramTexelOffset',
	\					'abbr': 'gl_MaxProgramTexelOffset',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxProgramTexelOffset = 7;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxDrawBuffers',
	\					'abbr': 'gl_MaxDrawBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxDrawBuffers = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentAtomicCounterBuffers',
	\					'abbr': 'gl_MaxFragmentAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentAtomicCounterBuffers = 1;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentAtomicCounters',
	\					'abbr': 'gl_MaxFragmentAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentAtomicCounters = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentImageUniforms',
	\					'abbr': 'gl_MaxFragmentImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentImageUniforms = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentInputComponents',
	\					'abbr': 'gl_MaxFragmentInputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentInputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentUniformComponents',
	\					'abbr': 'gl_MaxFragmentUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxFragmentUniformVectors',
	\					'abbr': 'gl_MaxFragmentUniformVectors',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxFragmentUniformVectors = 256;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryAtomicCounterBuffers',
	\					'abbr': 'gl_MaxGeometryAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryAtomicCounterBuffers = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryAtomicCounters',
	\					'abbr': 'gl_MaxGeometryAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryAtomicCounters = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryImageUniforms',
	\					'abbr': 'gl_MaxGeometryImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryImageUniforms = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryInputComponents',
	\					'abbr': 'gl_MaxGeometryInputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryInputComponents = 64;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryOutputComponents',
	\					'abbr': 'gl_MaxGeometryOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryOutputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryOutputVertices',
	\					'abbr': 'gl_MaxGeometryOutputVertices',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryOutputVertices = 256;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryTextureImageUnits',
	\					'abbr': 'gl_MaxGeometryTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryTotalOutputComponents',
	\					'abbr': 'gl_MaxGeometryTotalOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryTotalOutputComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryUniformComponents',
	\					'abbr': 'gl_MaxGeometryUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxGeometryVaryingComponents',
	\					'abbr': 'gl_MaxGeometryVaryingComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxGeometryVaryingComponents = 64;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxImageSamples',
	\					'abbr': 'gl_MaxImageSamples',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxImageSamples = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxImageUnits',
	\					'abbr': 'gl_MaxImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxImageUnits = 8;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxPatchVertices',
	\					'abbr': 'gl_MaxPatchVertices',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxPatchVertices = 32;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxSamples',
	\					'abbr': 'gl_MaxSamples',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxSamples = 4;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlAtomicCounterBuffers',
	\					'abbr': 'gl_MaxTessControlAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlAtomicCounterBuffers = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlAtomicCounters',
	\					'abbr': 'gl_MaxTessControlAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlAtomicCounters = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlImageUniforms',
	\					'abbr': 'gl_MaxTessControlImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlImageUniforms = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlInputComponents',
	\					'abbr': 'gl_MaxTessControlInputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlInputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlOutputComponents',
	\					'abbr': 'gl_MaxTessControlOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlOutputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlTextureImageUnits',
	\					'abbr': 'gl_MaxTessControlTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlTotalOutputComponents',
	\					'abbr': 'gl_MaxTessControlTotalOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlTotalOutputComponents = 4096;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessControlUniformComponents',
	\					'abbr': 'gl_MaxTessControlUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessControlUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationAtomicCounterBuffers',
	\					'abbr': 'gl_MaxTessEvaluationAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationAtomicCounterBuffers = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationAtomicCounters',
	\					'abbr': 'gl_MaxTessEvaluationAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationAtomicCounters = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationImageUniforms',
	\					'abbr': 'gl_MaxTessEvaluationImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationImageUniforms = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationInputComponents',
	\					'abbr': 'gl_MaxTessEvaluationInputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationInputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationOutputComponents',
	\					'abbr': 'gl_MaxTessEvaluationOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationOutputComponents = 128;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationTextureImageUnits',
	\					'abbr': 'gl_MaxTessEvaluationTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessEvaluationUniformComponents',
	\					'abbr': 'gl_MaxTessEvaluationUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessEvaluationUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessGenLevel',
	\					'abbr': 'gl_MaxTessGenLevel',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessGenLevel = 64;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTessPatchComponents',
	\					'abbr': 'gl_MaxTessPatchComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTessPatchComponents = 120;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTextureImageUnits',
	\					'abbr': 'gl_MaxTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTransformFeedbackBuffers',
	\					'abbr': 'gl_MaxTransformFeedbackBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTransformFeedbackBuffers = 4;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxTransformFeedbackInterleavedComponents',
	\					'abbr': 'gl_MaxTransformFeedbackInterleavedComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxTransformFeedbackInterleavedComponents = 64;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVaryingComponents',
	\					'abbr': 'gl_MaxVaryingComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVaryingComponents = 60;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVaryingVectors',
	\					'abbr': 'gl_MaxVaryingVectors',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVaryingVectors = 15;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexAtomicCounterBuffers',
	\					'abbr': 'gl_MaxVertexAtomicCounterBuffers',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexAtomicCounterBuffers = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexAtomicCounters',
	\					'abbr': 'gl_MaxVertexAtomicCounters',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexAtomicCounters = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexAttribs',
	\					'abbr': 'gl_MaxVertexAttribs',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexAttribs = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexImageUniforms',
	\					'abbr': 'gl_MaxVertexImageUniforms',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexImageUniforms = 0;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexOutputComponents',
	\					'abbr': 'gl_MaxVertexOutputComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexOutputComponents = 64;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexTextureImageUnits',
	\					'abbr': 'gl_MaxVertexTextureImageUnits',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexTextureImageUnits = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexUniformComponents',
	\					'abbr': 'gl_MaxVertexUniformComponents',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexUniformComponents = 1024;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxVertexUniformVectors',
	\					'abbr': 'gl_MaxVertexUniformVectors',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxVertexUniformVectors = 256;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MaxViewports',
	\					'abbr': 'gl_MaxViewports',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MaxViewports = 16;\n\n" },
	\ { 'kind': 'v',	'word': 'gl_MinProgramTexelOffset',
	\					'abbr': 'gl_MinProgramTexelOffset',
	\					'info': "\/\/ All built in constants must be at least the value shown.\n" .
	\					"const int gl_MinProgramTexelOffset = -8;\n\n" },
"}}}

" GLSL built in functions {{{
	\ { 'kind': 'f',	'word': 'abs(',
	\					'abbr': 'abs',
	\					'info': "\/\/ Calculate the absolute value of x.\n" .
	\							"\/\/ param[in] x: The value for which to caclulaate the absolute value.\n".
	\					'info': "\/\/ returns   The absolute value of x.\n" .
	\							"genType abs(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'acos(',
	\					'abbr': 'acos',
	\					'info': "\/\/ Calculate the arccosine of x. The result is undefined if abs(x) > 1.\n" .
	\							"\/\/ param[in] x: The value for which to calculate the arccosine. x should be on\n".
	\							"\/\/              the range [-1, 1].\n" .
	\							"\/\/ returns   The arccosine, in radians on [0, pi], of x.\n" .
	\							"genType acos(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'acosh(',
	\					'abbr': 'acosh',
	\					'info': "\/\/ Calculate the arc hyperbolic cosine of x. The result is undefined if x < 1.\n" .
	\							"\/\/ param[in] x: The value for which to calculate the arc hyperbolic cosine.\n".
	\							"\/\/              x should be >= 1.\n".
	\							"\/\/ returns   The arc hyperbolic cosine of x.\n".
	\							"genType acosh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'all(',
	\					'abbr': 'all',
	\					'info': "\/\/ Determine if all components of a boolean vector is true.\n" .
	\							"\/\/ param[in] x: The boolean vector to check for truth.\n".
	\							"\/\/ returns   x[0] && x[1] && ...\n".
	\							"bool all(bvec x);\n\n" },
	\ { 'kind': 'f',	'word': 'any(',
	\					'abbr': 'any',
	\					'info': "\/\/ Determine if any component of a boolean vector is true.\n" .
	\							"\/\/ param[in] x: The boolean vector to check for truth.\n".
	\							"\/\/ returns   x[0] || x[1] || ...\n".
	\							"bool any(bvec x);\n\n" },
	\ { 'kind': 'f',	'word': 'asin(',
	\					'abbr': 'asin',
	\					'info': "\/\/ Calculate the arcsine of x. The result is undefined if abs(x) > 1.\n" .
	\							"\/\/ param[in] x: The value for which to calculate the arcsine. x should be on\n".
	\							"\/\/              the range [-1, 1].\n".
	\							"\/\/ returns   The arcsine, in radians on [-pi/2, pi/2], of x.\n" .
	\							"genType asin(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'asinh(',
	\					'abbr': 'asinh',
	\					'info': "\/\/ Calculate the arc hyperbolic sine of x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the arc hyperbolic sine.\n".
	\							"\/\/ returns   The arc hyperbolic sine of x.\n" .
	\							"genType asinh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'atan(',
	\					'abbr': 'atan',
	\					'info': "\/\/ Calculate the arctangent of y / x. The result is undefined if x == 0. The\n".
	\							"\/\/ signs of y and x are used to determine the angle's quadrant.\n" .
	\							"\/\/ param[in] y: The numerator of the fraction.\n".
	\							"\/\/ param[in] x: The denominator of the fraction.\n".
	\							"\/\/ returns   The arctangent, in radians on [-pi, pi], of y / x.\n" .
	\							"genType atan(genType y, genType x);\n\n" .
	\							"\/\/ param[in] y_over_x: The fraction for which to calculate the arctangent.\n".
	\							"\/\/ returns   The arctangent, in radians on [-pi/2, pi/2], of y_over_x.\n" .
	\							"genType atan(genType y_over_x);\n\n" },
	\ { 'kind': 'f',	'word': 'atanh(',
	\					'abbr': 'atanh',
	\					'info': "\/\/ Calculate the arc hyperbolic tangent of x. The results is undefined if\n".
	\							"\/\/ abs(x) > 1.\n" .
	\							"\/\/ param[in] x: The value for which to calculate the arc hyperbolic tangent.\n".
	\							"\/\/              x should be on the range [-1, 1].\n".
	\							"\/\/ returns   The arc hyperbolic tangent of x.\n" .
	\							"genType atanh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicAdd(',
	\					'abbr': 'atomicAdd',
	\					'info': "\/\/ Atomically add to a buffer or shared variable. The operation is similar to\n".
	\							"\/\/ mem += data;\n" .
	\							"\/\/ param[in,out] mem:  The target variable for the atomic addition.\n" .
	\							"\/\/ param[in]     data: The data to be added to mem.\n" .
	\							"\/\/ returns       The value of mem prior to the addition.\n".
	\							"int  atomicAdd(inout int  mem, int  data);\n" .
	\							"uint atomicAdd(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicAnd(',
	\					'abbr': 'atomicAnd',
	\					'info': "\/\/ Atomically AND with a buffer or shared variable. The operation is similar\n".
	\							"\/\/ to mem = mem && data;\n" .
	\							"\/\/ param[in,out] mem:  The target variable for the atomic AND.\n" .
	\							"\/\/ param[in]     data: The data to be ANDed with mem.\n" .
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicAnd(inout int  mem, int  data);\n" .
	\							"uint atomicAnd(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicCompSwap(',
	\					'abbr': 'atomicCompSwap',
	\					'info': "\/\/ Atomically swap a buffer or shared variable based on a comparison. This is\n".
	\							"\/\/ basically mem = (mem == compare ? data : mem);\n" .
	\							"\/\/ param[in,out] mem:     The target variable of the operation.\n" .
	\							"\/\/ param[in]     compare: No documentation is available.\n" .
	\							"\/\/ param[in]     data:    The data to be compared to, and possibly exchanged\n".
	\							"\/\/                        with, mem.\n" .
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicCompSwap(inout int  mem, int  compare, int  data);\n" .
	\							"uint atomicCompSwap(inout uint mem, uint compare, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicCounter(',
	\					'abbr': 'atomicCounter',
	\					'info': "\/\/ Get the value of an atomic counter.\n".
	\							"\/\/ param[in] c: The handle of the atomic counter to retrieve.\n".
	\							"\/\/ returns   The current value of the specified atomic counter.\n".
	\							"uint atomicCounter(atomic_uint c);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicCounterDecrement(',
	\					'abbr': 'atomicCounterDecrement',
	\					'info': "\/\/ Decrement an atomic counter.\n" .
	\							"\/\/ param[in] c: The handle of the atomic counter to decrement.\n".
	\							"\/\/ returns   The initial value of the counter.\n" .
	\							"uint atomicCounterDecrement(atomic_uint c);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicCounterIncrement(',
	\					'abbr': 'atomicCounterIncrement',
	\					'info': "\/\/ Increment an atomic counter.\n" .
	\							"\/\/ param[in] c: The handle of the atomic counter to increment.\n".
	\							"\/\/ returns   The initial value of the counter.\n" .
	\							"uint atomicCounterIncrement(atomic_uint c);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicExchange(',
	\					'abbr': 'atomicExchange',
	\					'info': "\/\/ Atomically exchange one variable for another.\n" .
	\							"\/\/ param[in,out] mem:  The variable to be written to.\n".
	\							"\/\/ param[in]     data: The data to write.\n".
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicExchange(inout int  mem, int  data);\n" .
	\							"uint atomicExchange(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicMax(',
	\					'abbr': 'atomicMax',
	\					'info': "\/\/ Atomically determine the maximum of two values. This is similar to\n".
	\							"\/\/ mem = max(mem, data);\n" .
	\							"\/\/ param[in,out] mem:  The first data to compare, and the variable to which\n".
	\							"\/\/                     the maximum is written.\n".
	\							"\/\/ param[in]     data: The second data to compare.\n".
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicMax(inout int  mem, int  data);\n" .
	\							"uint atomicMax(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicMin(',
	\					'abbr': 'atomicMin',
	\					'info': "\/\/ Atomically determine the minimum of two values. This is similar to\n".
	\							"\/\/ mem = min(mem, data);\n" .
	\							"\/\/ param[in,out] mem:  The first data to compare, and the variable to which\n".
	\							"\/\/                     the minimum is written.\n".
	\							"\/\/ param[in]     data: The second data to compare.\n".
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicMin(inout int  mem, int  data);\n" .
	\							"uint atomicMin(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicOr(',
	\					'abbr': 'atomicOr',
	\					'info': "\/\/ Atomically OR with a buffer or shared variable. The operation is similar to\n".
	\							"\/\/ mem = mem || data;\n" .
	\							"\/\/ param[in,out] mem:  The target variable for the atomic OR.\n" .
	\							"\/\/ param[in]     data: The data to be ORed with mem.\n" .
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicOr(inout int  mem, int  data);\n" .
	\							"uint atomicOr(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'atomicXor(',
	\					'abbr': 'atomicXor',
	\					'info': "\/\/ Atomically exclusive OR with a buffer or shared variable.\n".
	\							"\/\/ param[in,out] mem:  The target variable for the atomic OR.\n" .
	\							"\/\/ param[in]     data: The data to be ORed with mem.\n" .
	\							"\/\/ returns       The initial value of mem.\n".
	\							"int  atomicXor(inout int  mem, int  data);\n" .
	\							"uint atomicXor(inout uint mem, uint data);\n\n" },
	\ { 'kind': 'f',	'word': 'barrier(',
	\					'abbr': 'barrier',
	\					'info': "\/\/ Synchronize execution of multiple shader invocations. This operation is\n".
	\							"\/\/ only available to tessallation control and compute shaders.\n" .
	\							"void barrier();\n\n" },
	\ { 'kind': 'f',	'word': 'bitCount(',
	\					'abbr': 'bitCount',
	\					'info': "\/\/ Count the number of 1 bits in an integer.\n" .
	\							"\/\/ param[in] value: The integer for which to count bits.\n".
	\							"\/\/ returns   The number of bits in value that are set to 1.\n".
	\							"genIType bitCount(genIType value);\n".
	\							"genIType bitCount(genUType value);\n\n" },
	\ { 'kind': 'f',	'word': 'bitfieldExtract(',
	\					'abbr': 'bitfieldExtract',
	\					'info': "\/\/ Extract a range of bits from an integer. The extracted bits are in the LSBs\n" .
	\							"\/\/ of the return value. The range to extract is [offset, offset + bits + 1].\n".
	\							"\/\/ For unsigned data, the result's MSBs are set to 0. For signed data, the\n".
	\							"\/\/ result's MSBs are set to offset + base - 1. The result is undefined if\n".
	\							"\/\/ offset or bits is negative, or if their sum is greater than the number of\n".
	\							"\/\/ bits available in value.\n".
	\							"\/\/ param[in] value:  The integer from which to extract bits.\n".
	\							"\/\/ param[in] offset: The index of the first bit to extract.\n".
	\							"\/\/ param[in] bits:   The number of bits to extract. If  bits is 0, the result\n".
	\							"\/\/                   is 0.\n".
	\							"\/\/ returns   The bits extracted from value.\n".
	\							"genIType bitfieldExtract(genIType value, int offset, int bits);\n".
	\							"genUType bitfieldExtract(genUType value, int offset, int bits);\n\n" },
	\ { 'kind': 'f',	'word': 'bitfieldInsert(',
	\					'abbr': 'bitfieldInsert',
	\					'info': "\/\/ Insert a range of bits into an integer.\n" .
	\					'info': "\/\/ Insert a range of bits into an integer. The inserted bits are bits\n".
	\							"\/\/ [0, bits - 1] of insert. Bits [offset, offset + bits + 1] of base are set\n".
	\							"\/\/ to the inserted bits. The result is undefined if offset or bits is\n".
	\							"\/\/ negative, or if their sum is greater than the number of bits available in\n".
	\							"\/\/ value.\n".
	\							"\/\/ param[in] base:   The integer into which bits should be inserted.\n".
	\							"\/\/ param[in] insert: Contains the bits to insert in the LSBs.\n".
	\							"\/\/ param[in] offset: The index into base of the first bit to insert.\n".
	\							"\/\/ param[in] bits:   The number of bits to insert.\n".
	\							"\/\/ returns   base with the specified bits inserted.\n".
	\							"genIType bitfieldInsert(genIType base, genIType insert, int offset, int bits);\n".
	\							"genUType bitfieldInsert(genUType base, genUType insert, int offset, int bits);\n\n" },
	\ { 'kind': 'f',	'word': 'bitfieldReverse(',
	\					'abbr': 'bitfieldReverse',
	\					'info': "\/\/ Reverse the order of the bits in an integer. Bit n receives the value in\n" .
	\							"\/\/ bit (N - 1) - n (where N is the bit width of value).\n".
	\							"\/\/ param[in] value: The integer to reverse.\n".
	\							"\/\/ returnes  The reverse of value.\n".
	\							"genIType bitfieldReverse(genIType value);\n".
	\							"genUType bitfieldReverse(genUType value);\n\n" },
	\ { 'kind': 'f',	'word': 'ceil(',
	\					'abbr': 'ceil',
	\					'info': "\/\/ Calculate the nearest integer greater than or equal to x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the ceiling.\n".
	\							"\/\/ returns   A mathematical integer c, such that c >= x.\n" .
	\							"genType  ceil(genType  x);\n" .
	\							"genDType ceil(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'clamp(',
	\					'abbr': 'clamp',
	\					'info': "\/\/ Constrain a value to a specific range.\n" .
	\							"\/\/ param[in] x:      The value to constrain.\n".
	\							"\/\/ param[in] minVal: The lower bound of the range.\n".
	\							"\/\/ param[in] maxVal: The upper bound of the range.\n".
	\							"\/\/ returns   min(max(x, minVal), maxVal);\n".
	\							"genType  clamp(genType  x, genType  minVal, genType  maxVal);\n" .
	\							"genType  clamp(genType  x, float    minVal, float    maxVal);\n" .
	\							"genDType clamp(genDType x, genDType minVal, genDType maxVal);\n" .
	\							"genDType clamp(genDType x, double   minVal, double   maxVal);\n" .
	\							"genIType clamp(genIType x, genIType minVal, genIType maxVal);\n" .
	\							"genIType clamp(genIType x, int      minVal, int      maxVal);\n" .
	\							"genUType clamp(genUType x, genUType minVal, genUType maxVal);\n" .
	\							"genUType clamp(genUType x, uint     minVal, uint     maxVal);\n\n" },
	\ { 'kind': 'f',	'word': 'cos(',
	\					'abbr': 'cos',
	\					'info': "\/\/ Calculate the cosine of an angle.\n".
	\							"\/\/ param[in] angle: The angle, in radians.\n".
	\							"\/\/ returns   The cosine of the given angle.\n" .
	\							"genType cos(genType angle);\n\n" },
	\ { 'kind': 'f',	'word': 'cosh(',
	\					'abbr': 'cosh',
	\					'info': "\/\/ Calculate the hyperbolic cosine of x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the hyperbolic cosine.\n".
	\							"\/\/ returns   (e^x + e^-x) / 2.\n" .
	\							"genType cosh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'cross(',
	\					'abbr': 'cross',
	\					'info': "\/\/ Calculate the cross product of two vectors.\n" .
	\							"\/\/ param[in] x: The first vector for the cross product operation.\n".
	\							"\/\/ param[in] y: The second vector for the cross product operation.\n".
	\							"\/\/ returns   (x.y)(y.z) - (x.z)(y.y)\n".
	\							"\/\/           (x.z)(y.x) - (x.x)(y.z)\n".
	\							"\/\/           (x.x)(y.y) - (x.y)(y.x)\n".
	\							"vec3  cross(vec3  x, vec3  y);\n".
	\							"dvec3 cross(dvec3 x, dvec3 y);\n\n" },
	\ { 'kind': 'f',	'word': 'degrees(',
	\					'abbr': 'degrees',
	\					'info': "\/\/ Convert an angle from radians to degrees.\n" .
	\							"\/\/ param[in] radians: The angle to convert.\n".
	\							"\/\/ returns   180 * radians / pi\n".
	\							"genType degrees(genType radians);\n\n" },
	\ { 'kind': 'f',	'word': 'determinant(',
	\					'abbr': 'determinant',
	\					'info': "\/\/ Calculate the determinant of a matrix.\n" .
	\							"\/\/ param[in] m: The matrix whose determinant should be calcualted.\n".
	\							"\/\/ returns   The determinant of m.\n".
	\							"float  determinant(mat2  m);\n".
	\							"float  determinant(mat3  m);\n".
	\							"float  determinant(mat4  m);\n".
	\							"double determinant(dmat2 m);\n".
	\							"double determinant(dmat3 m);\n".
	\							"double determinant(dmat4 m);\n\n" },
	\ { 'kind': 'f',	'word': 'dFdx(',
	\					'abbr': 'dFdx',
	\					'info': "\/\/ \n" .
	\							"dFdx();\n\n" },
	\ { 'kind': 'f',	'word': 'dFdxCoarse(',
	\					'abbr': 'dFdxCoarse',
	\					'info': "\/\/ \n" .
	\							"dFdxCoarse();\n\n" },
	\ { 'kind': 'f',	'word': 'dFdxFine(',
	\					'abbr': 'dFdxFine',
	\					'info': "\/\/ \n" .
	\							"dFdxFine();\n\n" },
	\ { 'kind': 'f',	'word': 'dFdy(',
	\					'abbr': 'dFdy',
	\					'info': "\/\/ \n" .
	\							"dFdy();\n\n" },
	\ { 'kind': 'f',	'word': 'dFdyCoarse(',
	\					'abbr': 'dFdyCoarse',
	\					'info': "\/\/ \n" .
	\							"dFdyCoarse();\n\n" },
	\ { 'kind': 'f',	'word': 'dFdyFine(',
	\					'abbr': 'dFdyFine',
	\					'info': "\/\/ \n" .
	\							"dFdyFine();\n\n" },
	\ { 'kind': 'f',	'word': 'distance(',
	\					'abbr': 'distance',
	\					'info': "\/\/ Calculate the distance between two points.\n".
	\							"\/\/ param[in] p0: The first point for the distance calculation.\n".
	\							"\/\/ param[in] p1: The second point for the distance calculation.\n".
	\							"\/\/ returns   length(p1 - p0)\n" .
	\							"double distance(genDType p0, genDType p1);\n".
	\							"float  distance(genType  p0, genType  p1);\n\n" },
	\ { 'kind': 'f',	'word': 'dot(',
	\					'abbr': 'dot',
	\					'info': "\/\/ Calculate the dot product of two vectors.\n" .
	\							"\/\/ param[in] x: The first vector for the dot product operation\n".
	\							"\/\/ param[in] y: The second vector for the dot product operation\n".
	\							"\/\/ returns   (x.x)(y.x) + (x.y)(y.y) + ...\n".
	\							"float  dot(genType  x, genType  y);\n".
	\							"double dot(genDType x, genDType y);\n\n" },
	\ { 'kind': 'f',	'word': 'EmitStreamVertex(',
	\					'abbr': 'EmitStreamVertex',
	\					'info': "\/\/ \n" .
	\							"EmitStreamVertex();\n\n" },
	\ { 'kind': 'f',	'word': 'EmitVertex(',
	\					'abbr': 'EmitVertex',
	\					'info': "\/\/ \n" .
	\							"EmitVertex();\n\n" },
	\ { 'kind': 'f',	'word': 'EndPrimitive(',
	\					'abbr': 'EndPrimitive',
	\					'info': "\/\/ \n" .
	\							"EndPrimitive();\n\n" },
	\ { 'kind': 'f',	'word': 'EndStreamPrimitive(',
	\					'abbr': 'EndStreamPrimitive',
	\					'info': "\/\/ \n" .
	\							"EndStreamPrimitive();\n\n" },
	\ { 'kind': 'f',	'word': 'equal(',
	\					'abbr': 'equal',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] == y[i].\n".
	\							"bvec equal(vec  x, vec  y);\n".
	\							"bvec equal(ivec x, ivec y);\n".
	\							"bvec equal(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'exp(',
	\					'abbr': 'exp',
	\					'info': "\/\/ Calculate the natural exponentiation of x.\n".
	\							"\/\/ param[in] x: The power to which e will be raised.\n".
	\							"\/\/ returns   e^x\n".
	\							"genType exp(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'exp2(',
	\					'abbr': 'exp2',
	\					'info': "\/\/ Calculate 2 to the x power.\n" .
	\							"\/\/ param[in] x: The power to which 2 will be raised.\n".
	\							"\/\/ returns   2^x\n".
	\							"genType exp2(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'faceforward(',
	\					'abbr': 'faceforward',
	\					'info': "\/\/ Calculate a vector which points in the same direction as another vector.\n" .
	\							"\/\/ This orients a vector to point away from a surface based on its normal.\n".
	\							"\/\/ param[in] N:    The vector to orient.\n".
	\							"\/\/ param[in] I:    The incident vector.\n".
	\							"\/\/ param[in] Nref: The reference vector.\n".
	\							"\/\/ returns   dot(Nref, I) < 0 ? N : -N\n".
	\							"genType  faceforward(genType  N, genType  I, genType  Nref);\n".
	\							"genDType faceforward(genDType N, genDType I, genDType Nref);\n\n" },
	\ { 'kind': 'f',	'word': 'findLSB(',
	\					'abbr': 'findLSB',
	\					'info': "\/\/ \n" .
	\							"findLSB();\n\n" },
	\ { 'kind': 'f',	'word': 'findMSB(',
	\					'abbr': 'findMSB',
	\					'info': "\/\/ \n" .
	\							"findMSB();\n\n" },
	\ { 'kind': 'f',	'word': 'floatBitsToInt(',
	\					'abbr': 'floatBitsToInt',
	\					'info': "\/\/ Encode a floating point value in an integer.\n".
	\							"\/\/ param[in] x: The floating point data to encode.\n".
	\							"\/\/ returns   The encoding of a floating point value as an integer.\n" .
	\							"genIType floatBitsToInt(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'floatBitsToUint(',
	\					'abbr': 'floatBitsToUint',
	\					'info': "\/\/ Encode a floating point value in an unsigned integer.\n".
	\							"\/\/ param[in] x: The floating point data to encode.\n".
	\							"\/\/ returns   The encoding of a floating point value as an unsigned integer.\n" .
	\							"genUType floatBitsToUint(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'floor(',
	\					'abbr': 'floor',
	\					'info': "\/\/ Calculate the nearest integer less than or equal to x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the floor.\n".
	\							"\/\/ returns   A mathematical integer c, such that c <= x.\n" .
	\							"genType  floor(genType  x);\n" .
	\							"genDType floor(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'fma(',
	\					'abbr': 'fma',
	\					'info': "\/\/ Perform a fused multiply-add operation. When using precise, the following\n".
	\							"\/\/ conditions hold:\n" .
	\							"\/\/     1) fma() is a single operation,\n" .
	\							"\/\/     2) the precision of fma() can differ from the code a * b + c,\n" .
	\							"\/\/     3) this call to fma() is invariant with other precise calls to fma()\n".
	\							"\/\/        with the same parameters.\n" .
	\							"\/\/ param[in] a: The first multiplication factor.\n".
	\							"\/\/ param[in] b: The second multiplication factor.\n".
	\							"\/\/ param[in] c: The addend.\n".
	\							"\/\/ returns   ab+c\n".
	\							"genType  fma(genType  a, genType  b, genType  c);\n" .
	\							"genDType fma(genDType a, genDType b, genDType c);\n\n" },
	\ { 'kind': 'f',	'word': 'fract(',
	\					'abbr': 'fract',
	\					'info': "\/\/ Calculate the fractional part of x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the fraction.\n".
	\							"\/\/ returns   x - floor(x)\n".
	\							"genType  fract(genType  x);\n" .
	\							"genDType fract(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'frexp(',
	\					'abbr': 'frexp',
	\					'info': "\/\/ Split a floating point value into its significand and exponent. The split\n".
	\							"\/\/ occurs such that x = significand * 2^exp. The result is undefined if x is\n".
	\							"\/\/ NaN or infinity.\n".
	\							"\/\/ param[in]  x:   The floating point value to split.\n" .
	\							"\/\/ param[out] exp: The exponent output from the function.\n" .
	\							"\/\/ returns    The significand on the range [0.5, 1.0].\n" .
	\							"genType  frexp(genType  x, out genIType exp);\n" .
	\							"genDType frexp(genDType x, out genIType exp);\n\n" },
	\ { 'kind': 'f',	'word': 'fwidth(',
	\					'abbr': 'fwidth',
	\					'info': "\/\/ \n" .
	\							"fwidth();\n\n" },
	\ { 'kind': 'f',	'word': 'fwidthCoarse(',
	\					'abbr': 'fwidthCoarse',
	\					'info': "\/\/ \n" .
	\							"fwidthCoarse();\n\n" },
	\ { 'kind': 'f',	'word': 'fwidthFine(',
	\					'abbr': 'fwidthFine',
	\					'info': "\/\/ \n" .
	\							"fwidthFine();\n\n" },
	\ { 'kind': 'f',	'word': 'greaterThan(',
	\					'abbr': 'greaterThan',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] > y[i].\n".
	\							"bvec greaterThan(vec  x, vec  y);\n".
	\							"bvec greaterThan(ivec x, ivec y);\n".
	\							"bvec greaterThan(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'greaterThanEqual(',
	\					'abbr': 'greaterThanEqual',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] >= y[i].\n".
	\							"bvec greaterThanEqual(vec  x, vec  y);\n".
	\							"bvec greaterThanEqual(ivec x, ivec y);\n".
	\							"bvec greaterThanEqual(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'groupMemoryBarrier(',
	\					'abbr': 'groupMemoryBarrier',
	\					'info': "\/\/ \n" .
	\							"groupMemoryBarrier();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicAdd(',
	\					'abbr': 'imageAtomicAdd',
	\					'info': "\/\/ \n" .
	\							"imageAtomicAdd();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicAnd(',
	\					'abbr': 'imageAtomicAnd',
	\					'info': "\/\/ \n" .
	\							"imageAtomicAnd();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicCompSwap(',
	\					'abbr': 'imageAtomicCompSwap',
	\					'info': "\/\/ \n" .
	\							"imageAtomicCompSwap();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicExchange(',
	\					'abbr': 'imageAtomicExchange',
	\					'info': "\/\/ \n" .
	\							"imageAtomicExchange();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicMax(',
	\					'abbr': 'imageAtomicMax',
	\					'info': "\/\/ \n" .
	\							"imageAtomicMax();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicMin(',
	\					'abbr': 'imageAtomicMin',
	\					'info': "\/\/ \n" .
	\							"imageAtomicMin();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicOr(',
	\					'abbr': 'imageAtomicOr',
	\					'info': "\/\/ \n" .
	\							"imageAtomicOr();\n\n" },
	\ { 'kind': 'f',	'word': 'imageAtomicXor(',
	\					'abbr': 'imageAtomicXor',
	\					'info': "\/\/ \n" .
	\							"imageAtomicXor();\n\n" },
	\ { 'kind': 'f',	'word': 'imageLoad(',
	\					'abbr': 'imageLoad',
	\					'info': "\/\/ \n" .
	\							"imageLoad();\n\n" },
	\ { 'kind': 'f',	'word': 'imageSamples(',
	\					'abbr': 'imageSamples',
	\					'info': "\/\/ \n" .
	\							"imageSamples();\n\n" },
	\ { 'kind': 'f',	'word': 'imageSize(',
	\					'abbr': 'imageSize',
	\					'info': "\/\/ \n" .
	\							"imageSize();\n\n" },
	\ { 'kind': 'f',	'word': 'imageStore(',
	\					'abbr': 'imageStore',
	\					'info': "\/\/ \n" .
	\							"imageStore();\n\n" },
	\ { 'kind': 'f',	'word': 'imulExtended(',
	\					'abbr': 'imulExtended',
	\					'info': "\/\/ \n" .
	\							"imulExtended();\n\n" },
	\ { 'kind': 'f',	'word': 'intBitsToFloat(',
	\					'abbr': 'intBitsToFloat',
	\					'info': "\/\/ Decode a floating point value from an integer. The result is undefined if x\n".
	\							"\/\/ encodes NaN.\n".
	\							"\/\/ param[in] x: The integer containing the encoded floating point value.\n".
	\							"\/\/ returns   A floating point value decoded from x.\n".
	\							"genType intBitsToFloat(genIType x);\n\n" },
	\ { 'kind': 'f',	'word': 'interpolateAtCentroid(',
	\					'abbr': 'interpolateAtCentroid',
	\					'info': "\/\/ \n" .
	\							"interpolateAtCentroid();\n\n" },
	\ { 'kind': 'f',	'word': 'interpolateAtOffset(',
	\					'abbr': 'interpolateAtOffset',
	\					'info': "\/\/ \n" .
	\							"interpolateAtOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'interpolateAtSample (',
	\					'abbr': 'interpolateAtSample ',
	\					'info': "\/\/ \n" .
	\							"interpolateAtSample ();\n\n" },
	\ { 'kind': 'f',	'word': 'inverse(',
	\					'abbr': 'inverse',
	\					'info': "\/\/ Calculate the inverse of a matrix. The result is undefined if m is singular\n" .
	\							"\/\/ nearly singular.\n".
	\							"\/\/ param[in] m: The matrix to invert.\n".
	\							"\/\/ returns   The inverse of m.\n".
	\							"mat2  inverse(mat2  m);\n".
	\							"mat3  inverse(mat3  m);\n".
	\							"mat4  inverse(mat4  m);\n".
	\							"dmat2 inverse(dmat2 m);\n".
	\							"dmat3 inverse(dmat3 m);\n".
	\							"dmat4 inverse(dmat4 m);\n\n" },
	\ { 'kind': 'f',	'word': 'inversesqrt(',
	\					'abbr': 'inversesqrt',
	\					'info': "\/\/ Calculate one divided by the square root of x. The result is undefined if\n".
	\							"\/\/ x <= 0.\n" .
	\							"\/\/ param[in] x: The value to square root and invert.\n".
	\							"\/\/ returns   1 / sqrt(x)\n" .
	\							"genType  inversesqrt(genType  x);\n" .
	\							"genDType inversesqrt(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'isinf(',
	\					'abbr': 'isinf',
	\					'info': "\/\/ Determine if x is positive or negative infinity.\n" .
	\							"\/\/ param[in] x: The value to check for infinity.\n".
	\							"\/\/ returns   True if x is infinity, and false otherwise.\n" .
	\							"genBType isinf(genType  x);\n" .
	\							"genBType isinf(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'isnan(',
	\					'abbr': 'isnan',
	\					'info': "\/\/ Determine if x is not a number (NaN).\n" .
	\							"\/\/ param[in] x: The value to check for NaN.\n".
	\							"\/\/ returns   True if x is NaN, false otherwise.\n".
	\							"genBType isnan(genType  x);\n" .
	\							"genBType isnan(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'ldexp(',
	\					'abbr': 'ldexp',
	\					'info': "\/\/ Generate a floating point value from a significand and exponent. The result\n".
	\							"\/\/ is undefined if it is too large to fit in the floating point type.\n" .
	\							"\/\/ param[in] x:   The significand.\n".
	\							"\/\/ param[in] exp: The exponent.\n".
	\							"\/\/ returns   x * 2^exp\n" .
	\							"genType  ldexp(genType  x, genIType exp);\n" .
	\							"genDType ldexp(genDType x, genIType exp);\n\n" },
	\ { 'kind': 'f',	'word': 'length(',
	\					'abbr': 'length',
	\					'info': "\/\/ Calculate the length of a vector.\n" .
	\							"\/\/ param[in] x: The vector for which to calculate the length.\n".
	\							"\/\/ returns   sqrt(x.x^2 + x.y^2 ...)\n".
	\							"float  length(genType  x);\n".
	\							"double length(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'lessThan(',
	\					'abbr': 'lessThan',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] < y[i].\n".
	\							"bvec lessThan(vec  x, vec  y);\n".
	\							"bvec lessThan(ivec x, ivec y);\n".
	\							"bvec lessThan(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'lessThanEqual(',
	\					'abbr': 'lessThanEqual',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] <= y[i].\n".
	\							"bvec lessThanEqual(vec  x, vec  y);\n".
	\							"bvec lessThanEqual(ivec x, ivec y);\n".
	\							"bvec lessThanEqual(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'log(',
	\					'abbr': 'log',
	\					'info': "\/\/ Calculate the natural logarithm of x. The result is undefined if x <= 0.\n" .
	\							"\/\/ param[in] x: The value for which to take the natural logarithm.\n".
	\							"\/\/ returns   ln(x)\n" .
	\							"genType log(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'log2(',
	\					'abbr': 'log2',
	\					'info': "\/\/ Calculate the base-2 logarithm of x. The result is undefined if x <= 0.\n" .
	\							"\/\/ param[in] x: The value for which to take the logarithm.\n".
	\							"\/\/ returns   log(x) using 2 as the logarithm base.\n" .
	\							"genType log2(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'matrixCompMult(',
	\					'abbr': 'matrixCompMult',
	\					'info': "\/\/ Multiply two matrices component-wise.\n" .
	\							"\/\/ param[in] x: The first matrix factor.\n".
	\							"\/\/ param[in] y: The second matrix fator.\n".
	\							"\/\/ returns   A matrix m, such that m[i] = x[i] * y[i].\n".
	\							"dmat matrixCompMult(dmat x, dmat y);\n".
	\							"mat  matrixCompMult(mat  x, mat  y);\n\n" },
	\ { 'kind': 'f',	'word': 'max(',
	\					'abbr': 'max',
	\					'info': "\/\/ Calculate the maximum of two values.\n".
	\							"\/\/ param[in] x: The first value to compare.\n".
	\							"\/\/ param[in] y: The second value to compare.\n".
	\							"\/\/ returns   x > y ? x : y\n".
	\							"genType  max(genType  x, genType  y);\n" .
	\							"genType  max(genType  x, float    y);\n" .
	\							"genDType max(genDType x, genDType y);\n" .
	\							"genDType max(genDType x, double   y);\n" .
	\							"genIType max(genIType x, genIType y);\n" .
	\							"genIType max(genIType x, int      y);\n" .
	\							"genUType max(genUType x, genUType y);\n" .
	\							"genUType max(genUType x, uint     y);\n\n" },
	\ { 'kind': 'f',	'word': 'memoryBarrier(',
	\					'abbr': 'memoryBarrier',
	\					'info': "\/\/ \n" .
	\							"memoryBarrier();\n\n" },
	\ { 'kind': 'f',	'word': 'memoryBarrierAtomicCounter(',
	\					'abbr': 'memoryBarrierAtomicCounter',
	\					'info': "\/\/ \n" .
	\							"memoryBarrierAtomicCounter();\n\n" },
	\ { 'kind': 'f',	'word': 'memoryBarrierBuffer(',
	\					'abbr': 'memoryBarrierBuffer',
	\					'info': "\/\/ \n" .
	\							"memoryBarrierBuffer();\n\n" },
	\ { 'kind': 'f',	'word': 'memoryBarrierImage(',
	\					'abbr': 'memoryBarrierImage',
	\					'info': "\/\/ \n" .
	\							"memoryBarrierImage();\n\n" },
	\ { 'kind': 'f',	'word': 'memoryBarrierShared(',
	\					'abbr': 'memoryBarrierShared',
	\					'info': "\/\/ \n" .
	\							"memoryBarrierShared();\n\n" },
	\ { 'kind': 'f',	'word': 'min(',
	\					'abbr': 'min',
	\					'info': "\/\/ Calculate the minimum of two values.\n".
	\							"\/\/ param[in] x: The first value to compare.\n".
	\							"\/\/ param[in] y: The second value to compare.\n".
	\							"\/\/ returns   x < y ? x : y\n".
	\							"genType  min(genType  x, genType  y);\n" .
	\							"genType  min(genType  x, float    y);\n" .
	\							"genDType min(genDType x, genDType y);\n" .
	\							"genDType min(genDType x, double   y);\n" .
	\							"genIType min(genIType x, genIType y);\n" .
	\							"genIType min(genIType x, int      y);\n" .
	\							"genUType min(genUType x, genUType y);\n" .
	\							"genUType min(genUType x, uint     y);\n\n" },
	\ { 'kind': 'f',	'word': 'mix(',
	\					'abbr': 'mix',
	\					'info': "\/\/ Linearly interpolate between x and y, by amount a.\n" .
	\							"\/\/ param[in] x: The lower bound on the range of interpolation.\n".
	\							"\/\/ param[in] y: The upper bound on the range of interpolation.\n".
	\							"\/\/ param[in] a: The interpolation value between x and y.\n" .
	\							"\/\/ returns   x(1-a) + ya\n" .
	\							"genType  mix(genType  x, genType  y, genType  a);\n" .
	\							"genType  mix(genType  x, genType  y, float    a);\n" .
	\							"genDType mix(genDType x, genDType y, genDType a);\n" .
	\							"genDType mix(genDType x, genDType y, double   a);\n\n" .
	\							"\/\/ Select components from x and y, based on a.\n" .
	\							"\/\/ param[in] x: The value selected if a is false.\n".
	\							"\/\/ param[in] y: The value selected if a is true.\n".
	\							"\/\/ param[in] a: The selection boolean.\n".
	\							"\/\/ returns   a ? y : x\n".
	\							"genType  mix(genType  x, genType  y, genBType a);\n" .
	\							"genDType mix(genDType x, genDType y, genBType a);\n" .
	\							"genIType mix(genIType x, genIType y, genBType a);\n" .
	\							"genUType mix(genUType x, genUType y, genBType a);\n" .
	\							"genBType mix(genBType x, genBType y, genBType a);\n\n" },
	\ { 'kind': 'f',	'word': 'mod(',
	\					'abbr': 'mod',
	\					'info': "\/\/ Calculate x modulo y.\n".
	\							"\/\/ param[in] x: The dividend of the modulo operation.".
	\							"\/\/ param[in] y: The divisor of the modulo operation.".
	\							"\/\/ returns   x - y * floor(x/y).\n" .
	\							"genType  mod(genType  x, float    y);\n" .
	\							"genType  mod(genType  x, genType  y);\n" .
	\							"genDType mod(genDType x, double   y);\n" .
	\							"genDType mod(genDType x, genDType y);\n\n" },
	\ { 'kind': 'f',	'word': 'modf(',
	\					'abbr': 'modf',
	\					'info': "\/\/ Separate x into its integer and fractional components.\n" .
	\							"\/\/ param[in]  x: The value to separate.\n" .
	\							"\/\/ param[out] i: The integer component of x.\n" .
	\							"\/\/ returns    The fractional component of x.\n" .
	\							"genType  modf(genType  x, out genType  i);\n" .
	\							"genDType modf(genDType x, out genDType i);\n\n" },
	\ { 'kind': 'f',	'word': 'noise1(',
	\					'abbr': 'noise1',
	\					'info': "\/\/ \n" .
	\							"noise1();\n\n" },
	\ { 'kind': 'f',	'word': 'noise2(',
	\					'abbr': 'noise2',
	\					'info': "\/\/ \n" .
	\							"noise2();\n\n" },
	\ { 'kind': 'f',	'word': 'noise3(',
	\					'abbr': 'noise3',
	\					'info': "\/\/ \n" .
	\							"noise3();\n\n" },
	\ { 'kind': 'f',	'word': 'noise4(',
	\					'abbr': 'noise4',
	\					'info': "\/\/ \n" .
	\							"noise4();\n\n" },
	\ { 'kind': 'f',	'word': 'normalize(',
	\					'abbr': 'normalize',
	\					'info': "\/\/ Normalize a vector. The returned vector has the same direction as v, but\n" .
	\							"\/\/ length equal to 1.\n".
	\							"\/\/ param[in] v: The vector to normalize.\n".
	\							"\/\/ returns   v / length(v)\n".
	\							"genType  normalize(genType  v);\n".
	\							"genDType normalize(genDType v);\n\n" },
	\ { 'kind': 'f',	'word': 'not(',
	\					'abbr': 'not',
	\					'info': "\/\/ Invert each component of a boolean vector.\n" .
	\							"\/\/ param[in] x: The vector to invert.\n".
	\							"\/\/ returns   bvec(!x[0], !x[1], ...);\n".
	\							"bvec not(bvec x);\n\n" },
	\ { 'kind': 'f',	'word': 'notEqual(',
	\					'abbr': 'notEqual',
	\					'info': "\/\/ Compare two vectors, component-wise.\n" .
	\							"\/\/ param[in] x,y: The two vectors to compare.\n".
	\							"\/\/ returns   A boolean vector b such that b[i] = x[i] != y[i].\n".
	\							"bvec lessThan(vec  x, vec  y);\n".
	\							"bvec lessThan(ivec x, ivec y);\n".
	\							"bvec lessThan(uvec x, uvec y);\n\n" },
	\ { 'kind': 'f',	'word': 'outerProduct(',
	\					'abbr': 'outerProduct',
	\					'info': "\/\/ Calculate the outer product of two vectors.\n" .
	\							"\/\/ param[in] c: The vector to be treated as a column vector.\n".
	\							"\/\/ param[in] r: The vector to be treated as a row vector.\n".
	\							"\/\/ returns   A matrix with a number of rows equal to the number of components\n".
	\							"\/\/           in c, and a number of columns equal to the number of components\n".
	\							"\/\/           in r.\n".
	\							"mat2    outerProduct(vec2  c, vec2  r);\n".
	\							"mat3    outerProduct(vec3  c, vec3  r);\n".
	\							"mat4    outerProduct(vec4  c, vec4  r);\n".
	\							"mat2x3  outerProduct(vec3  c, vec2  r);\n".
	\							"mat3x2  outerProduct(vec2  c, vec3  r);\n".
	\							"mat2x4  outerProduct(vec4  c, vec2  r);\n".
	\							"mat4x2  outerProduct(vec2  c, vec4  r);\n".
	\							"mat3x4  outerProduct(vec4  c, vec3  r);\n".
	\							"mat4x3  outerProduct(vec3  c, vec4  r);\n".
	\							"dmat2   outerProduct(dvec2 c, dvec2 r);\n".
	\							"dmat3   outerProduct(dvec3 c, dvec3 r);\n".
	\							"dmat4   outerProduct(dvec4 c, dvec4 r);\n".
	\							"dmat2x3 outerProduct(dvec3 c, dvec2 r);\n".
	\							"dmat3x2 outerProduct(dvec2 c, dvec3 r);\n".
	\							"dmat2x4 outerProduct(dvec4 c, dvec2 r);\n".
	\							"dmat4x2 outerProduct(dvec2 c, dvec4 r);\n".
	\							"dmat3x4 outerProduct(dvec4 c, dvec3 r);\n".
	\							"dmat4x3 outerProduct(dvec3 c, dvec4 r);\n\n" },
	\ { 'kind': 'f',	'word': 'packDouble2x32(',
	\					'abbr': 'packDouble2x32',
	\					'info': "\/\/ Pack 2 unsigned integers into a double precision variable. The first\n".
	\							"\/\/ component of v is packed into the 32 LSBs. The second component of v is\n".
	\							"\/\/ packed into the 32 MSBs. The result is undefined if v is NaN or infinity.\n".
	\							"\/\/ param[in] v: The two integers to pack.\n".
	\							"\/\/ returns   v packed into a double precesion value.\n".
	\							"double packDouble2x32(uvec2 v);\n\n" },
	\ { 'kind': 'f',	'word': 'packHalf2x16(',
	\					'abbr': 'packHalf2x16',
	\					'info': "\/\/ Convert 2 32-bit floating point values to 16-bit, then pack them into an\n".
	\							"\/\/ unsigned integer. v.x is packed into the 16 LSBs of the results, and v.y is\n".
	\							"\/\/ packed into the 16 MSBs.\n".
	\							"\/\/ param[in] v: The 2 floating point values to pack.\n".
	\							"\/\/ returns   An unsigned integer representing the packed values of v.\n".
	\							"uint packHalf2x16(vec2 v);\n\n" },
	\ { 'kind': 'f',	'word': 'packSnorm2x16(',
	\					'abbr': 'packSnorm2x16',
	\					'info': "\/\/ Pack 2 floating point values into an unsigned integer. The first component\n".
	\							"\/\/ is packed into the 8 LSBs. The last component is packed into the 8 MSBs.\n" .
	\							"\/\/ param[in] v: The values to pack.\n" .
	\							"\/\/ returns   round(clamp(v, -1.0, 1.0) * 32767.0);\n" .
	\							"uint packSnorm2x16(vec2 v);\n\n" },
	\ { 'kind': 'f',	'word': 'packSnorm4x8(',
	\					'abbr': 'packSnorm4x8',
	\					'info': "\/\/ Pack 4 floating point values into an unsigned integer. The first component\n".
	\							"\/\/ is packed into the 8 LSBs. The last component is packed into the 8 MSBs.\n" .
	\							"\/\/ The second and third components are packed into the corresponding bits.\n" .
	\							"\/\/ param[in] v: The values to pack.\n" .
	\							"\/\/ returns   round(clamp(v, -1.0, 1.0) * 127.0);\n" .
	\							"uint packSnorm4x8(vec4 v);\n\n" },
	\ { 'kind': 'f',	'word': 'packUnorm2x16(',
	\					'abbr': 'packUnorm2x16',
	\					'info': "\/\/ Pack 2 floating point values into an unsigned integer. The first component\n".
	\							"\/\/ is packed into the 8 LSBs. The last component is packed into the 8 MSBs.\n" .
	\							"\/\/ param[in] v: The values to pack.\n" .
	\							"\/\/ returns   round(clamp(v, 0.0, 1.0) * 65535.0);\n" .
	\							"uint packUnorm2x16(vec2 v);\n\n" },
	\ { 'kind': 'f',	'word': 'packUnorm4x8(',
	\					'abbr': 'packUnorm4x8',
	\					'info': "\/\/ Pack 4 floating point values into an unsigned integer. The first component\n".
	\							"\/\/ is packed into the 8 LSBs. The last component is packed into the 8 MSBs.\n".
	\							"\/\/ The second and third components are packed into the corresponding bits.\n" .
	\							"\/\/ param[in] v: The values to pack.\n" .
	\							"\/\/ returns   round(clamp(v, 0.0, 1.0) * 255.0);\n" .
	\							"uint packUnorm2x16(vec4 v);\n\n" },
	\ { 'kind': 'f',	'word': 'pow(',
	\					'abbr': 'pow',
	\					'info': "\/\/ Calculate x raised to the y power. The result is undefined if x < 0, or\n".
	\							"\/\/ if x == 0 and y <= 0.\n" .
	\							"\/\/ param[in] x: The value to raise.\n".
	\							"\/\/ param[in] y: The power to which x should be raised.\n".
	\							"\/\/ returns   x^y\n" .
	\							"genType pow(genType x, genType y);\n\n" },
	\ { 'kind': 'f',	'word': 'radians(',
	\					'abbr': 'radians',
	\					'info': "\/\/ Convert an angle from degrees to radians.\n" .
	\							"\/\/ param[in] degrees: The angle to convert.\n".
	\							"\/\/ returns   pi * degrees / 180\n".
	\							"genType radians(genType degrees);\n\n" },
	\ { 'kind': 'f',	'word': 'reflect(',
	\					'abbr': 'reflect',
	\					'info': "\/\/ Calculate the reflection of a vector.\n" .
	\							"\/\/ param[in] I: The vector to reflect.\n".
	\							"\/\/ param[in] N: The normal vector about which to reflect I. This should be\n".
	\							"\/\/              unit length.\n".
	\							"\/\/ returns   I - (2N * dot(N, I))\n".
	\							"genType  reflect(genType  I, genType  N);\n".
	\							"genDType reflect(genDType I, genDType N);\n\n" },
	\ { 'kind': 'f',	'word': 'refract(',
	\					'abbr': 'refract',
	\					'info': "\/\/ Calculate the refraction direction of a vector.\n" .
	\							"\/\/ param[in] I: The vector to refract.\n".
	\							"\/\/ param[in] N: The normal vector about which to refract I.\n".
	\							"\/\/ param[in] eta: The ratio of refraction indices.\n".
	\							"\/\/ returns   A vector pointing in the direction of refraction for vector I.\n".
	\							"genType  refract(genType  I, genType  N, float  eta);\n".
	\							"genDType refract(genDType I, genDType N, double eta);\n\n" },
	\ { 'kind': 'f',	'word': 'round(',
	\					'abbr': 'round',
	\					'info': "\/\/ Calculate the nearest integer to x. Rounding 0.5 is implementation\n".
	\							"\/\/ dependent.\n" .
	\							"\/\/ param[in] x: The value to round.\n".
	\							"\/\/ returns   The nearest integer to x.\n" .
	\							"genType  round(genType  x);\n" .
	\							"genDType round(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'roundEven(',
	\					'abbr': 'roundEven',
	\					'info': "\/\/ Find the even integer closest to x.\n" .
	\							"\/\/ param[in] x: The value to round.\n".
	\							"\/\/ returns   The even integer nearest to x.\n".
	\							"genType  roundEven(genType  x);\n" .
	\							"genDType roundEven(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'sign(',
	\					'abbr': 'sign',
	\					'info': "\/\/ Determine the sign of x.\n" .
	\							"\/\/ param[in] x: The value for which to determine the sign.\n".
	\							"\/\/ returns   x < 0.0 ? -1.0 : (x > 0.0 ? 1.0 : 0.0)\n";
	\							"genType  sign(genType  x);\n" .
	\							"genDType sign(genDType x);\n" .
	\							"genIType sign(genIType x);\n\n" },
	\ { 'kind': 'f',	'word': 'sin(',
	\					'abbr': 'sin',
	\					'info': "\/\/ Calculate the sine of an angle.\n".
	\							"\/\/ param[in] angle: The angle, in radians.\n".
	\							"\/\/ returns   The sine of the given angle.\n" .
	\							"genType sin(genType angle);\n\n" },
	\ { 'kind': 'f',	'word': 'sinh(',
	\					'abbr': 'sinh',
	\					'info': "\/\/ Calculate the hyperbolic sine of x.\n".
	\							"\/\/ param[in] x: The value for which to calcualte the hyperbolic sine.\n".
	\							"\/\/ returns   (e^x - e^-x) / 2\n" .
	\							"genType sinh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'smoothstep(',
	\					'abbr': 'smoothstep',
	\					'info': "\/\/ Perform a Hermite interpolation between edge0 and edge1. This is\n".
	\							"\/\/ equivalent to:\n" .
	\							"\/\/     genType t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);\n" .
	\							"\/\/     return t * t * (3.0 - 2.0 * t);\n" .
	\							"\/\/ The result is undefined if edge0 >= edge1.\n" .
	\							"\/\/ param[in] edge0: The lower bound of the interpolation range.\n".
	\							"\/\/ param[in] edge1: The upper bound of the interpolation range.\n".
	\							"\/\/ param[in] x:     The interpolation's source value.\n".
	\							"\/\/ returns   The value of the equations noted above.\n".
	\							"genType  smoothstep(genType  edge0, genType  edge1, genType  x);\n" .
	\							"genType  smoothstep(float    edge0, float    edge1, genType  x);\n" .
	\							"genDType smoothstep(genDType edge0, genDType edge1, genDType x);\n" .
	\							"genDType smoothstep(double   edge0, double   edge1, genDType x);\n" },
	\ { 'kind': 'f',	'word': 'sqrt(',
	\					'abbr': 'sqrt',
	\					'info': "\/\/ Calculate the square root of x. The result is undefined if x < 0.\n" .
	\							"\/\/ param[in] x: The value for which to take the square root.\n".
	\							"\/\/ returns   The square root of x.\n" .
	\							"genType  sqrt(genType  x);\n" .
	\							"genDType sqrt(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'step(',
	\					'abbr': 'step',
	\					'info': "\/\/ Generate a step function by comparing edge to x. The function looks like:\n" .
	\							"\/\/ 1            __________\n".
	\							"\/\/ 0  _________|\n".
	\							"\/\/             ^edge\n".
	\							"\/\/ param[in] edge: The value at which the function should return 1.\n".
	\							"\/\/ param[in] x:    The value to compare to edge.\n".
	\							"\/\/ returns   x < edge ? 0.0 : 1.0\n".
	\							"genType  step(genType  edge, genType  x);\n" .
	\							"genType  step(float    edge, genType  x);\n" .
	\							"genDType step(genDType edge, genDType x);\n" .
	\							"genDType step(double   edge, genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'tan(',
	\					'abbr': 'tan',
	\					'info': "\/\/ Calculate the tangent of an angle.\n".
	\							"\/\/ param[in] angle: The angle, in radians.\n".
	\							"\/\/ returns   The tangent of the given angle.\n" .
	\							"genType tan(genType angle);\n\n" },
	\ { 'kind': 'f',	'word': 'tanh(',
	\					'abbr': 'tanh',
	\					'info': "\/\/ Calculate the hyperbolic tangent of x.\n".
	\							"\/\/ param[in] x: The value for which to calculate the hyperbolic tangent.\n".
	\							"\/\/ returns   sinh(x) / cosh(x)\n".
	\							"genType tanh(genType x);\n\n" },
	\ { 'kind': 'f',	'word': 'texelFetch(',
	\					'abbr': 'texelFetch',
	\					'info': "\/\/ \n" .
	\							"texelFetch();\n\n" },
	\ { 'kind': 'f',	'word': 'texelFetchOffset(',
	\					'abbr': 'texelFetchOffset',
	\					'info': "\/\/ \n" .
	\							"texelFetchOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'texture(',
	\					'abbr': 'texture',
	\					'info': "\/\/ Get texels from a texture.\n" .
	\							"\/\/ param[in] sampler: The sampler to which the texture is bound.\n".
	\							"\/\/ param[in] P:       The texture coordinates at which to to sample.\n".
	\							"\/\/ param[in] bias:    A bias value to be applied to LoD calculation.\n".
	\							"\/\/ param[in] compare: The value to which the texel will be compared.\n".
	\							"gvec4 texture(gsampler{1D[Array],2D[Array,Rect],3D,Cube[Array]} sampler,\n".
	\							"              {float,vec2,vec3,vec4} P [, float bias]);\n".
	\							"float texture(sampler{1D[Array],2D[Array,Rect],Cube}Shadow sampler,\n".
	\							"              {vec3,vec4} P [, float bias]);\n".
	\							"float texture(gsamplerCubeArrayShadow sampler, vec4 P, float compare);\n\n" },
	\ { 'kind': 'f',	'word': 'textureGather(',
	\					'abbr': 'textureGather',
	\					'info': "\/\/ \n" .
	\							"textureGather();\n\n" },
	\ { 'kind': 'f',	'word': 'textureGatherOffset(',
	\					'abbr': 'textureGatherOffset',
	\					'info': "\/\/ \n" .
	\							"textureGatherOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureGatherOffsets(',
	\					'abbr': 'textureGatherOffsets',
	\					'info': "\/\/ \n" .
	\							"textureGatherOffsets();\n\n" },
	\ { 'kind': 'f',	'word': 'textureGrad(',
	\					'abbr': 'textureGrad',
	\					'info': "\/\/ \n" .
	\							"textureGrad();\n\n" },
	\ { 'kind': 'f',	'word': 'textureGradOffset(',
	\					'abbr': 'textureGradOffset',
	\					'info': "\/\/ \n" .
	\							"textureGradOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureLod(',
	\					'abbr': 'textureLod',
	\					'info': "\/\/ \n" .
	\							"textureLod();\n\n" },
	\ { 'kind': 'f',	'word': 'textureLodOffset(',
	\					'abbr': 'textureLodOffset',
	\					'info': "\/\/ \n" .
	\							"textureLodOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureOffset(',
	\					'abbr': 'textureOffset',
	\					'info': "\/\/ \n" .
	\							"textureOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureProj(',
	\					'abbr': 'textureProj',
	\					'info': "\/\/ Get a texel from texture by projecting the given coordinates.\n" .
	\							"\/\/ param[in] sampler: The sampler to which the texture is bound.\n".
	\							"\/\/ param[in] P:       The texture coordinates at which to to sample.\n".
	\							"\/\/ param[in] bias:    A bias value to be applied to LoD calculation.\n".
	\							"\/\/ returns   The texel value for the given texture, at the given coordinates.\n".
	\							"gvec4 textureProj(gsampler{1D,2D[Rect],3D} sampler,\n".
	\							"                  {vec2,vec3,vec4} P [, float bias]);\n".
	\							"float textureProj(sampler{1D,2D[Rect]}Shadow sampler, vec4 P [, float bias]);\n\n" },
	\ { 'kind': 'f',	'word': 'textureProjGrad(',
	\					'abbr': 'textureProjGrad',
	\					'info': "\/\/ \n" .
	\							"textureProjGrad();\n\n" },
	\ { 'kind': 'f',	'word': 'textureProjGradOffset(',
	\					'abbr': 'textureProjGradOffset',
	\					'info': "\/\/ \n" .
	\							"textureProjGradOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureProjLod(',
	\					'abbr': 'textureProjLod',
	\					'info': "\/\/ \n" .
	\							"textureProjLod();\n\n" },
	\ { 'kind': 'f',	'word': 'textureProjLodOffset(',
	\					'abbr': 'textureProjLodOffset',
	\					'info': "\/\/ \n" .
	\							"textureProjLodOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureProjOffset(',
	\					'abbr': 'textureProjOffset',
	\					'info': "\/\/ \n" .
	\							"textureProjOffset();\n\n" },
	\ { 'kind': 'f',	'word': 'textureQueryLod(',
	\					'abbr': 'textureQueryLod',
	\					'info': "\/\/ Get the level of detail which would be used to sample a texture.\n" .
	\							"\/\/ param[in] sampler: The sampler to which the texture is bound.\n".
	\							"\/\/ param[in] P:       The texture coordinates at which to get the LoD.\n".
	\							"\/\/ returns   (mipmap array, level of detail)\n".
	\							"vec2 textureQueryLod(gsampler{1D[Array],2D[Array],3D,Cube[Array]} sampler,\n".
	\							"                     {float,vec2,vec3} P);\n".
	\							"vec2 textureQueryLod(sampler{1D[Array],2D[Array],Cube[Array]}Shadow sampler,\n".
	\							"                     {float,vec2,vec3} P);\n\n" },
	\ { 'kind': 'f',	'word': 'textureQueryLevels(',
	\					'abbr': 'textureQueryLevels',
	\					'info': "\/\/ Get the number of mipmap levels of a texture.\n" .
	\							"\/\/ param[in] sampler: The sampler to which the texture is bound.\n".
	\							"\/\/ returns   The number of mipmap levels accessible in the specified texture.\n".
	\							"int textureQueryLevels(gsampler{1D[Array],2D[Array],3D,Cube[Array]} sampler);\n".
	\							"int textureQueryLevels(sampler{1D[Array],2D[Array],Cube[Array]}Shadow sampler);\n\n" },
	\ { 'kind': 'f',	'word': 'textureSamples(',
	\					'abbr': 'textureSamples',
	\					'info': "\/\/ Get the number of samples per texel for a texture.\n" .
	\							"\/\/ param[in] sampler: The sampler to which the texture is bound.\n".
	\							"int textureSamples(gsampler2DMS sampler);\n".
	\							"int textureSamples(gsampler2DMSArray sampler);\n\n" },
	\ { 'kind': 'f',	'word': 'textureSize(',
	\					'abbr': 'textureSize',
	\					'info': "\/\/ \n" .
	\							"textureSize();\n\n" },
	\ { 'kind': 'f',	'word': 'transpose(',
	\					'abbr': 'transpose',
	\					'info': "\/\/ Calculate the transpose of a matrix.\n" .
	\							"\/\/ param[in] m: The matrix to transpose.\n".
	\							"\/\/ returns   A matrix representing m transposed.\n".
	\							"mat2    transpose(mat2    m);\n".
	\							"mat3    transpose(mat3    m);\n".
	\							"mat4    transpose(mat4    m);\n".
	\							"mat2x3  transpose(mat3x2  m);\n".
	\							"mat2x4  transpose(mat4x2  m);\n".
	\							"mat3x2  transpose(mat2x3  m);\n".
	\							"mat3x4  transpose(mat4x3  m);\n".
	\							"mat4x2  transpose(mat2x4  m);\n".
	\							"mat4x3  transpose(mat3x4  m);\n".
	\							"dmat2   transpose(dmat2   m);\n".
	\							"dmat3   transpose(dmat3   m);\n".
	\							"dmat4   transpose(dmat4   m);\n".
	\							"dmat2x3 transpose(dmat3x2 m);\n".
	\							"dmat2x4 transpose(dmat4x2 m);\n".
	\							"dmat3x2 transpose(dmat2x3 m);\n".
	\							"dmat3x4 transpose(dmat4x3 m);\n".
	\							"dmat4x2 transpose(dmat2x4 m);\n".
	\							"dmat4x3 transpose(dmat3x4 m);\n\n" },
	\ { 'kind': 'f',	'word': 'trunc(',
	\					'abbr': 'trunc',
	\					'info': "\/\/ Truncate x to an integer.\n".
	\							"\/\/ param[in] x: The value to truncate.\n".
	\							"\/\/ returns   The integer i, such that abs(i) <= abs(x).\n" .
	\							"genType  trunc(genType  x);" .
	\							"genDType trunc(genDType x);\n\n" },
	\ { 'kind': 'f',	'word': 'uaddCarry(',
	\					'abbr': 'uaddCarry',
	\					'info': "\/\/ \n" .
	\							"uaddCarry();\n\n" },
	\ { 'kind': 'f',	'word': 'uintBitsToFloat(',
	\					'abbr': 'uintBitsToFloat',
	\					'info': "\/\/ Decode a floating point value from an unsigned integer. The result is\n".
	\							"\/\/ undefined if x encodes NaN.\n".
	\							"\/\/ param[in] x: The unsigned integer containing the encoded floating point\n".
	\							"\/\/              value.\n".
	\							"\/\/ returns   A floating point decoded from x.\n".
	\							"genType uintBitsToFloat(genUType x);\n\n" },
	\ { 'kind': 'f',	'word': 'umulExtended(',
	\					'abbr': 'umulExtended',
	\					'info': "\/\/ \n" .
	\							"umulExtended();\n\n" },
	\ { 'kind': 'f',	'word': 'unpackDouble2x32(',
	\					'abbr': 'unpackDouble2x32',
	\					'info': "\/\/ Unpack 2 unsigned integers from a double precision value. The first\n".
	\							"\/\/ component returned contains the 32 LSBs of d. The second component returned\n".
	\							"\/\/ contains the 32 MSBs of d.\n".
	\							"\/\/ param[in] d: The double from which to unpack the unsigned integers.\n".
	\							"\/\/ returns   The 2 unsigned integers unpacked from d.\n".
	\							"uvec2 unpackDouble2x32(double d);\n\n" },
	\ { 'kind': 'f',	'word': 'unpackHalf2x16(',
	\					'abbr': 'unpackHalf2x16',
	\					'info': "\/\/ Unpack two 16-bit floating point values from a 32-bit unsigned integer. The\n" .
	\							"\/\/ two floating point values are then converted to 32-bit values. The first\n".
	\							"\/\/ value is unpacked from the 16 LSBs, and the second value is unpacked from\n".
	\							"\/\/ the 16 MDBs.\n".
	\							"\/\/ param[in] v: The integer containing the packed floating point values.\n".
	\							"\/\/ returns   The two floating point values in the components of a vector.\n".
	\							"vec2 unpackHalf2x16(uint v);\n\n" },
	\ { 'kind': 'f',	'word': 'unpackSnorm2x16(',
	\					'abbr': 'unpackSnorm2x16',
	\					'info': "\/\/ Unpack 2 floating point values from a signed integer. The first floating\n".
	\							"\/\/ point value, f1, is extracted from the 16 LSBs. The second floating point\n".
	\							"\/\/ value, f2, is extracted from the 16 MSBs.\n" .
	\							"\/\/ param[in] p: The integer containing the floating point data.\n".
	\							"\/\/ returns   clamp(vec2(f1, f2) / 32727.0, -1.0, 1.0);\n" .
	\							"vec2 unpackSnorm2x16(uint p);\n\n" },
	\ { 'kind': 'f',	'word': 'unpackSnorm4x8(',
	\					'abbr': 'unpackSnorm4x8',
	\					'info': "\/\/ Unpack 4 floating point values from a signed integer. The first floating\n".
	\							"\/\/ point value, f1, is extracted from the 8 LSBs. The fourth floating point\n".
	\							"\/\/ value, f4, is extracted from the 8 MSBs. The second & third values, f2 &\n".
	\							"\/\/ f3, are extracted from the corresponding bits.\n" .
	\							"\/\/ param[in] p: The integer containing the packed floating point data.\n" .
	\							"\/\/ returns   clamp(vec4(f1, f2, f3, f4) / 127.0, -1.0, 1.0);\n" .
	\							"vec4 unpackSnorm4x8(uint p);\n\n" },
	\ { 'kind': 'f',	'word': 'unpackUnorm2x16(',
	\					'abbr': 'unpackUnorm2x16',
	\					'info': "\/\/ Unpack 2 floating point values from an unsigned integer. The first floating\n".
	\							"\/\/ point value, f1, is extracted from the 16 LSBs. The second floating point\n".
	\							"\/\/ value, f2, is extracted from the 16 MSBs.\n" .
	\							"\/\/ param[in] p: The integer containing the floating point data.\n".
	\							"\/\/ returns   clamp(vec2(f1, f2) / 65536.0, -1.0, 1.0);\n" .
	\							"vec2 unpackUnorm2x16(uint p);\n\n" },
	\ { 'kind': 'f',	'word': 'unpackUnorm4x8(',
	\					'abbr': 'unpackUnorm4x8',
	\					'info': "\/\/ Unpack 4 floating point values from an unsigned integer. The first floating\n".
	\							"\/\/ point value, f1, is extracted from the 8 LSBs. The fourth floating point\n".
	\							"\/\/ value, f4, is extracted from the 8 MSBs. The second & third values, f2 &\n".
	\							"\/\/ f3, are extracted from the corresponding bits.\n" .
	\							"\/\/ param[in] p: The integer containing the packed floating point data.\n" .
	\							"\/\/ returns   vec4(f1, f2, f3, f4) / 255.0;\n" .
	\							"vec4 unpackUnorm4x8(uint p);\n\n" },
	\ { 'kind': 'f',	'word': 'usubBorrow(',
	\					'abbr': 'usubBorrow',
	\					'info': "\/\/ \n" .
	\							"usubBorrow();\n\n" },
	\ { 'kind': 'f',	'word': 'contained(',
	\					'abbr': 'contained',
	\					'info': "\/\/ \n" .
	\							"contained();\n\n" },
	\ ]
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

