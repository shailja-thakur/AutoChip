module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output reg [99:0] out // Changed to 'reg' type for synthesis compatibility
);

	always @(a, b, sel) begin // Added sensitivity list
		if(sel == 0) // Changed to '==' for comparison
			out = a; 
		else // Added 'else' condition
			out = b; 
	end
	
endmodule
