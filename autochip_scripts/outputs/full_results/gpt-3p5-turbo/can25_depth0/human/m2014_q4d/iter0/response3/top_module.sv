module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    logic flip_flop_d;

    xor_gate xor1(.a(in), .b(out), .y(xor_out));
    d_ff flip_flop(.clk(clk), .d(xor_out), .q(flip_flop_d));

    assign out = flip_flop_d;

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
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule
