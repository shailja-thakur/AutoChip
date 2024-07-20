module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Intermediate wires for the gates
    wire [99:0] and_wires;
    wire [99:0] or_wires;
    wire [99:0] xor_wires;

    // 100-input AND gate
    assign out_and = &and_wires;

    // 100-input OR gate
    assign out_or = |or_wires;

    // 100-input XOR gate
    assign out_xor = ^xor_wires;

    // Connect the input wires to the intermediate wires
    assign and_wires = in;
    assign or_wires = in;
    assign xor_wires = in;

endmodule
