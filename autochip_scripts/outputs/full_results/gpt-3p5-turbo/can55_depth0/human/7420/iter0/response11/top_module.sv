module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	
	// Internal wires
	wire w1, w2, w3, w4;
	
	// NAND gates
	nandgate u1(w1, p1a, p1b, p1c, p1d);
	nandgate u2(w2, p2a, p2b, p2c, p2d);
	
	// Output assignments
	assign p1y = w1;
	assign p2y = w2;
	
endmodule
module nandgate(output n, input a, input b, input c, input d);
	
	// Internal wires
	wire w1, w2, w3, w4, w5;
	
	// NOT gates
	notgate u1(w1, a);
	notgate u2(w2, b);
	notgate u3(w3, c);
	notgate u4(w4, d);
	
	// AND gate
	andgate u5(w5, w1, w2, w3, w4);
	
	// Output assignment
	assign n = w5;
	
endmodule
module notgate(output n, input a);
	
	// Output assignment
	assign n = ~a;
	
endmodule
module andgate(output n, input a, input b, input c, input d);
	
	// Internal wires
	wire w1, w2, w3;
	
	// NAND gates
	nandgate u1(w1, a, b);
	nandgate u2(w2, w1, c);
	nandgate u3(w3, w2, d);
	
	// Output assignment
	assign n = w3;
	
endmodule
