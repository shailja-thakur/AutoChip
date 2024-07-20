module xor (
    input a,
    input b,
    output logic y
);
    assign y = a ^ b;
endmodule
module d_flip_flop (
    input clk,
    input d,
    output logic q
);
    always_ff @(posedge clk)
        q <= d;
endmodule
module top_module (
    input clk,
    input in,
    output logic out
);
    wire xor_output;
    xor xor_gate (
        .a(in),
        .b(out),
        .y(xor_output)
    );

    d_flip_flop flip_flop (
        .clk(clk),
        .d(xor_output),
        .q(out)
    );
endmodule
