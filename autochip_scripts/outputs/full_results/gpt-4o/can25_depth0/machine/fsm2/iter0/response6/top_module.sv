module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state encoding
	localparam A = 1'b0, B = 1'b1;

	// State registers
	reg state, next_state;

	// Combinational always block to determine next state
	always @(*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;
		endcase
	end

	// Clocked always block to update current state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == B)
			out = 1;
		else
			out = 0;
		end
endmodule
