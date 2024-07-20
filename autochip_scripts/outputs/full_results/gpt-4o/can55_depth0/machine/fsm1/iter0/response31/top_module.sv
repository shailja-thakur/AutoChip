module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	reg state, next_state;
	parameter A = 1'b0, B = 1'b1;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;  // Reset to state B
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B;
		endcase
	end

	// Output logic
	always @(*) begin
		out = (state == B);
	end

endmodule
