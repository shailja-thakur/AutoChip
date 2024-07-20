module top_module (
	input a,
	input b,
	input sel,
	output out
);

	//create one-bit wide, 2-to-1 multiplexer
	//assign output based on the value of sel
	always @ (a, b, sel) begin
		if(sel == 0)
			out = a;
		else
			out = b;
	end

endmodule
