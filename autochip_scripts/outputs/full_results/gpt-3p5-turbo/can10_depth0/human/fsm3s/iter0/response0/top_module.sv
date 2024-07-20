module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state_reg;
	reg out_reg;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= 2'b00; // Reset to state A
		else 
			case (state_reg)
				2'b00: // State A
					if (in)
						state_reg <= 2'b01; // Next state B
					else
						state_reg <= 2'b00; // Next state A
				2'b01: // State B
					if (in)
						state_reg <= 2'b01; // Next state B
					else
						state_reg <= 2'b10; // Next state C
				2'b10: // State C
					if (in)
						state_reg <= 2'b11; // Next state D
					else
						state_reg <= 2'b00; // Next state A
				2'b11: // State D
					if (in)
						state_reg <= 2'b10; // Next state C
					else
						state_reg <= 2'b00; // Next state A
			endcase
	end
	
	always @(posedge clk) begin
		case (state_reg)
			2'b00: // State A
				out_reg <= 1'b0;
			2'b01: // State B
				out_reg <= 1'b0;
			2'b10: // State C
				out_reg <= 1'b0;
			2'b11: // State D
				out_reg <= 1'b1;
		endcase
	end
	
	assign out = out_reg;

endmodule
