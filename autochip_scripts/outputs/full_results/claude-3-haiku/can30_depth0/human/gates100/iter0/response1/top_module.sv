module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_gates;
wire [99:0] or_gates;
wire [99:0] xor_gates;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin : gen_gates
        assign and_gates[i] = in[i];
        assign or_gates[i] = in[i];
        assign xor_gates[i] = in[i];
    end
endgenerate

assign out_and = &and_gates;
assign out_or = |or_gates;
assign out_xor = ^xor_gates;

endmodule
