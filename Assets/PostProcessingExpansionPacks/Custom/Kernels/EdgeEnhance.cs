using System;

namespace UnityEngine.Rendering.PostProcessing
{
    [Serializable]
    [PostProcess(typeof(EdgeEnhanceRenderer), PostProcessEvent.AfterStack, "Custom/Kernels/EdgeEnhance")]
    public sealed class EdgeEnhance : PostProcessEffectSettings
    {
        
    }

    internal sealed class EdgeEnhanceRenderer : PostProcessEffectRenderer<EdgeEnhance>
    {
        public override void Render(PostProcessRenderContext context)
        {
            var sheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/EdgeEnhance"));
            
            
            
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}
