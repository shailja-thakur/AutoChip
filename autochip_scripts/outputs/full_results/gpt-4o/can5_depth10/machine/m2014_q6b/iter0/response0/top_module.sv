module top_module(
    input [3:0] y,
    input w,
    output reg Y2
);

    always @* begin
        case ({w, y})
            5'b0_0000: Y2 = 1'b0;
            5'b0_0001: Y2 = 1'b0;
            5'b0_0010: Y2 = 1'b1;
            5'b0_0011: Y2 = 1'b1;
            5'b0_0100: Y2 = 1'b0;
            5'b0_0101: Y2 = 1'b1;
            5'b0_0110: Y2 = 1'b0;
            5'b0_0111: Y2 = 1'b0;
            5'b0_1000: Y2 = 1'b0;
            5'b0_1001: Y2 = 1'b1;
            5'b0_1010: Y2 = 1'b1;
            5'b0_1011: Y2 = 1'b1;
            default: Y2 = 1'b0; // default case to handle all other combinations
        endcase
    end
endmodule
