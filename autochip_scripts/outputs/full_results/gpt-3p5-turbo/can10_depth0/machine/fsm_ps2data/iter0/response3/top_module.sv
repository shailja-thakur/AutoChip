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
		else
			case (state)
				2'b00: begin
					if (in[2] == 1'b1)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				
				2'b01: begin
					if (in[2] == 1'b1)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				
				2'b10: begin
					if (in[2] == 1'b1)
						state <= 2'b11;
					else
						state <= 2'b00;
				end
				
				2'b11: begin
					if (in[2] == 1'b0)
						state <= 2'b00;
					else
						state <= 2'b11;
				end
			endcase
	end
	
	always @(posedge clk) begin
		if (state == 2'b11)
			out_reg <= {out_reg[15:0], in};
	end
	
	assign out_bytes = state == 2'b00 ? out_reg : 24'b0;
	assign done = state == 2'b11;
	
endmodule
