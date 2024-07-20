module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A, next state is A (000) or B (001)
            3'b001: Y2 = w ? 1'b1 : 1'b0; // State B, next state is D (011) or C (010)
            3'b010: Y2 = w ? 1'b1 : 1'b0; // State C, next state is D (011) or E (100)
            3'b011: Y2 = w ? 1'b0 : 1'b1; // State D, next state is A (000) or F (101)
            3'b100: Y2 = 1'b1; // State E, next state is D (011) or E (100)
            3'b101: Y2 = 1'b1; // State F, next state is D (011) or C (010)
            default: Y2 = 1'b0; // Default case
        endcase
    end
endmodule
