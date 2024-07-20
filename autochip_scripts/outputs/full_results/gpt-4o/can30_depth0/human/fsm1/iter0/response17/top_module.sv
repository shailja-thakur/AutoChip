module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B : if (in) next_state = B;
			    else next_state = A;
			A : if (in) next_state = A;
			    else next_state = B;
			default: next_state = B;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b1;
		endcase
	end

endmodule
