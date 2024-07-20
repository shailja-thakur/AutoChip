module top_module(
    input [3:0] y,
    input w,
    output reg Y2
);

always_comb begin
    case ({y, w})
        5'b00000: Y2 = 1'b0; // y = 4'h0
        5'b00001: Y2 = 1'b0; // y = 4'h1
        5'b00010: Y2 = 1'b1; // y = 4'h2
        5'b00011: Y2 = 1'b1; // y = 4'h3
        5'b00100: Y2 = 1'b0; // y = 4'h4
        5'b00101: Y2 = 1'b1; // y = 4'h5
        5'b00110: Y2 = 1'b0; // y = 4'h6
        5'b00111: Y2 = 1'b0; // y = 4'h7
        5'b01000: Y2 = 1'b0; // y = 4'h8
        5'b01001: Y2 = 1'b1; // y = 4'h9
        5'b01010: Y2 = 1'b1; // y = 4'ha
        5'b01011: Y2 = 1'b1; // y = 4'hb
        default:   Y2 = 1'b0;
    endcase
end

endmodule
