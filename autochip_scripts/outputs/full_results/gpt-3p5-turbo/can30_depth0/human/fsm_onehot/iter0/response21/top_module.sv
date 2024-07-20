module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // State transition logic
    always @(*)
    begin
        case (state)
            10'b0000000001: next_state = 10'b0000000010; // S0 -> S1
            10'b0000000010: next_state = 10'b0000000100; // S1 -> S2
            10'b0000000100: next_state = 10'b0000001000; // S2 -> S4
            10'b0000001000: next_state = 10'b0000000001; // S4 -> S0
            10'b0000010000: next_state = 10'b0000001000; // S5 -> S4
            10'b0000100000: next_state = 10'b0000001000; // S8 -> S4
            10'b0001000000: next_state = 10'b0000000001; // S9 -> S0
            default: next_state = 10'b0000000001; // Default transition is from any state to S0
        endcase
    end

    // Output logic
    assign out1 = (state == 10'b0000001110) ? 1'b0 : 1'b0; // Output is 0 for state S7
    assign out2 = (state == 10'b0000110000) ? 1'b1 : 1'b0; // Output is 1 for state S8

endmodule
