module top_module (
    input a,
    input b,
    output q
);

	// This module represents a combinational circuit
	// The circuit performs a logical AND operation between inputs a and b
	// The output q is high (1) only when both inputs a and b are high (1)

	assign q = a & b;

endmodule
