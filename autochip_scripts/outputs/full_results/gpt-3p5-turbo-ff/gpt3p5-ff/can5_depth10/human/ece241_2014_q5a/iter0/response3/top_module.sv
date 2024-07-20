module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define states
	typedef enum logic[2:0] {
		S0,	// Initial state
		S1	// Complementing state
	} state_t;

	// Define state register
	reg [2:0] state_reg;

	// Define output register
	reg z_reg;

	// Define next state and output logic
	always_ff @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state_reg <= S0;
			z_reg <= 0;
		end else if (state_reg == S0) begin
			state_reg <= S1;
			z_reg <= ~x;
		end else begin
			state_reg <= S0;
			z_reg <= z_reg;
		end
	end

	// Assign output to output register
	assign z = z_reg;

endmodule
