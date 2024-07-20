module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_terms;
wire [99:0] or_terms;
wire [99:0] xor_terms;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin : gen_logic
        assign and_terms[i] = in[i];
        assign or_terms[i]  = in[i];
        assign xor_terms[i] = in[i];
    end
endgenerate

assign out_and = &and_terms;
assign out_or  = |or_terms;
assign out_xor = ^xor_terms;

endmodule
