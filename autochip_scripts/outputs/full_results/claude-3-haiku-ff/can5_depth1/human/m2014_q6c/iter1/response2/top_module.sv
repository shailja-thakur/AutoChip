module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    // Next-state logic for y[2]
    case (y)
        6'b000001: Y2 = ~w;
        6'b000010: Y2 = ~w;
        6'b000100: Y2 = w;
        6'b001000: Y2 = ~w;
        6'b010000: Y2 = w;
        6'b100000: Y2 = w;
        default: Y2 = 1'bx;
    endcase

    // Next-state logic for y[4]
    case (y)
        6'b000001: Y4 = 1'b0;
        6'b000010: Y4 = w;
        6'b000100: Y4 = ~w;
        6'b001000: Y4 = w;
        6'b010000: Y4 = 1'b0;
        6'b100000: Y4 = w;
        default: Y4 = 1'bx;
    endcase
end

endmodule
