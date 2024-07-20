module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    wire [99:0] and_temp_wire;
    wire [99:0] or_temp_wire;
    wire [99:0] xor_temp_wire;

    assign out_and = &and_temp_wire;
    assign out_or = |or_temp_wire;
    assign out_xor = ^xor_temp_wire;

    assign and_temp_wire = in;
    assign or_temp_wire = in;
    assign xor_temp_wire = in;

endmodule
