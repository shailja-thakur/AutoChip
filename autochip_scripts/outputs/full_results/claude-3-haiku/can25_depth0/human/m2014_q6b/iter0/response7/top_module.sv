module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000, 3'b100: // A, E
            Y2 = w;
        3'b001: // B
            Y2 = ~w;
        3'b010: // C
            Y2 = 1'b0;
        3'b011: // D
            Y2 = w;
        3'b101: // F
            Y2 = ~w;
        default:
            Y2 = 1'bx; // Should not reach this case
    endcase
end

endmodule
