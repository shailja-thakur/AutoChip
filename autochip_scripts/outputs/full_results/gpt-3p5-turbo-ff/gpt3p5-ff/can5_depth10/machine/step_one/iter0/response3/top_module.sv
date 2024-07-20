module top_module(
	output reg one);
	
	always @(inoutDFF) begin
		one = 1'b1;
	end
endmodule
