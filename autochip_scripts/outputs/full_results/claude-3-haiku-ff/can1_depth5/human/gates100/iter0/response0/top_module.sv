module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_inv;
genvar i;

generate
    for (i = 0; i < 100; i = i + 1) begin
        assign in_inv[i] = ~in[i];
    end
endgenerate

assign out_and = &in;
assign out_or = |in;
assign out_xor = ^in;

endmodule
