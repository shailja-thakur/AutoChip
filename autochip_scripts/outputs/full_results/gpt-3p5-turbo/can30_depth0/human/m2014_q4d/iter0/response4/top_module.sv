module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_result;
    logic flip_flop_output;

    xor_gate xor(
        .a(in),
        .b(out),
        .y(xor_result)
    );

    d_ff flip_flop (
        .clk(clk),
        .d(xor_result),
        .q(flip_flop_output)
    );

    assign out = flip_flop_output;

    // XOR gate definition
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
        always @(posedge clk) begin
            q <= d;
        end
    endmodule
