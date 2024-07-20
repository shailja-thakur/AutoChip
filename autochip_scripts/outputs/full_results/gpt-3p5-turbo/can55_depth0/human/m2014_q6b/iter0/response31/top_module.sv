module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(y, w) begin
        case({y, w})
            3'b0000: Y2 = 1'b0;
            3'b0001: Y2 = 1'b0;
            3'b0010: Y2 = 1'b0;
            3'b0011: Y2 = 1'b0;
            3'b0100: Y2 = 1'b0;
            3'b0101: Y2 = 1'b1;
            3'b0110: Y2 = 1'b0;
            3'b0111: Y2 = 1'b0;
            3'b1000: Y2 = 1'b0;
            3'b1001: Y2 = 1'b0;
            3'b1010: Y2 = 1'b0;
            3'b1011: Y2 = 1'b0;
            default: Y2 = 1'b0;
        endcase
    end

endmodule
