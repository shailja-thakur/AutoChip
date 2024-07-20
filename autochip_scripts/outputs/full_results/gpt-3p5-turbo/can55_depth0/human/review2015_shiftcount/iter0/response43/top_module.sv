module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	// internal signals
	reg [3:0] shift_reg;
	
	always @(posedge clk) begin
		if (shift_ena) begin
			shift_reg[3] <= data;
			shift_reg[2] <= shift_reg[3];
			shift_reg[1] <= shift_reg[2];
			shift_reg[0] <= shift_reg[1];
		end
		
		if (count_ena) begin
			if (shift_ena) begin
				shift_reg <= shift_reg - 1;
			end else begin
				shift_reg <= shift_reg - 1;
			end
		end
		
		q <= shift_reg;
	end
	
endmodule
