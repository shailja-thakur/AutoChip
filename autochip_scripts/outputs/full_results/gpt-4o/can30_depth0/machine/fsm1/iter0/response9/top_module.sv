module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg state, next_state;

	parameter A = 1'b0, B = 1'b1;

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B; // Default state
		endcase
	end

	// State register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end
endmodule
