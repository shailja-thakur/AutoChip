module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A: y = 000
            3'b001: Y2 = w;    // State B: y = 001
            3'b010: Y2 = 1'b0; // State C: y = 010
            3'b011: Y2 = w;    // State D: y = 011
            3'b100: Y2 = 1'b1; // State E: y = 100
            3'b101: Y2 = 1'b0; // State F: y = 101
            default: Y2 = 1'b0; // Default case to handle any invalid state
        endcase
    end
endmodule
