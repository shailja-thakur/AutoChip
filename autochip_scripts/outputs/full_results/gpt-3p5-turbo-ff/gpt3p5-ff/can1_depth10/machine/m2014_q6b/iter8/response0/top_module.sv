module top_module(
    input [3:0] y,
    input w,
    output reg Y2
);

    always_comb begin
        case({y, w})
            4'b0000: Y2 = 1'b0;
            4'b0001: Y2 = 1'b0;
            4'b0010: Y2 = 1'b1;
            4'b0011: Y2 = 1'b1;
            4'b0100: Y2 = 1'b0;
            4'b0101: Y2 = 1'b1;
            4'b0110: Y2 = 1'b0;
            4'b0111: Y2 = 1'b0;
            default: Y2 = 1'b0;
        endcase
    end

endmodule
