module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	reg [1:0] state, next_state;
	localparam A = 2'b00,
				  B = 2'b01,
				  C = 2'b10,
				  D = 2'b11;

	// State transition logic
	always @(*) begin
		case(state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(*) begin
		case(state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

endmodule
