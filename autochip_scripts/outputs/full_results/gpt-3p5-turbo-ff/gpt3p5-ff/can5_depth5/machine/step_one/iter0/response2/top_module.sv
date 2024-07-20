module top_module(
	output reg one);  // added reg for output one, as it needs to be assigned a value
	 
	always @(posedge clk) begin
		one <= 1'b1;   // assign output one to a value of 1'b1
	end
endmodule
