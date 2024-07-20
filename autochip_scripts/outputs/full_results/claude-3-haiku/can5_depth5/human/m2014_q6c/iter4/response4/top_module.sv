module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    // Next-state logic for y[2] (state B and state C)
    case (y)
        6'b000001: Y2 = ~w; // State A
        6'b000010: Y2 = w; // State B
        6'b000100: Y2 = ~w; // State C
        6'b001000: Y2 = w; // State D
        6'b010000: Y2 = 1'b0; // State E
        6'b100000: Y2 = ~w; // State F
        default: Y2 = 1'b0;
    endcase

    // Next-state logic for y[4] (state D and state E)
    case (y)
        6'b000001: Y4 = w; // State A
        6'b000010: Y4 = ~w; // State B
        6'b000100: Y4 = w; // State C
        6'b001000: Y4 = ~w; // State D
        6'b010000: Y4 = 1'b0; // State E
        6'b100000: Y4 = w; // State F
        default: Y4 = 1'b0;
    endcase
end

endmodule
