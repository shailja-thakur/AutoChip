module top_module(
	output reg one);

	always @(*) begin
		one = 1; // drive output as 1 (logic high)
	end
	
endmodule
