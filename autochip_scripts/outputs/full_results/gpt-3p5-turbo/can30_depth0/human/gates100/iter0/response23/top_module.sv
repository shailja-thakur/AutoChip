module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // Declaration of wire signals
    wire [99:0] in_wire;
    wire out_and_wire;
    wire out_or_wire;
    wire out_xor_wire;
    
    // Connections between input and wire signals
    assign in_wire = in;

    // Connection of gates to wire signals
    assign out_and_wire = &in_wire;
    assign out_or_wire = |in_wire;
    assign out_xor_wire = ^in_wire;
    
    // Connections between wire signals and outputs
    assign out_and = out_and_wire;
    assign out_or = out_or_wire;
    assign out_xor = out_xor_wire;
    
endmodule
