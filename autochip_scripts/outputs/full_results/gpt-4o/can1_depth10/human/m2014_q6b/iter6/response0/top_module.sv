module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = w ? 1'b0 : 1'b0; // State A: A (0) --1--> A, A (0) --0--> B
            3'b001: Y2 = w ? 1'b1 : 1'b0; // State B: B (0) --1--> D, B (0) --0--> C
            3'b010: Y2 = w ? 1'b1 : 1'b0; // State C: C (0) --1--> D, C (0) --0--> E
            3'b011: Y2 = w ? 1'b0 : 1'b1; // State D: D (0) --1--> A, D (0) --0--> F
            3'b100: Y2 = w ? 1'b1 : 1'b1; // State E: E (1) --1--> D, E (1) --0--> E
            3'b101: Y2 = w ? 1'b1 : 1'b0; // State F: F (1) --1--> D, F (1) --0--> C
            default: Y2 = 1'b0;
        endcase
    end

endmodule
