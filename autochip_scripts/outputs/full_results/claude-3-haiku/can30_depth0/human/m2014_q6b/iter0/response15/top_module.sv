module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: // state A
            Y2 = w;
        3'b001: // state B
            Y2 = 1'b0;
        3'b010: // state C
            Y2 = 1'b0;
        3'b011: // state D
            Y2 = w;
        3'b100: // state E
            Y2 = 1'b1;
        3'b101: // state F
            Y2 = 1'b0;
        default:
            Y2 = 1'bx;
    endcase
end

endmodule
