module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state_reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= 2'b00;
		else begin
			case (state_reg)
				2'b00: begin  // State B
					if (in)
						state_reg <= 2'b00;  // Loop back to State B
					else
						state_reg <= 2'b01;  // Transition to State A
				end
				2'b01: begin  // State A
					if (in)
						state_reg <= 2'b01;  // Loop back to State A
					else
						state_reg <= 2'b00;  // Transition to State B
				end
				default: state_reg <= 2'b00;
			endcase
		end
	end
	
	assign out = state_reg[0];

endmodule
