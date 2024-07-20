module top_module(
	input x,
	input y,
	output z);

	// Define internal wires
	wire w1;
	wire w2;
	
	// Intermediate outputs
	nand_gate u1(.a(x), .b(y), .z(w1));
	nand_gate u2(.a(w1), .b(w1), .z(w2));
	
	// Final output
	assign z = w2;

endmodule
module nand_gate(
    input a,
    input b,
    output z
    );
    assign z = ~(a & b);
endmodule
