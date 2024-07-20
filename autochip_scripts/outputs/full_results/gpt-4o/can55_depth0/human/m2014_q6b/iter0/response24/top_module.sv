module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = (w == 1'b0) ? 1'b0 : 1'b0; // A: 0 -> B, 1 -> A (Y2 = 0)
            3'b001: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // B: 0 -> C, 1 -> D (Y2 = y[1])
            3'b010: Y2 = (w == 1'b0) ? 1'b1 : 1'b1; // C: 0 -> E, 1 -> D (Y2 = 1)
            3'b011: Y2 = (w == 1'b0) ? 1'b1 : 1'b0; // D: 0 -> F, 1 -> A (Y2 = ~y[1])
            3'b100: Y2 = 1'b1;                     // E: 0 -> E, 1 -> D (Y2 = 1)
            3'b101: Y2 = (w == 1'b0) ? 1'b0 : 1'b0; // F: 0 -> C, 1 -> D (Y2 = 0)
            default: Y2 = 1'b0;
        endcase
    end

endmodule
