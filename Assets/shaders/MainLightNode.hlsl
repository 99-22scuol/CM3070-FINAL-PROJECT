void GetMainLightData_float(float3 WorldPos, out half3 direction, out half3 color, out half distanceAttenuation, out half shadowAttenuation)
{
#if SHADERGRAPH_PREVIEW
        // In Shader Graph Preview we will assume a default light direction and white color
        direction = half3(0.5, 0.5, 0);
        color = 1;
        distanceAttenuation = 1;
        shadowAttenuation = 1;
#else    
#if SHADOWS_SCREEN
    half4 clipPos = TransformWorldToHClip(WorldPos);
    half4 shadowCoord = CommputeScreenPos(clipPos);
#else
    half4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
#endif
        // GetMainLight defined in Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl
        Light mainLight = GetMainLight();
        direction = -mainLight.direction;
        color = mainLight.color;
        distanceAttenuation = mainLight.distanceAttenuation;
        shadowAttenuation = mainLight.shadowAttenuation;

#endif
}

