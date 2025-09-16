//TEST:SIMPLE(filecheck=METAL): -stage compute -entry computeMain -target metal
//TEST:REFLECTION(filecheck=REFLECT): -stage compute -entry computeMain  -target metal
//TEST:SIMPLE(filecheck=METALASM): -stage compute -entry computeMain -target metallib
//TEST(compute, metal):COMPARE_COMPUTE(filecheck-buffer=BUF):-metal -compute -entry computeMain -output-using-type

//TEST_INPUT: ubuffer(data=[0 0 0 0], stride=4):out,name outBuffer
RWStructuredBuffer<float4> outBuffer;

// ------------------------
// TEST_INPUT: TextureSampler2D(size=4, content = one):name sampler
Sampler2D sampler;

// METAL-DAG: {{sampler_texture_[1-9]}} {{\[\[}}texture(0)]]
// METAL-DAG: {{sampler_sampler_[1-9]}} {{\[\[}}sampler(0)]]

// REFLECT: "name": "sampler"
// REFLECT-NOT:}
// REFLECT: {"kind": "shaderResource", "index": 0}
// REFLECT-NOT:}
// REFLECT: {"kind": "samplerState", "index": 0}

// ------------------------
// TEST_INPUT: Texture2D(size=4, content = zero):name followingTexture
Texture2D followingTexture;

// METAL-DAG: {{followingTexture_[1-9]}} {{\[\[}}texture(1)]]

// REFLECT: "name": "followingTexture"
// REFLECT-NOT:}
// REFLECT: "binding": {"kind": "shaderResource", "index": 1}

// ------------------------
//TEST_INPUT: Sampler(filteringMode=point):name followingSamplerState
SamplerState followingSamplerState;

// METAL-DAG: {{followingSamplerState_[1-9]}} {{\[\[}}sampler(1)]]

// REFLECT: "name": "followingSamplerState"
// REFLECT-NOT:}
// REFLECT: "binding": {"kind": "samplerState", "index": 1}

// ------------------------
// TEST_INPUT: TextureSampler2D(size=4, content = one):name explicitBindingSampler
Sampler2D explicitBindingSampler : register(t4): register(s3);

// METAL-DAG: {{explicitBindingSampler_texture_[1-9]}} {{\[\[}}texture(4)]]
// METAL-DAG: {{explicitBindingSampler_sampler_[1-9]}} {{\[\[}}sampler(3)]]

// REFLECT: "name": "explicitBindingSampler"
// REFLECT-NOT:}
// REFLECT: {"kind": "shaderResource", "index": 4}
// REFLECT-NOT:}
// REFLECT: {"kind": "samplerState", "index": 3}


[numthreads(1,1,1)]
float4 computeMain() : SV_Target
{
    float4 o = sampler.Sample(float2(0, 0)) + explicitBindingSampler.Sample(float2(0, 0)) + followingTexture.Sample(followingSamplerState, float2(0,0));
    outBuffer[0] =  o;
    return o;
}
