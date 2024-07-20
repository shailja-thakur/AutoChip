module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A: Y[2] = 0
            3'b001: Y2 = w ? 1'b1 : 1'b0; // State B: Depends on w
            3'b010: Y2 = 1'b1; // State C: Y[2] = 1
            3'b011: Y2 = w ? 1'b0 : 1'b1; // State D: Depends on w
            3'b100: Y2 = 1'b1; // State E: Y[2] = 1
            3'b101: Y2 = 1'b1; // State F: Y[2] = 1
            default: Y2 = 1'b0;
        endcase
    end

endmodule
