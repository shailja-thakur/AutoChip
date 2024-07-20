module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
    );

    assign out1 = (state[7] && !state[9]) || (state[8] && in);
    assign out2 = state[7] && state[9];
    
    always @(state or in) begin
        case(state)
            
            10'b0000000001: next_state = 10'b0000000001; // S0 -> S0 (0 -> 0)
            10'b0000000001: next_state = 10'b0000000010; // S0 -> S1 (1 -> 0)
            10'b0000000010: next_state = 10'b0000000001; // S1 -> S0 (0 -> 0)
            10'b0000000010: next_state = 10'b0000000100; // S1 -> S2 (1 -> 0)
            10'b0000000100: next_state = 10'b0000000001; // S2 -> S0 (0 -> 0)
            10'b0000000100: next_state = 10'b0000000111; // S2 -> S3 (1 -> 0)
            10'b0000000111: next_state = 10'b0000000001; // S3 -> S0 (0 -> 0)
            10'b0000000111: next_state = 10'b0000001001; // S3 -> S4 (1 -> 0)
            10'b0000001001: next_state = 10'b0000000001; // S4 -> S0 (0 -> 0)
            10'b0000001001: next_state = 10'b0000001010; // S4 -> S5 (1 -> 0)
            10'b0000001010: next_state = 10'b0000010000; // S5 -> S8 (0 -> 1)
            10'b0000001010: next_state = 10'b0000010011; // S5 -> S6 (1 -> 0)
            10'b0000010011: next_state = 10'b0000011000; // S6 -> S9 (0 -> 1)
            10'b0000010011: next_state = 10'b0000011001; // S6 -> S7 (1 -> 1)
            10'b0000011001: next_state = 10'b0000000001; // S7 -> S0 (0 -> 0)
            10'b0000011001: next_state = 10'b0000011001; // S7 -> S7 (1 -> 1)
            10'b0000010000: next_state = 10'b0000000001; // S8 -> S0 (0 -> 0)
            10'b0000010000: next_state = 10'b0000000010; // S8 -> S1 (1 -> 0)
            10'b0000011000: next_state = 10'b0000000001; // S9 -> S0 (0 -> 0)
            10'b0000011000: next_state = 10'b0000000010; // S9 -> S1 (1 -> 0)
            
            default: next_state = 10'b0000000000; // default case for invalid inputs
            
        endcase
    end
    
endmodule
