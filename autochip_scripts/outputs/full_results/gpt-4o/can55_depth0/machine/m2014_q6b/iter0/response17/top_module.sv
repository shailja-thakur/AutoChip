module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

always_comb begin
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
        default: Y2 = 0; // Default case in case other values are not defined.
    endcase
end

endmodule
