module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	
	//Behavioral code that implements the multiplexer logic
	always @(*) begin
		if(sel == 0)
			out = a;
		else if(sel == 1)
			out = b;
	end
	
endmodule
