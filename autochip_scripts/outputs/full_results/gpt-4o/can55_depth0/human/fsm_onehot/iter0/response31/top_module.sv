module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    always @(*) begin
        // Initialize next_state and outputs to their default values
        next_state = 10'b0;
        out1 = 1'b0;
        out2 = 1'b0;

        case (1'b1) // Synthesize a one-hot encoded state machine
            state[0]: begin
                if (in)
                    next_state[1] = 1'b1; // Transition to S1
                else
                    next_state[0] = 1'b1; // Stay in S0
            end
            state[1]: begin
                if (in)
                    next_state[2] = 1'b1; // Transition to S2
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[2]: begin
                if (in)
                    next_state[3] = 1'b1; // Transition to S3
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[3]: begin
                if (in)
                    next_state[4] = 1'b1; // Transition to S4
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[4]: begin
                if (in)
                    next_state[5] = 1'b1; // Transition to S5
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[5]: begin
                if (in)
                    next_state[6] = 1'b1; // Transition to S6
                else
                    next_state[8] = 1'b1; // Transition to S8
            end
            state[6]: begin
                if (in)
                    next_state[7] = 1'b1; // Transition to S7
                else
                    next_state[9] = 1'b1; // Transition to S9
            end
            state[7]: begin
                out2 = 1'b1; // S7 output out2 = 1
                if (in)
                    next_state[7] = 1'b1; // Stay in S7
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[8]: begin
                out1 = 1'b1; // S8 output out1 = 1
                if (in)
                    next_state[1] = 1'b1; // Transition to S1
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            state[9]: begin
                out1 = 1'b1; // S9 output out1 = 1
                out2 = 1'b1; // S9 output out2 = 1
                if (in)
                    next_state[1] = 1'b1; // Transition to S1
                else
                    next_state[0] = 1'b1; // Transition to S0
            end
            default: begin
                next_state = 10'b0; // Default to no state active
            end
        endcase
    end

endmodule
