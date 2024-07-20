module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Define internal wire signals
wire w1, w2, w3, w4, w5, w6, w7, w8;

// Implement the combinational logic
assign w1 = !(a | b);
assign w2 = w1 & c;
assign w3 = w1 & d;
assign w4 = !(w2 | w3);
assign w5 = a & b;
assign w6 = w5 & !(c | d);
assign w7 = w5 & d;
assign w8 = !(w6 | w7);
assign q = !(w4 | w8);

endmodule
