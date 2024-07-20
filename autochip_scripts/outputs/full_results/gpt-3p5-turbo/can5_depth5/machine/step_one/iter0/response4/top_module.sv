module top_module(
	output reg one); // added "reg" keyword
	always @(posedge clk) // added a clock signal for synchronous operation
	begin
		one <= 1'b1; // assign 1 to output one
	end
endmodule
