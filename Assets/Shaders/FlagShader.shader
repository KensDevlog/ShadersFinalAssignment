Shader "Unlit/FlagShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FlagSpeed ("Flag Speed", Float) = 2.0
        _WaveFrequency ("Wave Frequency Horizontal", Float) = 3.0
        _WaveFrequency2 ("Wave Frequency Vertical", Float) = 1.0
        _WaveAmplitude ("Wave Amplitude Horizontal", Float) = 0.1
        _WaveAmplitude2 ("WaveAmplitude Vertical", Float) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _FlagSpeed;
            float _WaveFrequency;
            float _WaveFrequency2;
            float _WaveAmplitude;
            float _WaveAmplitude2;

            v2f vert (appdata v)
            {
                v2f o;

                // left right wavy
                float wave1 = sin(v.uv.x * _WaveFrequency + _Time.y * _FlagSpeed)
                            * _WaveAmplitude
                            * v.uv.x;

                float wave2 = sin(v.uv.y * _WaveFrequency2 + _Time.y * _FlagSpeed)
                            * _WaveAmplitude2
                            * v.uv.x;

                v.vertex += wave1 + wave2;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
