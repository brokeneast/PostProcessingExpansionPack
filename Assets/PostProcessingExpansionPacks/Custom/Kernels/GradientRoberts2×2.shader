Shader "Hidden/Custom/GradientRoberts2x2"
{
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
            
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
            float4 _MainTex_TexelSize;
            
            v2f Vert(AttributesDefault v)
            {
                v2f o;
                o.vertex = float4(v.vertex.xy, 0.0, 1.0);
                o.texcoord = TransformTriangleVertexToUV(v.vertex.xy);

            #if UNITY_UV_STARTS_AT_TOP
                o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
            #endif

                return o;
            }
            
            float4 Frag(v2f i) : SV_Target
            {
                //kernel
                
                //Gx = [-1 0]
                //     [ 0 1]
                
                //Gy = [0 -1]
                //     [1  0]
                
                //G = |Gx| + |Gy| or sqrt(Gx^2 + Gy^2)
                
                float4 colorX;
                colorX  = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord + _MainTex_TexelSize * float2(-0.5,  0.5)) * -1;
                colorX += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord + _MainTex_TexelSize * float2( 0.5, -0.5));
                
                float4 colorY;
                colorY  = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord + _MainTex_TexelSize * float2(-0.5, -0.5));
                colorY += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord + _MainTex_TexelSize * float2( 0.5,  0.5)) * -1;
                
                return abs(colorX) + abs(colorY);
            }
            ENDHLSL
        }
    }
}
