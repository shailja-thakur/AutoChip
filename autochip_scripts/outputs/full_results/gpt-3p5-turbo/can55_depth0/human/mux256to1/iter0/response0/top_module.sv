module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    reg [7:0] out_reg;

    always @(*) begin
        case (sel)
            8'b00000000: out_reg = in[7:0];
            8'b00000001: out_reg = in[15:8];
            8'b00000010: out_reg = in[23:16];
            8'b00000011: out_reg = in[31:24];
            8'b00000100: out_reg = in[39:32];
            8'b00000101: out_reg = in[47:40];
            8'b00000110: out_reg = in[55:48];
            8'b00000111: out_reg = in[63:56];
            8'b00001000: out_reg = in[71:64];
            8'b00001001: out_reg = in[79:72];
            8'b00001010: out_reg = in[87:80];
            8'b00001011: out_reg = in[95:88];
            8'b00001100: out_reg = in[103:96];
            8'b00001101: out_reg = in[111:104];
            8'b00001110: out_reg = in[119:112];
            8'b00001111: out_reg = in[127:120];
            8'b00010000: out_reg = in[135:128];
            8'b00010001: out_reg = in[143:136];
            8'b00010010: out_reg = in[151:144];
            8'b00010011: out_reg = in[159:152];
            8'b00010100: out_reg = in[167:160];
            8'b00010101: out_reg = in[175:168];
            8'b00010110: out_reg = in[183:176];
            8'b00010111: out_reg = in[191:184];
            8'b00011000: out_reg = in[199:192];
            8'b00011001: out_reg = in[207:200];
            8'b00011010: out_reg = in[215:208];
            8'b00011011: out_reg = in[223:216];
            8'b00011100: out_reg = in[231:224];
            8'b00011101: out_reg = in[239:232];
            8'b00011110: out_reg = in[247:240];
            8'b00011111: out_reg = in[255:248];
            default: out_reg = 8'b00000000;
        endcase
    end

    assign out = out_reg;

endmodule
