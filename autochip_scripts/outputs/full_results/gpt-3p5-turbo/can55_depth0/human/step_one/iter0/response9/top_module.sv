module top_module(
	output reg one); // added reg keyword for output declaration

	always @(posedge clk) // added clock signal for synchronous logic
	begin
		one <= 1'b1; // output one is always driven with logic high
	end
	
endmodule
