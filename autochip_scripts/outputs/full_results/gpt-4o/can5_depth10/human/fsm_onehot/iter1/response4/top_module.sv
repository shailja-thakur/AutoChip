module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default next_state and outputs
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        // State transitions
        case (state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b0000000001; // S5
            10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
            10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
            10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
            10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
            default: next_state = 10'b0000000001; // Default to S0 on invalid state
        endcase

        // Output logic
        out1 = state[8] || state[9];
        out2 = state[7] || state[9];
    end
endmodule
