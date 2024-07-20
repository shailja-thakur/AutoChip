module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(y or w) begin
        case(y)
            3'b000: begin // state A
                if (w)
                    Y2 = 1'b0; // go to state A
                else
                    Y2 = 1'b1; // go to state B
            end
            3'b001: begin // state B
                if (w)
                    Y2 = 1'b0; // go to state C
                else
                    Y2 = 1'b1; // go to state D
            end
            3'b010: begin // state C
                if (w)
                    Y2 = 1'b1; // go to state E
                else
                    Y2 = 1'b1; // go to state D
            end
            3'b011: begin // state D
                if (w)
                    Y2 = 1'b0; // go to state F
                else
                    Y2 = 1'b0; // go to state A
            end
            3'b100: begin // state E
                if (w)
                    Y2 = 1'b0; // go to state E
                else
                    Y2 = 1'b1; // go to state D
            end
            3'b101: begin // state F
                if (w)
                    Y2 = 1'b1; // go to state C
                else
                    Y2 = 1'b0; // go to state D
            end
            default: Y2 = 1'b0;
        endcase
    end

endmodule
