module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	// Define state register
	reg state_type current_state, next_state;

	// Define outputs
	reg out_reg;

	// Sequential logic process
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Combinatorial logic process
	always @*
	begin
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_reg = 0;
			end

			B: begin
				if (in)
					next_state = C;
				else
					next_state = B;
				out_reg = 0;
			end

			C: begin
				if (in)
					next_state = A;
				else
					next_state = D;
				out_reg = 0;
			end

			D: begin
				if (in)
					next_state = C;
				else
					next_state = B;
				out_reg = 1;
			end
		endcase
	end

	// Assign output
	assign out = out_reg;

endmodule
