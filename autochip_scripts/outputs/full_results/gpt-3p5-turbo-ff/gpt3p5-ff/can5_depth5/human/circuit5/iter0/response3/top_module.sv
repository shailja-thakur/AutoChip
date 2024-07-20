module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
	if ((a == b) && (c == 0) && (d == e) && (e == b))
		q <= b;
	else if ((a == b) && (c == 1) && (d == e) && (e == e))
		q <= e;
	else if ((a == b) && (c == 2) && (d == e) && (e == a))
		q <= a;
	else if ((a == b) && (c == 3) && (d == e) && (e == d))
		q <= d;
	else if ((a == b) && (c == 4) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 5) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 6) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 7) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 8) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 9) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 10) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 11) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 12) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 13) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 14) && (d == e) && (e == f))
		q <= f;
	else if ((a == b) && (c == 15) && (d == e) && (e == f))
		q <= f;
end

endmodule
