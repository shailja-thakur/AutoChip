module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	reg [1:0] state;
	reg [7:0] in_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			in_reg <= 8'b0;
			done <= 1'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in[3]) begin
						state <= 2'b01;
						in_reg <= in;
					end
				end
				2'b01: begin
					state <= 2'b10;
					in_reg <= {in_reg[6:0], in};
				end
				2'b10: begin
					state <= 2'b11;
					in_reg <= {in_reg[6:0], in};
				end
				2'b11: begin
					state <= 2'b00;
					in_reg <= {in_reg[6:0], in};
					if (in[3] && done == 0)
						done <= 1'b1;
				end
				default: begin
					state <= 2'b00;
					in_reg <= 8'b0;
					done <= 1'b0;
				end
			endcase
		end
	end
	
endmodule
