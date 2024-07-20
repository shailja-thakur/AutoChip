module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_result;
wire [99:0] or_result;
wire [99:0] xor_result;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign and_result[i] = in[i];
        assign or_result[i] = in[i];
        assign xor_result[i] = in[i];
    end
endgenerate

assign out_and = &and_result;
assign out_or = |or_result;
assign out_xor = ^xor_result;

endmodule
