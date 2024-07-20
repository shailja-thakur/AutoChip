module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);


	// States
	enum logic [1:0] state, next_state;
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	// State register
	always_ff @(posedge clk, negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= next_state;
	end

	// State transitions
	always_comb begin
		case ({x, state})
			2'b00_S: next_state = S;
			2'b01_S: next_state = S1;
			2'b00_S1: next_state = S10;
			2'b01_S1: next_state = S1;
			2'b00_S10: next_state = S;
			2'b01_S10: next_state = S1;
			default: next_state = state;
		endcase
	end

	// Outputs
	always_comb begin
		case (state)
			S: z = 1'b0;
			S1: z = 1'b0;
			S10: z = x;
		endcase
	end

endmodule
