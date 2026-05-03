Shader "Unlit/InverseShiny"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScanSpeed ("Scan Speed", Float) = 1.0
        _LineWidth ("Line Width", Float) = 0.05
        _Tint ("Tint", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
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
            float _ScanSpeed;
            float _LineWidth;
            fixed4 _Tint;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

                // invert stuff
                fixed4 invCol = fixed4(1.0 - col.rgb, col.a);

                // scan line adjusted to overshoot and not cut suddenly
                float scanPos = (frac(_Time.y * _ScanSpeed) - 0.5) * 3;

                // up down scanline with feathering
                float dist = abs(i.uv.y - scanPos);
                float insideLine = 1.0 - smoothstep(0.0, _LineWidth, dist);

                // apply tint and original color to what's in the scan line
                fixed4 lineTint = col * _Tint;
                fixed4 finalCol = lerp(invCol, lineTint, insideLine);

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, finalCol);
                return finalCol;
            }
            ENDCG
        }
    }
}
