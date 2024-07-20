module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: Y2 = w; // A
        3'b001: Y2 = 1'b0; // B
        3'b010: Y2 = 1'b0; // C
        3'b011: Y2 = ~w; // D
        3'b100: Y2 = 1'b1; // E
        3'b101: Y2 = w; // F
        default: Y2 = 1'b0;
    endcase
end

endmodule
