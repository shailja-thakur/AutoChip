module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Define internal wires
wire w1, w2, w3, w4;

// Assign internal wire values
assign w1 = ~(a & b);
assign w2 = ~(c & d);
assign w3 = w1 & w2;
assign w4 = ~(a | (b & c));

// Define output q
assign q = w3 | w4;

endmodule
