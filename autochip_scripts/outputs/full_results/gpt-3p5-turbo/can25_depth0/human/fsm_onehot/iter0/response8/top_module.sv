module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Combinational circuit for next_state

    always @(*) begin
        case(state)
            10'b0000000001: next_state = 10'b0000000001; // S0 -> S0 when input is 0
            10'b0000000001: next_state = 10'b0000000010; // S0 -> S1 when input is 1
            10'b0000000010: next_state = 10'b0000000001; // S1 -> S0 when input is 0
            10'b0000000010: next_state = 10'b0000000100; // S1 -> S2 when input is 1
            10'b0000000100: next_state = 10'b0000000001; // S2 -> S0 when input is 0
            10'b0000000100: next_state = 10'b0000001000; // S2 -> S3 when input is 1
            10'b0000001000: next_state = 10'b0000000001; // S3 -> S0 when input is 0
            10'b0000001000: next_state = 10'b0000010000; // S3 -> S4 when input is 1
            10'b0000010000: next_state = 10'b0000000001; // S4 -> S0 when input is 0
            10'b0000010000: next_state = 10'b0000100000; // S4 -> S5 when input is 1
            10'b0000100000: next_state = 10'b1000000000; // S5 -> S8 when input is 0
            10'b0000100000: next_state = 10'b0001000000; // S5 -> S6 when input is 1
            10'b0001000000: next_state = 10'b0010000000; // S6 -> S9 when input is 0
            10'b0001000000: next_state = 10'b0000010000; // S6 -> S7 when input is 1
            10'b0000010000: next_state = 10'b0000000001; // S7 -> S0 when input is 0
            10'b0000010000: next_state = 10'b0000001000; // S7 -> S7 when input is 1
            10'b1000000000: next_state = 10'b0000000001; // S8 -> S0 when input is 0
            10'b1000000000: next_state = 10'b0000000010; // S8 -> S1 when input is 1
            10'b0010000000: next_state = 10'b0000000001; // S9 -> S0 when input is 0
            10'b0010000000: next_state = 10'b0000000010; // S9 -> S1 when input is 1
            default: next_state = 10'b0000000000; // default to all zeros for unknown states
        endcase
    end

    // Combinational circuit for outputs

    assign out1 = (state[7] && ~state[9]) || state[8]; // Output logic for out1
    assign out2 = state[6]; // Output logic for out2

endmodule
