module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (shift_ena) begin
			q <= data;
		end else if (count_ena) begin
			q <= q - 1;
		end else begin
			q <= q;  // No change to q when both shift_ena and count_ena are low
		end
	end
	
endmodule
