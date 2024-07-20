module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A;
		endcase
	end

	// Sequential logic to update state on clk edge or reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;  // Reset state to B
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
