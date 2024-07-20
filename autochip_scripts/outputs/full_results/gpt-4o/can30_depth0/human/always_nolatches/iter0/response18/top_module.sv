module top_module (
	input [15:0] scancode,
	output reg left,
	output reg down,
	output reg right,
	output reg up
);

	always @(*) begin
		// Initialize all outputs to 0 (none)
		left = 0;
		down = 0;
		right = 0;
		up = 0;
		
		// Determine which arrow key was pressed
		case (scancode)
			16'he06b: left  = 1; // Left arrow
			16'he072: down  = 1; // Down arrow
			16'he074: right = 1; // Right arrow
			16'he075: up    = 1; // Up arrow
			default: begin
				left  = 0;
				down  = 0;
				right = 0;
				up    = 0;
			end
		endcase
	end
endmodule
