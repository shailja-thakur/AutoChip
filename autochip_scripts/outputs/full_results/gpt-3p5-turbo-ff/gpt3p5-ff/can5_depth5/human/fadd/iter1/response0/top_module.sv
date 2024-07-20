module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
    
    // Internal wires and registers declaration
    wire sum_wire;
    wire carry_out_wire;

    // Instance of the full adder module
    full_adder FA (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum_wire),
        .cout(carry_out_wire)
    );

    // Assigning the output signals of the full adder module to top module output signals
    assign sum = sum_wire;
    assign cout = carry_out_wire;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

	// Internal wires declaration
	wire w1, w2, w3;
    
    // XOR gate instantiation
    xor_gate XOR1 (
        .a(a),
        .b(b),
        .out(w1)
    );
    
    // XOR gate instantiation
    xor_gate XOR2 (
        .a(w1),
        .b(cin),
        .out(sum)
    );
    
    // AND gate instantiation
    and_gate AND1 (
        .a(a),
        .b(b),
        .out(w2)
    );
    
    // AND gate instantiation
    and_gate AND2 (
        .a(a),
        .b(cin),
        .out(w3)
    );
    
    // OR gate instantiation
    or_gate OR1 (
        .a(w2),
        .b(w3),
        .out(cout)
    );
    
endmodule
module xor_gate (
    input a,
    input b,
    output out
);

    assign out = a ^ b;

endmodule
module and_gate (
    input a,
    input b,
    output out
);

    assign out = a & b;

endmodule
module or_gate (
    input a,
    input b,
    output out
);

    assign out = a | b;

endmodule
