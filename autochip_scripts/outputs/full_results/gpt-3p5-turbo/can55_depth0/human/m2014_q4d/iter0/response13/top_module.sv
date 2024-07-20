module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;
    logic d;
    always_ff @(posedge clk)
        d <= xor_output;

    xor_gate xor1 (
        .a(in),
        .b(out),
        .y(xor_output)
    );

    d_ff dff (
        .clk(clk),
        .d(d),
        .q(out)
    );

endmodule
module xor_gate (
    input a,
    input b,
    output logic y
);
    assign y = a ^ b;
endmodule
module d_ff (
    input clk,
    input d,
    output logic q
);
    always_ff @(posedge clk)
        q <= d;
endmodule
