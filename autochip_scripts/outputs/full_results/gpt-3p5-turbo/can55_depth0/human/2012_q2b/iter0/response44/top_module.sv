module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Define the state flip-flops
	reg [5:0] state_ff;
	
	// Define the next state logic
	always @(posedge w)
		case (state_ff)
			6'b000001: state_ff <= 6'b000100; // A -> C
			6'b000010: state_ff <= 6'b000001; // B -> A
			6'b000100: state_ff <= 6'b010000; // C -> E
			6'b001000: state_ff <= 6'b100000; // D -> F
			6'b010000: state_ff <= 6'b010000; // E -> E
			6'b100000: state_ff <= 6'b000100; // F -> C
			default: state_ff <= 6'b000001; // Default should be A
		endcase
	
	// Define the output signals
	assign Y1 = state_ff[1];
	assign Y3 = state_ff[3];
	
endmodule
