module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	reg temp;
	
	always @(a or b or c)
	begin
		temp = (a'b'c') | (a'b'c) | (a'bc') | (a'bc) | (ab'c') | (ab'c) | (abc');
	end
	
	assign out = temp;
	
endmodule
