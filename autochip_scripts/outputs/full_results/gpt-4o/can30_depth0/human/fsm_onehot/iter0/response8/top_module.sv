module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (1'b1)
            state[0]: begin
                if (in)
                    next_state[1] = 1'b1;
                else
                    next_state[0] = 1'b1;
            end
            state[1]: begin
                if (in)
                    next_state[2] = 1'b1;
                else
                    next_state[0] = 1'b1;
            end
            state[2]: begin
                if (in)
                    next_state[3] = 1'b1;
                else
                    next_state[0] = 1'b1;
            end
            state[3]: begin
                if (in)
                    next_state[4] = 1'b1;
                else
                    next_state[0] = 1'b1;
            end
            state[4]: begin
                if (in)
                    next_state[5] = 1'b1;
                else
                    next_state[0] = 1'b1;
            end
            state[5]: begin
                if (in)
                    next_state[6] = 1'b1;
                else
                    next_state[8] = 1'b1;
            end
            state[6]: begin
                if (in)
                    next_state[7] = 1'b1;
                else
                    next_state[9] = 1'b1;
            end
            state[7]: begin
                if (in)
                    next_state[7] = 1'b1;
                else
                    next_state[0] = 1'b1;
                out2 = 1;
            end
            state[8]: begin
                if (in)
                    next_state[1] = 1'b1;
                else
                    next_state[0] = 1'b1;
                out1 = 1;
            end
            state[9]: begin
                if (in)
                    next_state[1] = 1'b1;
                else
                    next_state[0] = 1'b1;
                out1 = 1;
                out2 = 1;
            end
            default: next_state = 10'b0000000000;
        endcase
    end

endmodule
