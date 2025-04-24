shader_type canvas_item;

uniform float AMPLITUDE : hint_range(0.0, 100.0); // Amplitude of the waves
uniform float FREQUENCY : hint_range(0.0, 10.0); // Frequency of the waves
uniform float DISTORTION_AMOUNT : hint_range(0.0, 100.0); // Amount of distortion
uniform float DISTORTION_SPEED : hint_range(0.0, 10.0); // Speed of distortion


void vertex() {
    // Calculate the vertical displacement of the vertex based on time, position, and additional distortion
    float distortion = sin(VERTEX.x * DISTORTION_SPEED + TIME) * DISTORTION_AMOUNT;
    float displacement = sin(VERTEX.x * FREQUENCY + TIME) * AMPLITUDE + distortion;

    // Apply the displacement to the y-coordinate of the vertex position
    VERTEX.y += displacement;
}

void fragment() {

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
