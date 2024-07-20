module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Define internal wires
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;
	
	// Logic gates
	assign w1 = a & b;
	assign w2 = ~w1;
	assign w3 = c & d;
	assign w4 = ~w3;
	assign w5 = w2 | w4;
	assign w6 = ~(a | b);
	assign w7 = ~(c | d);
	assign w8 = w6 & w7;
	assign w9 = w5 | w8;
	assign w10 = ~(~w9 | w9);
	assign w11 = ~w10;
	assign w12 = ~(a | b | c | d);
	assign q = w11 & w12;
	
endmodule
