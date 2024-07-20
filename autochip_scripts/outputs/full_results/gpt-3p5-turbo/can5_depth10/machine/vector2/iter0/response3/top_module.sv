module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    reg [7:0] out_0_7;
    reg [7:0] out_8_15;
    reg [7:0] out_16_23;
    reg [7:0] out_24_31;
    
    always @* begin
        out_0_7 = in[7:0];
        out_8_15 = in[15:8];
        out_16_23 = in[23:16];
        out_24_31 = in[31:24];
    end
    
    assign out = {out_24_31, out_16_23, out_8_15, out_0_7};
    
endmodule
