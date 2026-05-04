# Rendering and Shaders Final
Ken's super cool Readme

## Scenes

### Vertex And Fragment
- Contains Vertex and Fragment Shader samples
- Vertex Shader:
  - Flag Shader
  - Best used on a plane or similar geometry with many vertices
  - Using sin, time, and uv.x to determine the wave
  - uv.x used so 0 (left side) keeps the pole side still, and flag gets more of the effect at the opposite end (1 of the uv)
  - Basic Params (Wave Amplitude Horizontal, Wave Frequency Horizontal, MainTex, Wave Frequency Vertical, Wave Amplitude Vertical)
- Fragment Shader:
  - Inverse Shiny
  - Use on any object and assign a texture
  - Colors are inverted
  - Scanline goes through with time, ScanSpeed, frac, and some hardcoded to avoid hard snapping at start and end
  - Everything in the scanline uses the original color multiplied by the Tint
  - Params: ScanSpeed, LineWidth, Tint

### Russian Nightclub
- Scene to display Postprocessing effects
- All objects are static, receiving and contributing GI, set to light probes setting
- spotlights set to baked
- adaptive probe volume set to fit scene
- Local Volume used with custom Volume Profile
- Volume Profile:
  - Bloom
  - Lens Distortion
  - Vignette
  - Screen Space Lens Flare

### Item And Environment Shader
- Scene to display Item Highlight Shader and Ice Shader
- Item Highlight Shader
  - Made with Shader Graph
  - Multiplies vertex position to get outline width
  - only renders back face so item appears infront
  - Apply as additional material to an object, not as a singular material
  - Pulse Speed for periodic pulse
  - Apply Color to get different outline color
  - Params: Outline Scale, Color, PulseSpeed
- Ice Shader
  - Made with Shader Graph
  - Uses simple noise, step, and multiply by color to get a hard frost effect
  - Multiply hard frost and color to get color
  - Multiply hard frost and fresnel to get opacity
  - Creates transparent ice with some parts "more frosted" than other parts
  - Params: Color, Fresnel Intensity, Frost Edge, Noise

### Five Nights at Stonehead's
- Creative Shader and Rendering Display
- Shaders made and used:
  - Glass Shader: Basic Transparent shader, Shader Graph, just alters smoothenss and transparency
  - Screen Shader:
    - Shader Graph
    - Dither and Fresnel used for basic pixelly screen effect
    - Intensity param for screen brightness
    - Scanline to imitate rendering the screen
    - Params: Color, Fresnel Power, Emission Intensity, Scanline Speed, Scan Tint, Scanline Width
  - Recording Dot:
    - Screenspace Shader, ShaderGraph
    - Elipse, Color, and Dither to get digital recording dot image
    - Params: Fresnel Intensity, Color
  - Camera Square:
    - Outline Square made with Shader Graph
- Lights all baked
- Statics and spotlights casting shadows
- Custom Post Processing Volume using following settings:
  - Bloom
  - Vignette
  - Lens Distortion
  - Film Grain
  - Chromatic Aberration
  - Panini Projection
- Achieves Security Camera Effect

