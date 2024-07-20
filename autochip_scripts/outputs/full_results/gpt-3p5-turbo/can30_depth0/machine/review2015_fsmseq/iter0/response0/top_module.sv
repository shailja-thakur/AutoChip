module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State definitions
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;
	
	// Registers
	reg state_reg;
	
	// Combinational logic block
	always_comb begin
		case (state_reg)
			S: begin
				if (data)
					state_reg <= S1;
				else
					state_reg <= S;
			end
			S1: begin
				if (data)
					state_reg <= S11;
				else
					state_reg <= S;
			end
			S11: begin
				if (data)
					state_reg <= S11;
				else
					state_reg <= S110;
			end
			S110: begin
				if (data)
					state_reg <= Done;
				else
					state_reg <= S;
			end
			Done: state_reg <= Done;
		endcase
	end
	
	// Output assignment
	assign start_shifting = (state_reg == Done) ? 1'b1 : 1'b0;
	
	// Clock edge detection
	always @(posedge clk) begin
		if (reset)
			state_reg <= S;
		else
			state_reg <= state_reg;
	end	
endmodule
