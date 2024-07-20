module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	always @(*) begin
		if (a && b && c)   // check if a, b, and c are all high
			q = 1;    // if true, set q to high
		else
			q = d;    // otherwise, set q to d
	end
endmodule
