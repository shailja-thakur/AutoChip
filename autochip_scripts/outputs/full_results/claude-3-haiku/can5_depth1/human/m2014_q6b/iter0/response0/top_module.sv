module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000, 3'b011, 3'b101: // States A, D, F
            Y2 = w;
        3'b001, 3'b010, 3'b100: // States B, C, E
            Y2 = ~w;
        default:
            Y2 = 1'bx; // Undefined behavior
    endcase
end

endmodule
