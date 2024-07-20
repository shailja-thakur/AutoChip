module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
    
    always @(*) begin
        // Default outputs
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (1'b1) // Synthesize with a one-hot encoding assumption
            state[0]: begin
                if (in)
                    next_state = 10'b0000000010; // Transition to S1
                else
                    next_state = 10'b0000000001; // Stay in S0
            end
            state[1]: begin
                if (in)
                    next_state = 10'b0000000100; // Transition to S2
                else
                    next_state = 10'b0000000001; // Transition to S0
            end
            state[2]: begin
                if (in)
                    next_state = 10'b0000001000; // Transition to S3
                else
                    next_state = 10'b0000000001; // Transition to S0
            end
            state[3]: begin
                if (in)
                    next_state = 10'b0000010000; // Transition to S4
                else
                    next_state = 10'b0000000001; // Transition to S0
            end
            state[4]: begin
                if (in)
                    next_state = 10'b0000100000; // Transition to S5
                else
                    next_state = 10'b0000000001; // Transition to S0
            end
            state[5]: begin
                if (in)
                    next_state = 10'b0001000000; // Transition to S6
                else
                    next_state = 10'b1000000000; // Transition to S8
            end
            state[6]: begin
                if (in)
                    next_state = 10'b0010000000; // Transition to S7
                else
                    next_state = 10'b0100000000; // Transition to S9
            end
            state[7]: begin
                if (in)
                    next_state = 10'b0010000000; // Stay in S7
                else
                    next_state = 10'b0000000001; // Transition to S0
                out2 = 1;
            end
            state[8]: begin
                if (in)
                    next_state = 10'b0000000010; // Transition to S1
                else
                    next_state = 10'b0000000001; // Transition to S0
                out1 = 1;
            end
            state[9]: begin
                if (in)
                    next_state = 10'b0000000010; // Transition to S1
                else
                    next_state = 10'b0000000001; // Transition to S0
                out1 = 1;
                out2 = 1;
            end
            default: begin
                next_state = 10'b0000000001; // Default to S0
            end
        endcase
    end
endmodule
