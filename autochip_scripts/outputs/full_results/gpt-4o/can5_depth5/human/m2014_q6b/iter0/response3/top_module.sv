module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A (000)
            3'b001: Y2 = w;    // State B (001)
            3'b010: Y2 = 1'b1; // State C (010)
            3'b011: Y2 = y[1]; // State D (011)
            3'b100: Y2 = 1'b1; // State E (100)
            3'b101: Y2 = ~w;   // State F (101)
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
