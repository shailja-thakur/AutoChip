module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    wire [99:0] in_wire;
    assign in_wire = in;

    // Perform AND operation
    assign out_and = &in_wire;

    // Perform OR operation
    assign out_or = |in_wire;

    // Perform XOR operation
    assign out_xor = ^in_wire;

endmodule
