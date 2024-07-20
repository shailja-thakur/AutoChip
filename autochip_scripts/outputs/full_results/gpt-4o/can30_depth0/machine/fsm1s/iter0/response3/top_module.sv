module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;
	reg state, next_state;

	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = A; // Default case to handle any invalid state
		endcase
	end

	// Sequential logic to update the state on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state is B
		else
			state <= next_state;
	end

	// Output logic
	always @(state) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
		end
endmodule
