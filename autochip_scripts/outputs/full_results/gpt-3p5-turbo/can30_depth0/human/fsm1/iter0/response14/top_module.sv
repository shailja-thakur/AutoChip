module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		B,
		A
	} state_t;

	// Define state register
	state_t state_reg;

	always_ff @(posedge clk or posedge areset)
	begin
		// Asynchronous reset
		if (areset)
			state_reg <= B;
		else
		begin
			// State transition logic
			case (state_reg)
				B: if (in) state_reg <= B; else state_reg <= A;
				A: if (in) state_reg <= A; else state_reg <= B;
				default: state_reg <= B;
			endcase
		end
	end

	// Output logic
	assign out = (state_reg == A);

endmodule
