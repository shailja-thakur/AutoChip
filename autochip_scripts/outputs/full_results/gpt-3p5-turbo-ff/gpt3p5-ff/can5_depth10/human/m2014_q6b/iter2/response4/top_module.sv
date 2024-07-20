module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            // Next state logic for Y2
            3'b000: Y2 = (w) ? 0 : 1;
            3'b001: Y2 = 0;
            3'b010: Y2 = 0;
            3'b011: Y2 = 0;
            3'b100: Y2 = 1;
            3'b101: Y2 = 0;
            default: Y2 = 0;
        endcase
    end

endmodule
