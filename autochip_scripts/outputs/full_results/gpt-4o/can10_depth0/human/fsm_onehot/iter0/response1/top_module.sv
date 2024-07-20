module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
  
    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (1'b1) // Synthesizing a one-hot state machine
            state[0]: begin
                if (in)
                    next_state = 10'b0000000010; // S0 to S1
                else
                    next_state = 10'b0000000001; // S0 to S0
            end
            state[1]: begin
                if (in)
                    next_state = 10'b0000000100; // S1 to S2
                else
                    next_state = 10'b0000000001; // S1 to S0
            end
            state[2]: begin
                if (in)
                    next_state = 10'b0000001000; // S2 to S3
                else
                    next_state = 10'b0000000001; // S2 to S0
            end
            state[3]: begin
                if (in)
                    next_state = 10'b0000010000; // S3 to S4
                else
                    next_state = 10'b0000000001; // S3 to S0
            end
            state[4]: begin
                if (in)
                    next_state = 10'b0000100000; // S4 to S5
                else
                    next_state = 10'b0000000001; // S4 to S0
            end
            state[5]: begin
                if (in)
                    next_state = 10'b0001000000; // S5 to S6
                else
                    next_state = 10'b1000000000; // S5 to S8
            end
            state[6]: begin
                if (in)
                    next_state = 10'b0010000000; // S6 to S7
                else
                    next_state = 10'b0100000000; // S6 to S9
            end
            state[7]: begin
                if (in)
                    next_state = 10'b0010000000; // S7 to S7
                else
                    next_state = 10'b0000000001; // S7 to S0
                out2 = 1;
            end
            state[8]: begin
                if (in)
                    next_state = 10'b0000000010; // S8 to S1
                else
                    next_state = 10'b0000000001; // S8 to S0
                out1 = 1;
            end
            state[9]: begin
                if (in)
                    next_state = 10'b0000000010; // S9 to S1
                else
                    next_state = 10'b0000000001; // S9 to S0
                out1 = 1;
                out2 = 1;
            end
            default: next_state = 10'b0000000000; // Default state to prevent latches
        endcase
    end
endmodule
