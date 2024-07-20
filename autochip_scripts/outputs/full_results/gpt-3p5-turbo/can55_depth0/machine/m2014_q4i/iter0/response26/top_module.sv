module top_module(
	output reg out); // added reg keyword
	always @(posedge clk) // added clock signal
	begin
		out <= 0; // assign 0 to out	
	end
endmodule
