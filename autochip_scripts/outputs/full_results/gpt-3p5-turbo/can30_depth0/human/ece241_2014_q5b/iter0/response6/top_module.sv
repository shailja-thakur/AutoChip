module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	parameter A = 1'b1;
	parameter B = 1'b10;

	reg current_state, next_state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Assign next state
	always @(current_state, x) begin
		case (current_state)
			A: begin
				if (x == 1'b1)
					next_state = B;
				else
					next_state = A;
				z = x;
			end

			B: begin
				if (x == 1'b1)
					next_state = A;
				else
					next_state = B;
				z = ~x;
			end
		endcase
	end

endmodule
