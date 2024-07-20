module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	parameter B = 1'b0;
	parameter A = 1'b1;

	reg state, next_state;

	// Output assignment
	assign out = state;

	always @(posedge clk) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	always @* begin
		case(state)
			B: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end
endmodule
