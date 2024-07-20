module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output reg q
);
	
	always @*
	begin
		if (~a & ~b & ~c)
			q = 0;
		else
			q = 1;
	end

endmodule
