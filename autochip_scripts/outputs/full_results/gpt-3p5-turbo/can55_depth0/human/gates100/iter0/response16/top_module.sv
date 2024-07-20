module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = &in;
    assign out_or = |in;
    
    wire [99:0] xor_out;
    
    xor_gate_1_to_2 xor_gate_1_to_2_inst (
        .in(in),
        .out(xor_out)
    );
    
    assign out_xor = ^xor_out;
    
endmodule
module xor_gate_1_to_2 (
    input [99:0] in,
    output [0:0] out
);
    assign out = ^in;
endmodule
