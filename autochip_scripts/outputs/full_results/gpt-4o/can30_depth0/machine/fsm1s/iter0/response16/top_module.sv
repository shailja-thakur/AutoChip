module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	localparam A = 1'b0, B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic for next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A; // Default case to handle unexpected values
		endcase
	end

	// Sequential logic for state update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B; // Reset state
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end
endmodule
