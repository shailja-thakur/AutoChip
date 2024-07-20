module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default outputs
        out1 = 0;
        out2 = 0;
        
        // Default next state
        next_state = 10'b0;
        
        case (1'b1) // Synthesis tool identifies the state by use of "casez" and "case (1)"
            state[0]: begin
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            end
            state[1]: begin
                if (in)
                    next_state = 10'b0000000100; // S2
                else
                    next_state = 10'b0000000001; // S0
            end
            state[2]: begin
                if (in)
                    next_state = 10'b0000001000; // S3
                else
                    next_state = 10'b0000000001; // S0
            end
            state[3]: begin
                if (in)
                    next_state = 10'b0000010000; // S4
                else
                    next_state = 10'b0000000001; // S0
            end
            state[4]: begin
                if (in)
                    next_state = 10'b0000100000; // S5
                else
                    next_state = 10'b0000000001; // S0
            end
            state[5]: begin
                if (in)
                    next_state = 10'b0001000000; // S6
                else{
                    next_state = 10'b1000000000; // S8
                    out1 = 1; // Output for S8
                }
            end
            state[6]: begin
                if (in)
                    next_state = 10'b0010000000; // S7
                else{
                    next_state = 10'b0100000000; // S9
                    out1 = 1; // Output for S9
                    out2 = 1; // Output for S9
                }
            end
            state[7]: begin
                if (in)
                    next_state = 10'b0010000000; // S7
                else{
                    next_state = 10'b0000000001; // S0
                    out2 = 1; // Output for S7
                }
            end
            state[8]: begin
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
                out1 = 1; // Output for S8
            end
            state[9]: begin
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
                out1 = 1; // Output for S9
                out2 = 1; // Output for S9
            end
            default: next_state = 10'b0000000001; // Go to S0 if undefined state
        endcase
    end

endmodule
