module top_module(
	output reg out);

	always @(posedge clk)
	begin
		out <= 0; // driving logic low
	end
	
endmodule
