module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: begin // State A
                Y2 = 0;
            end
            3'b001: begin // State B
                if (w == 0)
                    Y2 = y[2]; // C
                else
                    Y2 = !y[2]; // D
            end
            3'b010: begin // State C
                if (w == 0)
                    Y2 = !y[2]; // E
                else
                    Y2 = !y[2]; // D
            end
            3'b011: begin // State D
                if (w == 0)
                    Y2 = !y[2]; // F
                else
                    Y2 = y[2]; // A
            end
            3'b100: begin // State E
                Y2 = 1;
            end
            3'b101: begin // State F
                if (w == 0)
                    Y2 = !y[2]; // C
                else
                    Y2 = !y[2]; // D
            end
            default: begin
                Y2 = 0;
            end
        endcase
    end
endmodule
