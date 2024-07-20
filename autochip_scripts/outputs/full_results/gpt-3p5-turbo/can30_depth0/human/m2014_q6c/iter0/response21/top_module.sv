module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Define the next-state variables
	reg [5:0] next_state_y2;
	reg [5:0] next_state_y4;
	
	// Assign the next-state values based on the current state and input
	always @(*) begin
		case(y)
			6'b000001: begin	// State A
				next_state_y2 = 6'b000100;	// B
				next_state_y4 = 6'b001000;	// D
			end
			6'b000010: begin	// State B
				next_state_y2 = 6'b000000;	// A
				next_state_y4 = 6'b001000;	// D
			end
			6'b000100: begin	// State C
				next_state_y2 = 6'b000000;	// A
				next_state_y4 = 6'b010000;	// F
			end
			6'b001000: begin	// State D
				next_state_y2 = 6'b000100;	// B
				next_state_y4 = 6'b010000;	// F
			end
			6'b010000: begin	// State E
				next_state_y2 = 6'b000100;	// B
				next_state_y4 = 6'b001000;	// D
			end
			6'b100000: begin	// State F
				next_state_y2 = 6'b000000;	// A
				next_state_y4 = 6'b010000;	// F
			end
		endcase
	end
	
	// Assign the outputs based on the next-state values
	assign Y2 = next_state_y2[2];
	assign Y4 = next_state_y4[4];
	
endmodule
