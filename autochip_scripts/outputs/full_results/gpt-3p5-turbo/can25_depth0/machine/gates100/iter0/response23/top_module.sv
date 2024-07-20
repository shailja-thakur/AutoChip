module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    wire [99:0] and_wire;
    wire [99:0] or_wire;
    wire [99:0] xor_wire;
    
    assign out_and = and_wire[99];
    assign out_or = or_wire[99];
    assign out_xor = xor_wire[99];
    
    assign and_wire = &in;
    assign or_wire = |in;
    assign xor_wire = ^in;
endmodule
