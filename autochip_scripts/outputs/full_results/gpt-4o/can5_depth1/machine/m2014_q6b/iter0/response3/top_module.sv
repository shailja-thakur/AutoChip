module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

    always_comb begin
        case ({y, w})
            5'b00000: Y2 = 1'b0;
            5'b00010: Y2 = 1'b0;
            5'b00100: Y2 = 1'b1;
            5'b00110: Y2 = 1'b1;
            5'b01000: Y2 = 1'b0;
            5'b01010: Y2 = 1'b1;
            5'b01100: Y2 = 1'b0;
            5'b01110: Y2 = 1'b0;
            5'b10000: Y2 = 1'b0;
            5'b10010: Y2 = 1'b1;
            5'b10100: Y2 = 1'b1;
            5'b10110: Y2 = 1'b1;
            default: Y2 = 1'b0;
        endcase
    end

endmodule
