module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    assign out1 = (state[9] & ~in) | (state[7] & state[9] & in);
    assign out2 = state[8] & state[9] & ~in;
    
    always @*
    begin
        case(state)
            10'b0000000001: next_state = 10'b0000000001; // S0
            10'b0000000010: next_state = 10'b0000000100; // S1
            10'b0000000100: next_state = 10'b0000000001; // S2
            10'b0000001000: next_state = 10'b0000010000; // S3
            10'b0000010000: next_state = 10'b0000000001; // S4
            10'b0000100000: next_state = 10'b0001000000; // S5
            10'b0001000000: next_state = 10'b0010000000; // S6
            10'b0010000000: next_state = 10'b0000000001; // S7
            10'b0100000000: next_state = 10'b0000000010; // S8
            10'b1000000000: next_state = 10'b0000000010; // S9
            default: next_state = 10'b0000000001; // Default state is S0
        endcase
    end
endmodule
