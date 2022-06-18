// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33257,y:32250,varname:node_3138,prsc:2|emission-5777-OUT,olwid-1049-OUT,olcol-9878-OUT;n:type:ShaderForge.SFN_ScreenPos,id:4388,x:31626,y:31710,cmnt:此处不需要Remap,varname:node_4388,prsc:2,sctp:1;n:type:ShaderForge.SFN_Length,id:6931,x:32502,y:31920,cmnt:输出的是 向量幅度    接下来使用length节点计算每个地方的向量的长度把这个长度换成颜色看的话每一块区域自然成了小圆点,varname:node_6931,prsc:2|IN-1030-OUT;n:type:ShaderForge.SFN_RemapRange,id:1030,x:32312,y:31812,cmnt:这个区间映射到-0.5到0.5也就是把每一块的原点移到该块的中心,varname:node_1030,prsc:2,frmn:0,frmx:1,tomn:-0.5,tomx:0.5|IN-2592-OUT;n:type:ShaderForge.SFN_Frac,id:2592,x:32109,y:31752,cmnt:取小数,varname:node_2592,prsc:2|IN-8783-OUT;n:type:ShaderForge.SFN_Multiply,id:8783,x:31931,y:31682,cmnt:我们把屏幕uv乘了一个数也就是扩大了范围但是UV值超过1的话换算成颜色就还是1的颜色 所以看到渐变范围变小了纯色范围变大了,varname:node_8783,prsc:2|A-4388-UVOUT,B-6488-OUT;n:type:ShaderForge.SFN_Multiply,id:3487,x:31914,y:32619,cmnt:得到上面的纹理后我们加上之前的Lambert效果乘上光线衰减和投影,varname:node_3487,prsc:2|A-1405-OUT,B-7250-OUT;n:type:ShaderForge.SFN_Dot,id:1405,x:31609,y:32301,cmnt:兰伯特,varname:node_1405,prsc:2,dt:1|A-2901-OUT,B-5665-OUT;n:type:ShaderForge.SFN_NormalVector,id:5665,x:31432,y:32360,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:2901,x:31432,y:32213,varname:node_2901,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:7250,x:31603,y:32887,cmnt:光线衰减和投影,varname:node_7250,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:5136,x:32435,y:32620,cmnt:并且把节点会显示的部分也就是Lambert从0到1的值反向映射到2到-0.5也就是图里1-0变成-0.5-2,varname:node_5136,prsc:2,frmn:1,frmx:0,tomn:-0.5,tomx:2|IN-3487-OUT;n:type:ShaderForge.SFN_Power,id:5204,x:32720,y:32257,cmnt:圆点纹理作为底数Lambert作为指数来计算,varname:node_5204,prsc:2|VAL-6931-OUT,EXP-5136-OUT;n:type:ShaderForge.SFN_Vector1,id:1049,x:33018,y:33062,cmnt:描边大小,varname:node_1049,prsc:2,v1:0.02;n:type:ShaderForge.SFN_Round,id:5777,x:33037,y:32352,cmnt:四舍五入取整,varname:node_5777,prsc:2|IN-5204-OUT;n:type:ShaderForge.SFN_Vector3,id:9878,x:33032,y:33164,cmnt:描边颜色常数即可,varname:node_9878,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Slider,id:6488,x:31588,y:31960,ptovrint:False,ptlb:DotSize,ptin:_DotSize,varname:node_6488,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:100;proporder:6488;pass:END;sub:END;*/

Shader "AP01/L02/T03" {
    Properties {
        _DotSize ("DotSize", Range(1, 100)) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*0.02,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                return fixed4(float3(0,0,0),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _DotSize)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float _DotSize_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DotSize );
                float node_5777 = round(pow(length((frac((float2((sceneUVs.x * 2 - 1)*(_ScreenParams.r/_ScreenParams.g), sceneUVs.y * 2 - 1).rg*_DotSize_var))*1.0+-0.5)),((max(0,dot(lightDirection,i.normalDir))*attenuation)*-2.5+2.0))); // 四舍五入取整
                float3 emissive = float3(node_5777,node_5777,node_5777);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _DotSize)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
