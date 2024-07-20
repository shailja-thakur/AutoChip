module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: Y2 = w;     // state A
        3'b001: Y2 = 1'b0;  // state B
        3'b010: Y2 = 1'b0;  // state C
        3'b011: Y2 = w;     // state D
        3'b100: Y2 = 1'b1;  // state E
        3'b101: Y2 = 1'b1;  // state F
        default: Y2 = 1'bx;
    endcase
end

endmodule
