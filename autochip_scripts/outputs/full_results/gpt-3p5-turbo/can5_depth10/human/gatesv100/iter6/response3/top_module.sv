module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [98:0] out_both_reg;
    reg [99:1] out_any_reg;
    reg [99:0] out_different_reg;

    always @(*) begin
        out_both_reg = in[98:0] & in[99:1];
        out_any_reg = {in[98], in[99:1]};
        out_different_reg = {in[99]} ^ in[98:0];
    end
    
    assign out_both = out_both_reg;
    assign out_any = out_any_reg;
    assign out_different = out_different_reg;
    
endmodule
