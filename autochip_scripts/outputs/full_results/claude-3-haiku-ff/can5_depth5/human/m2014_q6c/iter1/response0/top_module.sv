module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    // Derive the next-state logic for y[2] and y[4]
    case (y)
        6'b000001: // State A
            begin
                Y2 = ~w;
                Y4 = 1'b0;
            end
        6'b000010: // State B
            begin
                Y2 = ~w;
                Y4 = w;
            end
        6'b000100: // State C
            begin
                Y2 = w;
                Y4 = ~w;
            end
        6'b001000: // State D
            begin
                Y2 = w;
                Y4 = w;
            end
        6'b010000: // State E
            begin
                Y2 = 1'b0;
                Y4 = w;
            end
        6'b100000: // State F
            begin
                Y2 = ~w;
                Y4 = w;
            end
        default:
            begin
                Y2 = 1'bx;
                Y4 = 1'bx;
            end
    endcase
end

endmodule
