module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0;             // State A: Next state is 0 for both transitions
            3'b001: Y2 = w ? 1'b1 : 1'b0;  // State B: Next state depends on input w
            3'b010: Y2 = 1'b1;             // State C: Next state is 1 for both transitions
            3'b011: Y2 = w ? 1'b0 : 1'b1;  // State D: Next state depends on input w
            3'b100: Y2 = 1'b0;             // State E: Next state is 0 for both transitions
            3'b101: Y2 = w ? 1'b0 : 1'b0;  // State F: Next state is 0 for both transitions (effectively 0 regardless)
            default: Y2 = 1'b0;            // Default case for safety
        endcase
    end
endmodule
