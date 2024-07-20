module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;

	// Define registers
	reg state_type state;

	// Combinational logic block
	always_comb begin
		case (state)
			S: begin
				if (data)
					state = S1;
				else
					state = S;
			end
			S1: begin
				if (data)
					state = S11;
				else
					state = S;
			end
			S11: begin
				if (data)
					state = S11;
				else
					state = S110;
			end
			S110: begin
				if (data)
					state = Done;
				else
					state = S;
			end
			Done: state = Done;
		endcase
	end

	// Sequential logic block
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S;
		else
			state <= state;
	end

	// Output assignment
	assign start_shifting = (state == Done);

endmodule
