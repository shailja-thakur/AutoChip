module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State encoding
	reg [2:0] state, next_state;
	localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;
	
	// State transitions
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A; // Initialize to state A on reset
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = x ? B : A;
			B: next_state = x ? E : B;
			C: next_state = x ? B : C;
			D: next_state = x ? C : B;
			E: next_state = x ? E : D;
			default: next_state = A; // Default to A to handle undefined states
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			D, E: z = 1;
			default: z = 0;
		endcase
	end

endmodule
