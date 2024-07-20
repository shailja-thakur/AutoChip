module top_module (
	input a, 
	input b, 
	output q
);

	always @(*)
	begin
		if(a && b)
			q = 1;
		else
			q = 0;
	end

endmodule
