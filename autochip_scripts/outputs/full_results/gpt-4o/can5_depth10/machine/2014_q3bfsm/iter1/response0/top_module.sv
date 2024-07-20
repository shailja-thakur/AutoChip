module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	// State encoding
	parameter A = 3'd0;
	parameter B = 3'd1;
	parameter C = 3'd2;
	parameter D = 3'd3;
	parameter E = 3'd4;

	// State transition logic
	always @(*) begin
		case(state)
			A: if (x) next_state = B; else next_state = A;
			B: if (x) next_state = E; else next_state = B;
			C: if (x) next_state = B; else next_state = C;
			D: if (x) next_state = C; else next_state = B;
			E: if (x) next_state = E; else next_state = D;
			default: next_state = A;
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A;   // Initialize state to A
		else 
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 0;
		else
			case (state)
				D, E: z <= 1;
				default: z <= 0;
			endcase
	end

endmodule
