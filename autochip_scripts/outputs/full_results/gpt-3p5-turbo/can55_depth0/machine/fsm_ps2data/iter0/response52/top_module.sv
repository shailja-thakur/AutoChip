module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else begin
			case(state)
				2'b00: begin		
					if (in[2] == 1'b1) 
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					state <= 2'b10;
	      end
				2'b10: begin
					state <= 2'b11;
				end
				2'b11: begin
					state <= 2'b00;
				end
				default: begin
					state <= 2'b00;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			out_reg <= 24'b0;
		else begin
			case(state)
				2'b00: begin
					if (in[2] == 1'b0)
						out_reg <= {out_reg[15:0], in};
				end
				2'b11: begin
					out_reg <= {out_reg[7:0], in};
				end
				default: begin
					// No action when in other states
				end
			endcase
		end
	end
	
	assign out_bytes = out_reg;
	assign done = (state == 2'b11);

endmodule
