module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Define internal wires
	wire w1;
	wire w2;
	wire w3;
	wire w4;
	
	// Define the combination logic
	assign w1 = ~c & d;
	assign w2 = ~a & b;
	assign w3 = a & ~b;
	assign w4 = ~a & ~b & c;
	
	// Output assignment
	assign q = w1 | w2 | w3 | w4;
	
endmodule
