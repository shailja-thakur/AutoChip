module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Declare the states
	enum {A, B} state;

	// Declare the signals
	reg z_reg;

	// Declare the state register
	reg [1:0] state_reg, state_next;

	// Assign the next state based on the current state and input
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end

	// Assign the next state and output based on the current state and input
	always @* begin
		case (state_reg)
			A: begin
				if (x)
					state_next = B;
				else
					state_next = A;

				z_reg = 0;
			end
			B: begin
				if (x)
					state_next = B;
				else
					state_next = B;

				z_reg = 1;
			end
		endcase
	end

	// Assign the output
	assign z = z_reg;

endmodule
