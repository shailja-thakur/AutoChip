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

	reg state;
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else begin
			case (state)
				S:
					if (data)
						state <= S1;
					else
						state <= S;
				S1:
					if (data)
						state <= S11;
					else
						state <= S;
				S11:
					if (data)
						state <= S11;
					else
						state <= S110;
				S110:
					if (data)
						state <= Done;
					else
						state <= S;
				Done:
					state <= Done;
			endcase
		end
	end

	assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
