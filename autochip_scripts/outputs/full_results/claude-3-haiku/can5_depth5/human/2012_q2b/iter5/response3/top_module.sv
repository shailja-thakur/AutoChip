module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    case (y)
        6'b000001: Y1 = w;       // State A
        6'b000010: Y1 = ~w;      // State B
        6'b001000: Y1 = ~w;      // State D
        default: Y1 = 1'b0;
    endcase
end

always @(*) begin
    case (y)
        6'b000010: Y3 = w;       // State B
        6'b000100: Y3 = ~w;      // State C
        6'b001000: Y3 = w;       // State D
        6'b100000: Y3 = ~w;      // State F
        default: Y3 = 1'b0;
    endcase
end

endmodule
