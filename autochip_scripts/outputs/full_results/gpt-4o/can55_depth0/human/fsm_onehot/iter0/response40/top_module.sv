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
        next_state = 10'b0; // Default next state to 0

        // State transition logic
        case (1)
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0 -> S1 : S0
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1 -> S2 : S0
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2 -> S3 : S0
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3 -> S4 : S0
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4 -> S5 : S0
            state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5 -> S6 : S8
            state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6 -> S7 : S9
            state[7]: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7 -> S7 : S0
            state[8]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8 -> S1 : S0
            state[9]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9 -> S1 : S0
            default: next_state = 10'b0000000001; // Default state S0
        endcase

        // Output logic
        out1 = state[8] | state[9]; // Out1 is 1 in states S8 and S9
        out2 = state[7] | state[9]; // Out2 is 1 in states S7 and S9
    end

endmodule
