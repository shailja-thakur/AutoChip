module top_module (
	input clk,
	input a, 
	output reg q
);
	
	always @(posedge clk)
	begin
		q <= ~a; // set q to the inverse of a
	end
	
endmodule
