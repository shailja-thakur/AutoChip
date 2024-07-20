module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default output values
        out1 = 0;
        out2 = 0;
        
        // Default next state value
        next_state = 10'b0000000000;
        
        // State transitions and output logic
        case (state)
            10'b0000000001: begin // S0
                if (in) 
                    next_state = 10'b0000000010; // Transition from S0 to S1
                else 
                    next_state = 10'b0000000001; // Remain in S0
            end

            10'b0000000010: begin // S1
                if (in) 
                    next_state = 10'b0000000100; // Transition from S1 to S2
                else 
                    next_state = 10'b0000000001; // Transition from S1 to S0
            end

            10'b0000000100: begin // S2
                if (in) 
                    next_state = 10'b0000001000; // Transition from S2 to S3
                else 
                    next_state = 10'b0000000001; // Transition from S2 to S0
            end

            10'b0000001000: begin // S3
                if (in) 
                    next_state = 10'b0000010000; // Transition from S3 to S4
                else 
                    next_state = 10'b0000000001; // Transition from S3 to S0
            end

            10'b0000010000: begin // S4
                if (in) 
                    next_state = 10'b0000100000; // Transition from S4 to S5
                else 
                    next_state = 10'b0000000001; // Transition from S4 to S0
            end

            10'b0000100000: begin // S5
                if (in) 
                    next_state = 10'b0001000000; // Transition from S5 to S6
                else 
                    next_state = 10'b1000000000; // Transition from S5 to S8
            end

            10'b0001000000: begin // S6
                if (in) 
                    next_state = 10'b0010000000; // Transition from S6 to S7
                else 
                    next_state = 10'b0100000000; // Transition from S6 to S9
            end

            10'b0010000000: begin // S7
                if (in) 
                    next_state = 10'b0010000000; // Remain in S7
                else 
                    next_state = 10'b0000000001; // Transition from S7 to S0

                // Output for S7
                out2 = 1;
            end

            10'b0100000000: begin // S8
                if (in) 
                    next_state = 10'b0000000010; // Transition from S8 to S1
                else 
                    next_state = 10'b0000000001; // Transition from S8 to S0

                // Output for S8
                out1 = 1;
            end

            10'b1000000000: begin // S9
                if (in) 
                    next_state = 10'b0000000010; // Transition from S9 to S1
                else 
                    next_state = 10'b0000000001; // Transition from S9 to S0

                // Output for S9
                out1 = 1;
                out2 = 1;
            end

            default: 
                next_state = 10'b0000000001; // Default to S0 if in an invalid state
        endcase
    end
endmodule
