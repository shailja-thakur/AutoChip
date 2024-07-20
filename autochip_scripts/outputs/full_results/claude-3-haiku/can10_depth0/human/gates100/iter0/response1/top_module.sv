module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_inverted;

// Generate the inverted inputs
genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign in_inverted[i] = ~in[i];
    end
endgenerate

// 100-input AND gate
assign out_and = &in;

// 100-input OR gate
assign out_or = |in;

// 100-input XOR gate
assign out_xor = ^in ^ ^in_inverted;

endmodule
