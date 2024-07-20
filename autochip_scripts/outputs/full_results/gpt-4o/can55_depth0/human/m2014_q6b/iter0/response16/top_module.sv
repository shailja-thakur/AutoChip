module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0;              // A -> y = 000
            3'b001: Y2 = w ? 1 : 0;      // B -> y = 001
            3'b010: Y2 = 1;              // C -> y = 010
            3'b011: Y2 = 0;              // D -> y = 011
            3'b100: Y2 = 1;              // E -> y = 100
            3'b101: Y2 = 1;              // F -> y = 101
            default: Y2 = 0;             // Default case
        endcase
    end

endmodule
