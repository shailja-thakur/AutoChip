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
        if (state[0]) next_state = in ? 10'b0000000010 : 10'b0000000001;  // S0
        else if (state[1]) next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
        else if (state[2]) next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
        else if (state[3]) next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
        else if (state[4]) next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
        else if (state[5]) next_state = in ? 10'b0001000000 : 10'b0000000001; // S5
        else if (state[6]) next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
        else if (state[7]) next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
        else if (state[8]) next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
        else if (state[9]) next_state = in ? 10'b0000000010 : 10'b0000000001; // S9

        // Output logic
        out1 = state[8] || state[9];
        out2 = state[7] || state[9];
    end
endmodule
