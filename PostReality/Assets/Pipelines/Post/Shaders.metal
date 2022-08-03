typedef struct {
    float4 color; // color
} PostUniforms;

fragment float4 postFragment(VertexData in [[stage_in]],
                              constant PostUniforms &uniforms [[buffer(FragmentBufferMaterialUniforms)]],
                              texture2d<float, access::sample> renderTex [[texture(FragmentTextureCustom0)]]) {
    constexpr sampler s = sampler(min_filter::linear, mag_filter::linear);
    return uniforms.color * renderTex.sample(s, in.uv);
}
