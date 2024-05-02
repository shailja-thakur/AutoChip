module adder_tb ();

reg [3:0] a;
reg [3:0] b;
wire [3:0] sum;

adder uut(
	.a(a),
	.b(b),
	.sum(sum)
);

initial begin
	a <= 4'b0000;
	b <= 4'b0000;
	#10;
	a <= 4'b0001;
	b <= 4'b0001;
	#10;
	a <= 4'b0010;
	b <= 4'b0010;
	#10;
	a <= 4'b0011;
	b <= 4'b0011;
	#10;
end

endmodule
