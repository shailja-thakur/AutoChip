module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output reg out1,
    output reg out2
);
    always @(*) begin
        // Default outputs to zero
        out1 = 0;
        out2 = 0;

        // Default next state to all zeros
        next_state = 10'b0000000000;

        case (state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0 to S0 or S1
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1 to S0 or S2
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2 to S0 or S3
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3 to S0 or S4
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4 to S0 or S5
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5 to S8 or S6
            10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6 to S9 or S7
            10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7 to S0 or S7
            10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8 to S0 or S1
            10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9 to S0 or S1
            default: next_state = 10'b0000000001; // Default to S0
        endcase

        // Set outputs based on state
        if (state[7]) begin
            out2 = 1; // S7 sets out2 to 1
        end
        if (state[8]) begin
            out1 = 1; // S8 sets out1 to 1
        end
        if (state[9]) begin
            out1 = 1; out2 = 1; // S9 sets out1 and out2 to 1
        end
    end
endmodule
