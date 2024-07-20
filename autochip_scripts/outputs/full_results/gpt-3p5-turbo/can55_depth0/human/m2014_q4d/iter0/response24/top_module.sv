module top_module (
    input clk,
    input in,
    output logic out
);

logic xor_output;
logic d_ff_input;

xor xor_gate (
    .a(in),
    .b(out),
    .y(xor_output)
);

always_ff @(posedge clk) begin
    d_ff_input <= xor_output;
end

always_comb begin
    out <= d_ff_input;
end

endmodule
module xor (
    input a,
    input b,
    output y
);

assign y = a ^ b;

endmodule
module d_ff (
    input d,
    input clk,
    output reg q
);

always @(posedge clk) begin
    q <= d;
end

endmodule
