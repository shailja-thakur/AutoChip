module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

// Signal Y1 (input of state flip-flop y[1])
always @(*) begin
    case (y)
        6'b000001: Y1 = w; // State A
        6'b000010: Y1 = ~w; // State B
        6'b000100: Y1 = ~w; // State C
        6'b001000: Y1 = w; // State D
        6'b010000: Y1 = w; // State E
        6'b100000: Y1 = ~w; // State F
        default: Y1 = 1'bx;
    endcase
end

// Signal Y3 (input of state flip-flop y[3])
always @(*) begin
    case (y)
        6'b000001: Y3 = 1'b0; // State A
        6'b000010: Y3 = w; // State B
        6'b000100: Y3 = ~w; // State C
        6'b001000: Y3 = w; // State D
        6'b010000: Y3 = 1'b0; // State E
        6'b100000: Y3 = w; // State F
        default: Y3 = 1'bx;
    endcase
end

endmodule
