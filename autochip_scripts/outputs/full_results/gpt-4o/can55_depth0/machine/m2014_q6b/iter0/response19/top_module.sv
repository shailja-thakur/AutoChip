module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

    always @(*) begin
        case ({y, w})
            5'h00, 5'h01: Y2 = 0;    // y = 4'h0, w = 0 or 1
            5'h02, 5'h03: Y2 = 0;    // y = 4'h1, w = 0 or 1
            5'h04, 5'h05: Y2 = 1;    // y = 4'h2, w = 0 or 1
            5'h06, 5'h07: Y2 = 1;    // y = 4'h3, w = 0 or 1
            5'h08, 5'h09: Y2 = 0;    // y = 4'h4, w = 0 or 1
            5'h0A, 5'h0B: Y2 = 1;    // y = 4'h5, w = 0 or 1
            5'h0C, 5'h0D: Y2 = 0;    // y = 4'h6, w = 0 or 1
            5'h0E, 5'h0F: Y2 = 0;    // y = 4'h7, w = 0 or 1
            5'h10, 5'h11: Y2 = 0;    // y = 4'h8, w = 0 or 1
            5'h12, 5'h13: Y2 = 1;    // y = 4'h9, w = 0 or 1
            5'h14, 5'h15: Y2 = 1;    // y = 4'ha, w = 0 or 1
            5'h16, 5'h17: Y2 = 1;    // y = 4'hb, w = 0 or 1
            default: Y2 = 0;         // default case if no match
        endcase
    end
endmodule
