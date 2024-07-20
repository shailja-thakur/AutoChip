module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

reg [99:0] in_reg;

always @* begin
    in_reg = in;
    out_and = 1'b1;
    out_or = 1'b0;
    out_xor = 1'b0;

    for (int i = 0; i < 100; i++) begin
        out_and = out_and & in_reg[i];
        out_or = out_or | in_reg[i];
        out_xor = out_xor ^ in_reg[i];
    end
end

endmodule
