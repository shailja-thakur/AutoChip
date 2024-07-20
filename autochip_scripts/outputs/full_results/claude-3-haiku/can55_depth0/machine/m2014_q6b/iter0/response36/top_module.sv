module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

always_comb begin
    case ({y, w})
        5'b00000: Y2 = 1'b0;
        5'b00001: Y2 = 1'b0;
        5'b00010: Y2 = 1'b1;
        5'b00011: Y2 = 1'b1;
        5'b00100: Y2 = 1'b0;
        5'b00101: Y2 = 1'b1;
        5'b00110: Y2 = 1'b0;
        5'b00111: Y2 = 1'b0;
        5'b01000: Y2 = 1'b0;
        5'b01001: Y2 = 1'b1;
        5'b01010: Y2 = 1'b1;
        5'b01011: Y2 = 1'b1;
        default: Y2 = 1'bx;
    endcase
end

endmodule
