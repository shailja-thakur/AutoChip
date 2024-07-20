module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define intermediate signals
wire ab_00, ab_01, ab_11, ab_10;
wire cd_00, cd_01, cd_11, cd_10;

// Implement Karnaugh map logic
assign ab_00 = a & b;
assign ab_01 = a & ~b;
assign ab_11 = ~a & b;
assign ab_10 = ~a & ~b;
assign cd_00 = c & d;
assign cd_01 = c & ~d;
assign cd_11 = ~c & d;
assign cd_10 = ~c & ~d;

// Implement output logic using Karnaugh map
assign out = ab_00 | ab_01 | (~ab_11 & cd_00) | (ab_10 & cd_01) | (ab_11 & cd_10) | (ab_00 & cd_11);

endmodule
