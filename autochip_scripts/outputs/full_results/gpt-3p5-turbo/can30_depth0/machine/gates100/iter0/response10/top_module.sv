module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    reg out_and_reg, out_or_reg, out_xor_reg;
    
    assign out_and = out_and_reg;
    assign out_or = out_or_reg;
    assign out_xor = out_xor_reg;
    
    always @(*) begin
        out_and_reg = &in;
        out_or_reg = |in;
        out_xor_reg = ^in;
    end

endmodule
