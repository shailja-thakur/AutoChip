module top_module (
	input a, 
	input b, 
	output q
);

	always @ (a, b) begin
		if (a == 1'b1 && b == 1'b1)
			q <= 1'b1;
		else
			q <= 1'b0;
	end

endmodule
