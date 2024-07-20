module top_module (
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input [15:0] f,
	input [15:0] g,
	input [15:0] h,
	input [15:0] i,
	input [3:0] sel,
	output logic [15:0] out
);

always @(*) begin
	case (sel)
		4'b0000: out = a;
		4'b0001: out = b;
		4'b0010: out = c;
		4'b0011: out = d;
		4'b0100: out = e;
		4'b0101: out = f;
		4'b0110: out = g;
		4'b0111: out = h;
		4'b1000: out = i;
		default: out = 16'b1;
	endcase
end

endmodule
module top_module_tb();

reg [15:0] a;
reg [15:0] b;
reg [15:0] c;
reg [15:0] d;
reg [15:0] e;
reg [15:0] f;
reg [15:0] g;
reg [15:0] h;
reg [15:0] i;
reg [3:0] sel;

wire [15:0] out;
top_module uut (
	.a(a),
	.b(b),
	.c(c),
	.d(d),
	.e(e),
	.f(f),
	.g(g),
	.h(h),
	.i(i),
	.sel(sel),
	.out(out)
);

initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0, out);

	// Test case 1
	a = 16'b0000000000000000;
	b = 16'b1111111111111111;
	c = 16'b0101010101010101;
	d = 16'b0011001100110011;
	e = 16'b1010101010101010;
	f = 16'b0101010101010101;
	g = 16'b0011001100110011;
	h = 16'b1111111111111111;
	i = 16'b0000000000000000;
	sel = 4'b0000;
	#10;

	// Test case 2
	a = 16'b1111111111111111;
	b = 16'b0000000000000000;
	c = 16'b1010101010101010;
	d = 16'b0101010101010101;
	e = 16'b0011001100110011;
	f = 16'b0101010101010101;
	g = 16'b1111111111111111;
	h = 16'b0000000000000000;
	i = 16'b0101010101010101;
	sel = 4'b1000;
	#10;
	
	// Add more test cases here

	$finish;
end

endmodule
