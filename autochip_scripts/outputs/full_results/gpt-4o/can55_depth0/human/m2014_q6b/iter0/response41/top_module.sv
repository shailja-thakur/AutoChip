module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);
    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // State A
            3'b001: // State B
                if (w == 0)
                    Y2 = 1;
                else
                    Y2 = 0;
            3'b010: // State C
                if (w == 0)
                    Y2 = 1;
                else
                    Y2 = 1;
            3'b011: // State D
                if (w == 0)
                    Y2 = 1;
                else
                    Y2 = 0;
            3'b100: Y2 = 1; // State E
            3'b101: // State F
                if (w == 0)
                    Y2 = 0;
                else
                    Y2 = 1;
            default: Y2 = 0;
        endcase
    end
endmodule
