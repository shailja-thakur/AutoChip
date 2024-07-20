module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    // Derive the logic for Y1 and Y3 based on the state machine diagram and the given one-hot encoding
    case (y)
        6'b000001: // State A
            begin
                Y1 = ~w;
                Y3 = 1'b0;
            end
        6'b000010: // State B
            begin
                Y1 = w;
                Y3 = ~w;
            end
        6'b000100: // State C
            begin
                Y1 = w;
                Y3 = ~w;
            end
        6'b001000: // State D
            begin
                Y1 = ~w;
                Y3 = ~w;
            end
        6'b010000: // State E
            begin
                Y1 = w;
                Y3 = 1'b0;
            end
        6'b100000: // State F
            begin
                Y1 = w;
                Y3 = ~w;
            end
        default:
            begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
    endcase
end

endmodule
