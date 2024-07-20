module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000, 3'b100: // States A and F
            Y2 = w;
        3'b001, 3'b011, 3'b101: // States B, D, and F
            Y2 = 1'b1;
        3'b010: // State C
            Y2 = 1'b0;
    endcase
end

endmodule
