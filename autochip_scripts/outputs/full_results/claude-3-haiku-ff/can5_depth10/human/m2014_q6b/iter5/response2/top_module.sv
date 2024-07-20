module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: // State A
            Y2 = w ? 1'b1 : 1'b0;
        3'b001: // State B
            Y2 = w ? 1'b0 : 1'b1;
        3'b010: // State C
            Y2 = w ? 1'b1 : 1'b0;
        3'b011: // State D
            Y2 = w ? 1'b0 : 1'b0;
        3'b100: // State E
            Y2 = w ? 1'b0 : 1'b0;
        3'b101: // State F
            Y2 = w ? 1'b1 : 1'b1;
        default:
            Y2 = 1'bx; // Undefined state
    endcase
end

endmodule
