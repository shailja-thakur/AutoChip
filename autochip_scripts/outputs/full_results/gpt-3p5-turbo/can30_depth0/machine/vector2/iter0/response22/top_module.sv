module top_module (
    input [31:0] in,
    output [31:0] out
);
    reg [7:0] out_0to7;
    reg [7:0] out_8to15;
    reg [7:0] out_16to23;
    reg [7:0] out_24to31;
    
    always @(*) begin
        out_0to7 = in[7:0];
        out_8to15 = in[15:8];
        out_16to23 = in[23:16];
        out_24to31 = in[31:24];
        out = {out_24to31, out_16to23, out_8to15, out_0to7};
    end

endmodule
