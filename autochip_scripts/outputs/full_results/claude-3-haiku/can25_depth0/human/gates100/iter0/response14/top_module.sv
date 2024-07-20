module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_wires;
wire [99:0] or_wires;
wire [99:0] xor_wires;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin : gen_and_or_xor
        assign and_wires[i] = in[i];
        assign or_wires[i] = in[i];
        assign xor_wires[i] = in[i];
    end
endgenerate

assign out_and = &and_wires;
assign out_or = |or_wires;
assign out_xor = ^xor_wires;

endmodule
