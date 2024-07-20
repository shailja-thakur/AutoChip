module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		S0,
		S1,
		S2
	} state_type;

	// Register to hold the current state
	reg[state_type] state_reg;

	// Next state logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state_reg <= S0;
		end else begin
			case (state_reg)
				S0: if (x == 1'b1) state_reg <= S1;
				S1: if (x == 1'b0) state_reg <= S2;
				S2: if (x == 1'b1) state_reg <= S0;
				default: state_reg <= S0;
			endcase
		end
	end
	
	// Output logic
	always_comb begin
		if (state_reg == S0 && x == 1'b1)
			z = 1'b0;
		else if (state_reg == S2)
			z = 1'b1;
		else
			z = 1'b0;
	end

endmodule
