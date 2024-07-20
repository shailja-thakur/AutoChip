module top_module(
	output reg out);
	
	// assign out to constant value of 0
	always @(posedge clk)
		begin
			out <= 0;
		end
		
endmodule
