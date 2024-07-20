module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state_reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= 2'b10;
		else begin
			case (state_reg)
				2'b00: begin
					if (in)
						state_reg <= 2'b01;
				end
				2'b01: begin
					if (in)
						state_reg <= 2'b01;
					else
						state_reg <= 2'b10;
				end
				2'b10: begin
					if (in)
						state_reg <= 2'b01;
				end
			endcase
		end
	end
	
	always @(state_reg) begin
		case (state_reg)
			2'b00: out = 1;
			2'b01: out = 0;
			2'b10: out = 1;
		endcase
	end
endmodule
