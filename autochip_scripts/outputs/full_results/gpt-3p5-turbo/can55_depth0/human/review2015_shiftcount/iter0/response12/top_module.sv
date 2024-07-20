module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
		
	// Internal signals
	reg [3:0] shift_reg;
	
	// Positive edge clock triggers
	always @(posedge clk) begin
		if (shift_ena) begin
			shift_reg[3:1] <= shift_reg[2:0];
			shift_reg[0] <= data;
		end
		
		if (count_ena) begin
			if (shift_reg != 4'b0000)
				shift_reg <= shift_reg - 1;
			else
				shift_reg <= 4'b1111;
		end
	end
	
	// Output assignment
	assign q = shift_reg;
endmodule
