module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [98:0] out_both_reg;
    reg [99:1] out_any_reg;
    reg [99:0] out_different_reg;

    always @* begin
        for (int i = 0; i < 99; i = i + 1) begin
            out_both_reg[i] = (in[i] & in[i+1]);
            out_any_reg[i] = (in[i] | in[i+1]);
            out_different_reg[i] = (in[i] != in[i+1]);
        end
        out_any_reg[99] = in[99];
        out_both = out_both_reg;
        out_any = out_any_reg;
        out_different = out_different_reg;
    end
endmodule
