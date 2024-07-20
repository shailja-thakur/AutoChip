module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A (y[3:1] = 000)
            3'b001: Y2 = w ? 1'b1 : 1'b0; // State B (y[3:1] = 001)
            3'b010: Y2 = 1'b0; // State C (y[3:1] = 010)
            3'b011: Y2 = 1'b0; // State D (y[3:1] = 011)
            3'b100: Y2 = 1'b1; // State E (y[3:1] = 100)
            3'b101: Y2 = w ? 1'b1 : 1'b0; // State F (y[3:1] = 101)
            default: Y2 = 1'b0;
        endcase
    end

endmodule
