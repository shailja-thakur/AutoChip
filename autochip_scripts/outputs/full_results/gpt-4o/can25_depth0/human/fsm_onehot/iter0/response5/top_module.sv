module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);
    
    always @(*) begin
        // Default values for next_state and outputs
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;
        
        // State transition logic
        case (1'b1) // exploit one-hot encoding to simplify the case statement
            state[0]: next_state = (in) ? 10'b0000000010 : 10'b0000000001;
            state[1]: next_state = (in) ? 10'b0000000100 : 10'b0000000001;
            state[2]: next_state = (in) ? 10'b0000001000 : 10'b0000000001;
            state[3]: next_state = (in) ? 10'b0000010000 : 10'b0000000001;
            state[4]: next_state = (in) ? 10'b0000100000 : 10'b0000000001;
            state[5]: next_state = (in) ? 10'b0001000000 : 10'b0000001000;
            state[6]: next_state = (in) ? 10'b0010000000 : 10'b0000000010;
            state[7]: next_state = (in) ? 10'b0100000000 : 10'b0000000001;
            state[8]: next_state = (in) ? 10'b0000000010 : 10'b0000100000;
            state[9]: next_state = (in) ? 10'b0000000010 : 10'b0000000001;
            default: next_state = 10'b0000000001; // Return to S0 if no valid state is found.
        endcase

        // Output logic
        out1 = state[8] | state[9];
        out2 = state[7] | state[9];
    end
endmodule
