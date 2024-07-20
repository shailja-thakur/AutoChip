module top_module(
    input [3:0] y,  // Adjusted input size from [3:1] to [3:0]
    input w,
    output reg Y2
);

    always @(*) begin
        case ({y, w})
            5'h00: Y2 = 0;
            5'h01: Y2 = 0;
            5'h02: Y2 = 1;
            5'h03: Y2 = 1;
            5'h04: Y2 = 0;
            5'h05: Y2 = 1;
            5'h06: Y2 = 0;
            5'h07: Y2 = 0;
            5'h08: Y2 = 0;
            5'h09: Y2 = 1;
            5'h0A: Y2 = 1;
            5'h0B: Y2 = 1;
            5'h0C: Y2 = 0;
            5'h0D: Y2 = 0;
            5'h0E: Y2 = 0;
            5'h0F: Y2 = 0;
            5'h10: Y2 = 0;
            5'h11: Y2 = 0;
            5'h12: Y2 = 1;
            5'h13: Y2 = 1;
            5'h14: Y2 = 0;
            5'h15: Y2 = 1;
            5'h16: Y2 = 0;
            5'h17: Y2 = 0;
            5'h18: Y2 = 0;
            5'h19: Y2 = 1;
            5'h1A: Y2 = 1;
            5'h1B: Y2 = 1;
            default: Y2 = 0;
        endcase
    end

endmodule
