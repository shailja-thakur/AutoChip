module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
    
    always @(*) begin
        case (state)
            10'b0000000001: begin // S0
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0000000010: begin // S1
                if (in)
                    next_state = 10'b0000000100; // S2
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0000000100: begin // S2
                if (in)
                    next_state = 10'b0000001000; // S3
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0000001000: begin // S3
                if (in)
                    next_state = 10'b0000010000; // S4
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0000010000: begin // S4
                if (in)
                    next_state = 10'b0000100000; // S5
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0000100000: begin // S5
                if (in)
                    next_state = 10'b0001000000; // S6
                else
                    next_state = 10'b1000000000; // S8
            end
            10'b0001000000: begin // S6
                if (in)
                    next_state = 10'b0010000000; // S7
                else
                    next_state = 10'b0100000000; // S9
            end
            10'b0010000000: begin // S7
                if (in)
                    next_state = 10'b0010000000; // S7
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b0100000000: begin // S8
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            end
            10'b1000000000: begin // S9
                if (in)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            end
            default: begin
                next_state = 10'b0000000001; // default to S0
            end
        endcase
        
        // Default outputs
        out1 = 0;
        out2 = 0;
        
        // Output logic based on current state
        if (state[7]) begin // S7
            out2 = 1;
        end
        if (state[8]) begin // S8
            out1 = 1;
        end
        if (state[9]) begin // S9
            out1 = 1;
            out2 = 1;
        end
    end
endmodule
