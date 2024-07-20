module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    reg [9:0] next_state;

    always @* begin
        case (state)
            10'b1_000_000_000: next_state = 10'b1_000_000_000;    // S0 -> S0
            10'b1_000_000_001: next_state = 10'b0_000_000_001;    // S0 -> S1
            10'b0_000_000_010: next_state = 10'b1_000_000_000;    // S1 -> S0
            10'b0_000_000_011: next_state = 10'b0_000_000_100;    // S1 -> S2
            10'b0_000_000_100: next_state = 10'b1_000_000_000;    // S2 -> S0
            10'b0_000_000_101: next_state = 10'b0_000_000_101;    // S2 -> S3
            10'b0_000_000_110: next_state = 10'b1_000_000_000;    // S3 -> S0
            10'b0_000_000_111: next_state = 10'b0_000_001_000;    // S3 -> S4
            10'b0_000_001_000: next_state = 10'b1_000_000_000;    // S4 -> S0
            10'b0_000_001_001: next_state = 10'b0_000_010_010;    // S4 -> S5
            10'b0_000_010_010: next_state = 10'b0_000_100_000;    // S5 -> S8
            10'b0_000_010_011: next_state = 10'b0_001_000_110;    // S5 -> S6
            10'b0_000_100_100: next_state = 10'b0_000_000_000;    // S6 -> S9
            10'b0_000_100_101: next_state = 10'b0_000_001_111;    // S6 -> S7
            10'b0_000_001_111: next_state = 10'b1_000_000_000;    // S7 -> S0
            10'b0_001_001_000: next_state = 10'b0_000_000_001;    // S7 -> S7
            10'b0_001_001_001: next_state = 10'b0_000_010_010;    // S8 -> S0
            10'b0_001_001_010: next_state = 10'b1_000_000_001;    // S8 -> S1
            10'b1_000_000_000: next_state = 10'b0_000_000_001;    // S9 -> S0
            10'b1_000_000_001: next_state = 10'b0_000_000_001;    // S9 -> S1
            default: next_state = state;                          // Any other state
        endcase
    end

    assign out1 = (state == 10'b0_000_100_101) ? 1'b1 : 1'b0;    // Output 1
    assign out2 = (state == 10'b1_000_001_111) ? 1'b1 : 1'b0;    // Output 2

endmodule
