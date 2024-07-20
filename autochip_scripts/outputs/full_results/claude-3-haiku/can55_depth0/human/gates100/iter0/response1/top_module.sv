module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

// 100-input AND gate
assign out_and = &in;

// 100-input OR gate
assign out_or = |in;

// 100-input XOR gate
genvar i;
wire [99:0] xor_chain;
assign xor_chain[0] = in[0];
generate
    for (i = 1; i < 100; i = i + 1) begin
        assign xor_chain[i] = xor_chain[i-1] ^ in[i];
    end
endgenerate
assign out_xor = xor_chain[99];

endmodule
