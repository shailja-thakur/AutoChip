module top_module (
    input clk,
    input in,
    output logic out
);

    // Internal wires
    wire xor_output;
    wire flop_out;

    // XOR gate instantiation
    xor_gate xor_inst (
        .in1(in),
        .in2(out),
        .out(xor_output)
    );

    // D flip-flop instantiation
    d_flip_flop flop_inst (
        .clk(clk),
        .d(xor_output),
        .q(flop_out)
    );

    // Assign the output of the flip-flop to the top module output
    assign out = flop_out;

endmodule
module xor_gate (
    input in1,
    input in2,
    output logic out
);
    assign out = in1 ^ in2;
endmodule
module d_flip_flop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk)
        q <= d;
endmodule
