module top_module(
	input x,
	input y,
	output z);

	assign a = x;
	assign b = y;

	// Define logic gates
	and_gate u1(.a(a), .b(b), .z(gate1_output));
	xor_gate u2(.a(b), .b(a), .z(gate2_output));
	and_gate u3(.a(gate1_output), .b(gate2_output), .z(z));

endmodule
module and_gate(
    input a,
    input b,
    output z
    );
    assign z = a & b;
endmodule
module xor_gate(
    input a,
    input b,
    output z
    );
    assign z = a ^ b;
endmodule
