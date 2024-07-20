module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [7:0] byte1_reg;
	reg [7:0] byte2_reg;
	reg [7:0] byte3_reg;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			byte1_reg <= 0;
			byte2_reg <= 0;
			byte3_reg <= 0;
			done <= 0;
		end else begin
			byte1_reg <= in;
			
			if (byte3_reg == 0 && in[3] == 1) begin
				byte2_reg <= in;
			end
			
			if (byte2_reg != 0 && byte3_reg == 0 && in[3] == 1) begin
				byte2_reg <= in;
				byte3_reg <= in;
				done <= 1;
			end 
			
			if (byte3_reg != 0 && in[3] == 1) begin
				byte1_reg <= in;
				byte2_reg <= 0;
				byte3_reg <= 0;
				done <= 0;
			end
		end
	end
	
	assign out_bytes = {byte1_reg, byte2_reg, byte3_reg};
	
	assign done = done;
endmodule
