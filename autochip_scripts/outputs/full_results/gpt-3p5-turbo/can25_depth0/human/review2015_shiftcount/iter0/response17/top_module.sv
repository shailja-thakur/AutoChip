module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Define internal signals
	reg [3:0] shift_reg;

	always @(posedge clk) begin
		// Shift the data into the shift register
		if (shift_ena) begin
			shift_reg <= {data, shift_reg[3:1]};
		end
		
		// Decrement the shift register if count_ena is high
		if (count_ena) begin
			shift_reg <= shift_reg - 1;
		end
	end
	
	// Assign the output to the shift register
	assign q = shift_reg;
endmodule
