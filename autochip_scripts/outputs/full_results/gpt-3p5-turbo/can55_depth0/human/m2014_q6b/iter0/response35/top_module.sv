module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(y or w) begin
        case(y)
            3'b000: begin // State A
                if (w)
                    Y2 = 1'b0; // Next state is B
                else
                    Y2 = 1'b0; // Next state is A
            end
            3'b001: begin // State B
                if (w)
                    Y2 = 1'b0; // Next state is C
                else
                    Y2 = 1'b1; // Next state is D
            end
            3'b010: begin // State C
                if (w)
                    Y2 = 1'b0; // Next state is E
                else
                    Y2 = 1'b1; // Next state is D
            end
            3'b011: begin // State D
                if (w)
                    Y2 = 1'b0; // Next state is F
                else
                    Y2 = 1'b0; // Next state is A
            end
            3'b100: begin // State E
                if (w)
                    Y2 = 1'b1; // Next state is E
                else
                    Y2 = 1'b1; // Next state is D
            end
            3'b101: begin // State F
                if (w)
                    Y2 = 1'b1; // Next state is C
                else
                    Y2 = 1'b0; // Next state is D
            end
            default: Y2 = 1'b0;
        endcase
    end
endmodule
