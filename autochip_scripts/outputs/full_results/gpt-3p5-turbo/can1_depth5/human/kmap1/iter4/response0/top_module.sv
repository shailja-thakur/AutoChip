module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	reg temp;
	
	always @*
	begin
		if(a==1'b0 && b==1'b0 && c==1'b0)
			temp = 1'b0;
		else
			temp = 1'b1;
	end
	
	assign out = temp;
	
endmodule
