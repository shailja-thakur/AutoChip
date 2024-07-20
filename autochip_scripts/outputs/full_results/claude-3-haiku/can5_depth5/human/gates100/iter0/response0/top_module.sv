module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_wire, or_wire, xor_wire;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign and_wire[i] = in[i];
        assign or_wire[i] = in[i];
        assign xor_wire[i] = in[i];
    end
endgenerate

assign out_and = &and_wire;
assign out_or = |or_wire;
assign out_xor = ^xor_wire;

endmodule
