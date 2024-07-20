module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    logic d_ff_out;
    logic xor_input;
    
    xor2 xor_gate (
        .a(in),
        .b(out),
        .z(xor_out)
    );
    
    d_ff d_flip_flop (
        .clk(clk),
        .d(xor_out),
        .q(d_ff_out)
    );
    
    assign out = d_ff_out;
    
endmodule
module xor2 (
    input a,
    input b,
    output z
);
    assign z = ~(a ^ b);
endmodule
module d_ff (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk)
        q <= d;
endmodule
