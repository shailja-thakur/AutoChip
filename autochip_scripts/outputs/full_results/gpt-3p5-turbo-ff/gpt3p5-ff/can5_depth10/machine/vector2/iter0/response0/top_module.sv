module top_module (
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] out_reg;
    
    always @(*) begin
        out_reg[7:0] = in[31:24];
        out_reg[15:8] = in[23:16];
        out_reg[23:16] = in[15:8];
        out_reg[31:24] = in[7:0];
    end

    assign out = out_reg;
    
endmodule
