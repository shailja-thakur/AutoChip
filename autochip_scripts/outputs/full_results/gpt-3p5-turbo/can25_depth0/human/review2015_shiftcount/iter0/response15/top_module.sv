module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] shift_reg;
	reg [2:0] counter;

	always @(posedge clk) begin
		if (shift_ena) begin
			shift_reg <= {data, shift_reg[3:1]};
		end
		
		if (count_ena) begin
			if (counter == 0) begin
				shift_reg <= 4'b0000;
			end else begin
				shift_reg <= shift_reg - 1;
			end
		end
	end
	
	assign q = shift_reg;
	
endmodule
