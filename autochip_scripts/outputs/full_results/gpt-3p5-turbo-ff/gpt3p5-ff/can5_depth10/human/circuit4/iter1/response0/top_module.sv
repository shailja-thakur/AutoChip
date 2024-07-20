module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Assign q using if-else statements
	always @(*) begin
		if (~a & c & ~d)
			q = 1'b1;
		else if (~c & d)
			q = 1'b1;
		else if (a & ~b & c)
			q = 1'b1;
		else
			q = 1'b0;
	end
endmodule
