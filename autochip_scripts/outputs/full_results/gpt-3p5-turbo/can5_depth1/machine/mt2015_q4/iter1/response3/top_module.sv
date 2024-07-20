module top_module(
	input x,
	input y,
	output reg z);
	
	wire a, b;

	and gate1(a, x, y);
	or gate2(b, x, y);
	and gate3(z, a, b);
	
	initial begin
		$monitor("x = %b, y = %b, z = %b", x, y, z);
		#10 x = 1; y=1;
		#10 x = 0; y=0;
		#10 x = 1; y=0;
		#10 x = 0; y=1;
		#10 $finish;
	end
endmodule
