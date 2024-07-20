module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // State transition logic
    always @(in, state) begin
        case(state)
            10'b0000000001: next_state = 10'b0000000001; // S0 - 0 -> S0
            10'b0000000001: next_state = 10'b0000000010; // S0 - 1 -> S1
            10'b0000000010: next_state = 10'b0000000001; // S1 - 0 -> S0
            10'b0000000010: next_state = 10'b0000000011; // S1 - 1 -> S2
            10'b0000000011: next_state = 10'b0000000001; // S2 - 0 -> S0
            10'b0000000011: next_state = 10'b0000000100; // S2 - 1 -> S3
            10'b0000000100: next_state = 10'b0000000001; // S3 - 0 -> S0
            10'b0000000100: next_state = 10'b0000000101; // S3 - 1 -> S4
            10'b0000000101: next_state = 10'b0000000001; // S4 - 0 -> S0
            10'b0000000101: next_state = 10'b0000000110; // S4 - 1 -> S5
            10'b0000000110: next_state = 10'b0000001000; // S5 - 0 -> S8
            10'b0000000110: next_state = 10'b0000000111; // S5 - 1 -> S6
            10'b0000000111: next_state = 10'b0000001001; // S6 - 0 -> S9
            10'b0000000111: next_state = 10'b0000000111; // S6 - 1 -> S7
            10'b0000001000: next_state = 10'b0000000001; // S7 - 0 -> S0
            10'b0000001000: next_state = 10'b0000000111; // S7 - 1 -> S7
            10'b0000001001: next_state = 10'b0000000001; // S8 - 0 -> S0
            10'b0000001001: next_state = 10'b0000000010; // S8 - 1 -> S1
            10'b0000001010: next_state = 10'b0000000001; // S9 - 0 -> S0
            10'b0000001010: next_state = 10'b0000000010; // S9 - 1 -> S1
            default: next_state = 10'b0; // Default state
        endcase
    end

    // Output logic
    assign out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0; // Output 1 logic
    assign out2 = (state == 10'b0000000111) ? 1'b1 : 1'b0; // Output 2 logic

endmodule
