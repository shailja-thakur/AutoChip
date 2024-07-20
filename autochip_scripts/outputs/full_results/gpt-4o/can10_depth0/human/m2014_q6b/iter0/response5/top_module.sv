module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0;         // A -> B or A
            3'b001: Y2 = w ? 1'b1 : 1'b0; // B -> D or C
            3'b010: Y2 = 1'b1;         // C -> D
            3'b011: Y2 = w ? 1'b0 : 1'b1; // D -> A or F
            3'b100: Y2 = 1'b1;         // E -> D
            3'b101: Y2 = 1'b0;         // F -> C
            default: Y2 = 1'b0;        // default case
        endcase
    end

endmodule
