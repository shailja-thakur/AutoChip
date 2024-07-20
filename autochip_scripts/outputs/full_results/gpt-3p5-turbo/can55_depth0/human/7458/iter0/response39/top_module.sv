module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

// Intermediate signals
wire and1_out;
wire and2_out;
wire and3_out;
wire and4_out;

// AND gate instances
andgate
	and1(.in1(p1a), .in2(p1b), .in3(p1c), .out(and1_out)),
	and2(.in1(p1d), .in2(p1e), .in3(p1f), .out(and2_out)),
	and3(.in1(p2a), .in2(p2b), .out(and3_out)),
	and4(.in1(p2c), .in2(p2d), .out(and4_out));

// OR gate instances
orgate
	or1(.in1(and1_out), .in2(and2_out), .out(p1y)),
	or2(.in1(and3_out), .in2(and4_out), .out(p2y));

endmodule
module andgate(
	input in1,
	input in2,
	input in3,
	output out
);

	assign out = in1 & in2 & in3;
	
endmodule
module orgate(
	input in1,
	input in2,
	output out
);

	assign out = in1 | in2;
	
endmodule
