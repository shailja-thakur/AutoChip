module top_module (
    input clk,
    input in,
    output logic out
);

    logic flip_flop_out;

    xor_gate xor1 (
        .in1(in),
        .in2(flip_flop_out),
        .out(out)
    );

    always_ff @(posedge clk) begin
        flip_flop_out <= in;
    end

endmodule
module xor_gate (
    input in1,
    input in2,
    output reg out
);
    always @(*) begin
        out = in1 ^ in2;
    end
endmodule
