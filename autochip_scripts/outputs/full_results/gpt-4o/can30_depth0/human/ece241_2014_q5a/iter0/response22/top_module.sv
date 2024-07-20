module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State enumeration
	parameter S0 = 1'b0, S1 = 1'b1;
	reg state, next_state;

	// Sequential logic for state transitions
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	// Combinational logic for next state and output
	always @(*) begin
		case (state)
			S0: begin
				// State S0: Directly complement the input bit
				z = x;
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				// State S1: Complement the input bit and add 1
				z = ~x;
				next_state = S1;
			end
		endcase
	end
endmodule
