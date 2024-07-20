module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // State Transition Logic
    always @*
        case (state)
            10'b1_0000_0000: next_state = 10'b1_0000_0000; // S0 --> S0 (0)
            10'b1_0000_0001: next_state = 10'b0_0000_0010; // S0 --> S1 (1)
            10'b0_0000_0010: next_state = 10'b1_0000_0000; // S1 --> S0 (0)
            10'b0_0000_0011: next_state = 10'b0_0000_0100; // S1 --> S2 (1)
            10'b0_0000_0100: next_state = 10'b1_0000_0000; // S2 --> S0 (0)
            10'b0_0000_0101: next_state = 10'b0_0000_0110; // S2 --> S3 (1)
            10'b0_0000_0110: next_state = 10'b1_0000_0000; // S3 --> S0 (0)
            10'b0_0000_0111: next_state = 10'b0_0000_1000; // S3 --> S4 (1)
            10'b0_0000_1000: next_state = 10'b1_0000_0000; // S4 --> S0 (0)
            10'b0_0000_1001: next_state = 10'b0_0000_1010; // S4 --> S5 (1)
            10'b0_0000_1010: next_state = 10'b0_0001_0000; // S5 --> S8 (0)
            10'b0_0000_1011: next_state = 10'b0_0000_1100; // S5 --> S6 (1)
            10'b0_0000_1100: next_state = 10'b0_0010_0000; // S6 --> S9 (0)
            10'b0_0000_1101: next_state = 10'b0_0000_1110; // S6 --> S7 (1)
            10'b0_0000_1110: next_state = 10'b1_0000_0000; // S7 --> S0 (0)
            10'b0_0000_1111: next_state = 10'b0_0010_0000; // S7 --> S7 (1)
            10'b0_0001_0000: next_state = 10'b1_0000_0000; // S8 --> S0 (0)
            10'b0_0001_0001: next_state = 10'b0_0000_0010; // S8 --> S1 (1)
            10'b0_0010_0000: next_state = 10'b1_0000_0000; // S9 --> S0 (0)
            10'b0_0010_0001: next_state = 10'b0_0000_0010; // S9 --> S1 (1)
            default: next_state = 10'b1_0000_0000; // Default case
        endcase
    
    // Output Logic
    assign out1 = (state == 10'b0_0000_1110 || state == 10'b0_0000_1111 || state == 10'b0_0010_0000) ? 1'b1 : 1'b0;
    assign out2 = (state == 10'b0_0000_1110) ? 1'b1 : 1'b0;
    
endmodule
