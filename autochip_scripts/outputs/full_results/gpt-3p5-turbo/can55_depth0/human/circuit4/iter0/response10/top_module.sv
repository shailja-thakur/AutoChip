module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Implement the logic here
	always @(*) begin
		if (a == 1 && b == 0 && c == 1 && d == 0) 
			q = 1;
		else
			q = 0;
	end

endmodule
