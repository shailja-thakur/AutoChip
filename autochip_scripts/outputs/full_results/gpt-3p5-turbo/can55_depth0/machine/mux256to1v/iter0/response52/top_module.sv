module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] out_temp;
assign out = out_temp;

always @(sel) begin
    case (sel)
        8'b00000000: out_temp = in[0:3];
        8'b00000001: out_temp = in[4:7];
        8'b00000010: out_temp = in[8:11];
        8'b00000011: out_temp = in[12:15];
        8'b00000100: out_temp = in[16:19];
        8'b00000101: out_temp = in[20:23];
        8'b00000110: out_temp = in[24:27];
        8'b00000111: out_temp = in[28:31];
        8'b00001000: out_temp = in[32:35];
        // continue with all possible selections
        
        default: out_temp = 4'b0000;
    endcase
end

endmodule
