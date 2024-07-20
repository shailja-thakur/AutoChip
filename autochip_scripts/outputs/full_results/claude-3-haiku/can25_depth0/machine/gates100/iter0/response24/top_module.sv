module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

reg [99:0] in_reg;

always @(*) begin
    in_reg = in;
    out_and = &in_reg;
    out_or = |in_reg;
    out_xor = ^in_reg;
end

endmodule
