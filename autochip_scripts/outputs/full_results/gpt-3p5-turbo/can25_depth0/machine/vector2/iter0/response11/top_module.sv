module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    reg [7:0] segment1;
    reg [7:0] segment2;
    reg [7:0] segment3;
    reg [7:0] segment4;
    
    always @(*) begin
        segment1 = in[7:0];
        segment2 = in[15:8];
        segment3 = in[23:16];
        segment4 = in[31:24];
        
        out = {segment4, segment3, segment2, segment1};
    end
endmodule
