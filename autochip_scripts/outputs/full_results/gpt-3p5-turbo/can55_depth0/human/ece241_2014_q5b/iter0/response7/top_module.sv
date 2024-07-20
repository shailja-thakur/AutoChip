module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state, next_state;

	// State definitions
	parameter A = 2'b00;
	parameter B = 2'b01;

	// Synchronous always_ff block for state register
	always_ff @(posedge clk or negedge areset) begin
		if (areset == 0)
			state <= A;
		else
			state <= next_state;
	end

	// Combinational always_comb block for next state logic
	always_comb begin
		case(state)
			A: begin
				if (x == 1'b0)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (x == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = A;
		endcase
	end

	// Output assignment
	assign z = (state == B) ? 1'b1 : 1'b0;

endmodule
