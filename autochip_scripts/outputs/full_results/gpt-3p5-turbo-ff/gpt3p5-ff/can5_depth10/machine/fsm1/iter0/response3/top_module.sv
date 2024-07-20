module top_module (
	input wire clk,
	input wire in,
	input wire areset,
	output wire out
);

	// Define the state enum values
	typedef enum logic [1:0] {
		A,
		B
	} state_t;

	reg state_reg, next_state_reg;

	// Assign initial state
	always_ff @(posedge areset or posedge clk) begin
		if (areset)
			state_reg <= B;
		else
			state_reg <= next_state_reg;
	end

	// Define state transition logic
	always_comb begin
		case (state_reg)
			A: if (in)
					next_state_reg = A;
				else
					next_state_reg = B;
			B: if (in)
					next_state_reg = B;
				else
					next_state_reg = A;
		endcase
	end

	// Assign output
	assign out = (state_reg == B) ? 1'b1 : 1'b0;

endmodule
