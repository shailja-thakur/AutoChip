module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

    always @* begin
        case(y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: Y2 = y[1] & ~w; // State B
            3'b010: Y2 = y[1]; // State C
            3'b011: Y2 = y[1]; // State D
            3'b100: Y2 = ~w; // State E
            3'b101: Y2 = y[0]; // State F
            default: Y2 = 1'b0;
        endcase
    end

endmodule
