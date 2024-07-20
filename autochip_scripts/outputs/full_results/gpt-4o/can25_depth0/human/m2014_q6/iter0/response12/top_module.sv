module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define the state encoding using `localparam`
	localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

	// State and next state variables
	reg [2:0] state, next_state;

	// State registers with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A;
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: if (w) next_state = A; else next_state = B;
			B: if (w) next_state = D; else next_state = C;
			C: if (w) next_state = D; else next_state = E;
			D: if (w) next_state = A; else next_state = F;
			E: if (w) next_state = D; else next_state = E;
			F: if (w) next_state = D; else next_state = C;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			z <= 1'b0;
		else 
			case (state)
				E, F: z <= 1'b1;
				default: z <= 1'b0;
			endcase
	end

endmodule
