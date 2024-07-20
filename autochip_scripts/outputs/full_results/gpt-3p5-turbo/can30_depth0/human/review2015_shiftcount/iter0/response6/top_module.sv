module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// internal signal
	reg [3:0] shift_reg; // shift register
	
	always @(posedge clk) begin
		if (shift_ena) begin
			shift_reg <= {data, shift_reg[3:1]}; // shift data into shift register
		end
		if (count_ena) begin
			if (shift_reg != 0) begin
				shift_reg <= shift_reg - 1; // decrement shift register if not zero
			end
		end
	end
	
	assign q = shift_reg; // output of the shift register
	
endmodule
