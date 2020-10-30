Shader "Unlit/orb"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (0,1,0,0.3)

        _Outline("Outline", Float) = 0.07
        _OutlineColor("Outline Color", Color) = (1,1, 1, 0.5)

        _Glow ("intensity", range(0,3)) = 1

     

    }
        SubShader
        {
            Tags { "Queue" = "Transparent"
                "RenderType" = "Transparent" }


            Pass
            {

                Blend SrcAlpha OneMinusSrcAlpha
                
                Cull Front
               //ZWrite off
               //ZTest Less
                

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                struct appdata
                {
                    float4 vertex : POSITION;
                    float4 uv : TEXCOORD0;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    float4 uv : TEXCOORD0;
                };

                half4 _OutlineColor;
                half _Outline;
                half _Glow;


                float4 outliner(float4 pos, float outline) {
                    float4x4 scale = 0.0;
                    scale[0][0] = 1.0 + outline *  3 * sin(_Time.y*2) + 0.02 + (sin(_Time.y * 1.5) / 9);
                    scale[1][1] = 1.0 + outline * 3 * sin(_Time.y*2) + 0.02 + (sin(_Time.y * 5) / 9);
                    scale[2][2] = 1.0 + outline * 3 * sin(_Time.y*2) + 0.02 + (sin(_Time.y * 2) / 9);
                    scale[3][3] = 1.0;
                    return mul(scale, pos);
                }

               

               
                v2f vert(appdata v)
                {
                    v2f o;

                    /*v.vertex = VertexAnimFlag(v.vertex, v.uv.x, 5, 0.8, 0.03);*/
                    
                    o.vertex = UnityObjectToClipPos(outliner(v.vertex, _Outline));
                    o.uv = v.uv;
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {

                    float4 col = float4(0.2,(sin(_Time.y) / 20)+0.1,0.2,(sin(_Time.y*2)/30));
                    col *= _Glow;
                    return _OutlineColor * col;
                }
                ENDCG
            }


            

            Pass
            {

                Blend SrcAlpha OneMinusSrcAlpha

                Cull Front
                    //ZWrite off
                    //ZTest Less


                     CGPROGRAM
                     #pragma vertex vert
                     #pragma fragment frag

                     struct appdata
                     {
                         float4 vertex : POSITION;
                         float4 uv : TEXCOORD0;
                     };

                     struct v2f
                     {
                         float4 vertex : SV_POSITION;
                         float4 uv : TEXCOORD0;
                     };

                     half4 _OutlineColor;
                     half _Outline;
                     half _Glow;


                     float4 outliner(float4 pos, float outline) {
                         float4x4 scale = 0.0;
                         scale[0][0] = 1.0 + outline + 0.02 + (sin(_Time.y * 1.2) / 12);
                         scale[1][1] = 1.0 + outline + 0.02 + (sin(_Time.y * 0.3) / 12);
                         scale[2][2] = 1.0 + outline + 0.02 + (sin(_Time.y * 0.5) / 12);
                         scale[3][3] = 1.0;
                         return mul(scale, pos);
                     }

                     float4 scaler(float4 pos) {
                         float4x4 scale = 0.0;
                         scale[0][0] = 0.3 + (sin(_Time.y * 1.2) / 12);
                         scale[1][1] = 0.3 + (sin(_Time.y * 0.3) / 12);
                         scale[2][2] = 0.3 + (sin(_Time.y * 0.5) / 12);
                         scale[3][3] = 1.0;
                         return mul(scale, pos);
                     }

                     
                    
                     v2f vert(appdata v)
                     {
                         v2f o;

                         /*v.vertex = VertexAnimFlag(v.vertex, v.uv.x, 5, 0.8, 0.03);*/

                         o.vertex = UnityObjectToClipPos(scaler(outliner(v.vertex, 0.07)));
                         o.uv = v.uv;
                         return o;
                     }

                     fixed4 frag(v2f i) : SV_Target
                     {

                         

                         float4 col = float4(1,1,1,  (sin(_Time.y * 2) / 7) + 0.1  );
                         col *= _Glow;
                         return _OutlineColor * col;
                     }
                     ENDCG
                 }
            // Pass
            //{
            //   

            //    Blend SrcAlpha OneMinusSrcAlpha

            //    Cull Front
            //        //ZWrite off
            //        //ZTest Less


            //         CGPROGRAM
            //         #pragma vertex vert
            //         #pragma fragment frag

            //         struct appdata
            //         {
            //             float4 vertex : POSITION;
            //         };

            //         struct v2f
            //         {
            //             float4 vertex : SV_POSITION;
            //         };

            //         half4 _OutlineColor;
            //         half _Outline;


            //         float4 outliner(float4 pos, float outline) {
            //             float4x4 scale = 0.0;
            //             scale[0][0] = 1.0 + outline + 0.02 + (sin(_Time.y * 1.2) / 18);
            //             scale[1][1] = 1.0 + outline + 0.02 + (sin(_Time.y * 1.2) / 18);
            //             scale[2][2] = 1.0 + outline + 0.02 + (sin(_Time.y * 1.2) / 18);
            //             scale[3][3] = 1.0;
            //             return mul(scale, pos);
            //         }



            //         v2f vert(appdata v)
            //         {
            //             v2f o;
            //             o.vertex = UnityObjectToClipPos(outliner(v.vertex, 0.05));
            //             return o;
            //         }

            //         fixed4 frag(v2f i) : SV_Target
            //         {
            //             float4 col = float4(0.0,0.4,0.3,0.1);
            //             return _OutlineColor * col;
            //         }
            //         ENDCG
            //     }


        
            
             Pass
            {

                //Blend DstColor Zero
                 Blend SrcAlpha OneMinusSrcAlpha

                 Cull Front
              
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"

               

                float4 _Color;
                float4 MainTex_ST;
                half _Glow;

          

                struct appdata
                {
                    float4 vertex : POSITION;
          

                    float4 uv : TEXCOORD0;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    float4 uv : TEXCOORD0;

                

                };
                
               

                /*float4 VertexAnimFlag(float4 VertPos, float2 uv, float4 Frequency, float4 speed, float4 Ampli) {
                    VertPos.z = VertPos.z + sin((uv.x - _Time.y * speed) * Frequency) * Ampli;
                    return VertPos;

                }*/



                float4 scaler(float4 pos) {
                    float4x4 scale = 0.0;
                    scale[0][0] =  0.2 + (sin(_Time.y * 1.2) / 12);
                    scale[1][1] =  0.2 + (sin(_Time.y * 0.3) / 12);
                    scale[2][2] =  0.2 + (sin(_Time.y * 0.5) / 12);
                    scale[3][3] = 1.0;
                    return mul(scale, pos);
                }


                float rand(float3 i) {
                    return frac(sin(i.x + i.y + i.z ) * 800000 * sin(_Time.y)/2);
                }

                v2f vert(appdata v)
                {
                    v2f o;

                   // v.vertex = VertexAnimFlag(v.vertex, v.uv, 1, 0.8, 0.03);

                    
                    o.vertex = UnityObjectToClipPos(scaler(v.vertex));
                    o.uv = (v.uv * MainTex_ST + MainTex_ST);

                   
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    //float4 col = float4((sin(i.vertex.x + _Time.y) + 0.5) / 2, (sin(i.vertex.y+ _Time.y) + 0.5) / 2, (sin(i.vertex.z + _Time.y) + 0.5) / 2, 0.3);
                    float c = rand(i.vertex*0.03);
                    
                    
                    float4 col = float4 (c,c,c, (sin(_Time.y * 2) / 8) + 0.5 ) - float4(0.2, 0.2, 0.2,0);
                    col *= 2* _Glow;
                    return col + float4(0 , 0, (sin(_Time.y *7) / 4)+0.25, 0);
                }
                ENDCG
            }


                // Pass
                //{

                //    //Blend DstColor Zero
                //     Blend SrcAlpha OneMinusSrcAlpha



                //    CGPROGRAM
                //    #pragma vertex vert
                //    #pragma fragment frag

                //    #include "UnityCG.cginc"



                //    float4 _Color;
                //    float4 MainTex_ST;



                //    struct appdata
                //    {
                //        float4 vertex : POSITION;


                //        float4 uv : TEXCOORD0;
                //    };

                //    struct v2f
                //    {
                //        float4 vertex : SV_POSITION;
                //        float4 uv : TEXCOORD0;



                //    };



                //    /*float4 VertexAnimFlag(float4 VertPos, float2 uv, float4 Frequency, float4 speed, float4 Ampli) {
                //        VertPos.z = VertPos.z + sin((uv.x - _Time.y * speed) * Frequency) * Ampli;
                //        return VertPos;

                //    }*/



                //    float4 scaler(float4 pos) {
                //        float4x4 scale = 0.0;
                //        scale[0][0] = sin(_Time.y) + 0.02 + (sin(_Time.y * 3) / 8);
                //        scale[1][1] = sin(_Time.y) + 0.02 + (sin(_Time.y * 5) / 8);
                //        scale[2][2] = sin(_Time.y) + 0.02 + (sin(_Time.y * 1.2) / 8);
                //        scale[3][3] = 1.0;
                //        return mul(scale, pos);
                //    }


                //    float rand(float3 i) {
                //        return frac(sin(i.x + i.y + i.z) * 100 * sin(_Time.y) / 2);
                //    }

                //    v2f vert(appdata v)
                //    {
                //        v2f o;

                //      
                //         o.vertex = UnityObjectToClipPos(scaler(v.vertex));
                //         o.uv = (v.uv * MainTex_ST + MainTex_ST);


                //         return o;
                //     }

                //     fixed4 frag(v2f i) : SV_Target
                //     {
                //                                
                //         return float4(0 , 0, (sin(_Time.y * 7) / 4) + 0.25, 0);
                //     }
                //     ENDCG
                //}
            


        }
    
}
