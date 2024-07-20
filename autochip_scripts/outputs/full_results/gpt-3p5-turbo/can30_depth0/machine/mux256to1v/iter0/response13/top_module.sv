module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [1023:0] in_reg;
reg [3:0] out_reg;

always @* begin
    case (sel)
        8'b00000000: out_reg = in_reg[3:0];
        8'b00000001: out_reg = in_reg[7:4];
        8'b00000010: out_reg = in_reg[11:8];
        8'b00000011: out_reg = in_reg[15:12];
        8'b00000100: out_reg = in_reg[19:16];
        8'b00000101: out_reg = in_reg[23:20];
        8'b00000110: out_reg = in_reg[27:24];
        8'b00000111: out_reg = in_reg[31:28];
        // continue for the remaining cases
    endcase
end

assign out = out_reg;

endmodule
