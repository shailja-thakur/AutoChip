module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = w ? 1'b0 : 1'b0; // A (A = 000)
            3'b001: Y2 = w ? 1'b1 : 1'b0; // B (B = 001)
            3'b010: Y2 = w ? 1'b1 : 1'b1; // C (C = 010)
            3'b011: Y2 = w ? 1'b0 : 1'b1; // D (D = 011)
            3'b100: Y2 = w ? 1'b1 : 1'b0; // E (E = 100)
            3'b101: Y2 = w ? 1'b0 : 1'b0; // F (F = 101)
            default: Y2 = 1'b0;
        endcase
    end
endmodule
