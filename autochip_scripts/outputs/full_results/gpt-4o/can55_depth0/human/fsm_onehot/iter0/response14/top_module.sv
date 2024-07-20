module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (state)
            10'b0000000001: // S0
                if (in) next_state = 10'b0000000010; // to S1
                else next_state = 10'b0000000001; // stay in S0
            10'b0000000010: // S1
                if (in) next_state = 10'b0000000100; // to S2
                else next_state = 10'b0000000001; // to S0
            10'b0000000100: // S2
                if (in) next_state = 10'b0000001000; // to S3
                else next_state = 10'b0000000001; // to S0
            10'b0000001000: // S3
                if (in) next_state = 10'b0000010000; // to S4
                else next_state = 10'b0000000001; // to S0
            10'b0000010000: // S4
                if (in) next_state = 10'b0000100000; // to S5
                else next_state = 10'b0000000001; // to S0
            10'b0000100000: // S5
                if (in) next_state = 10'b0001000000; // to S6
                else next_state = 10'b0100000000; // to S8
            10'b0001000000: // S6
                if (in) next_state = 10'b0010000000; // to S7
                else next_state = 10'b1000000000; // to S9
            10'b0010000000: // S7
                begin
                    next_state = in ? 10'b0010000000 : 10'b0000000001; // to S7 or S0
                    out2 = 1; // output (0, 1)
                end
            10'b0100000000: // S8
                begin
                    next_state = in ? 10'b0000000010 : 10'b0000000001; // to S1 or S0
                    out1 = 1; // output (1, 0)
                end
            10'b1000000000: // S9
                begin
                    next_state = in ? 10'b0000000010 : 10'b0000000001; // to S1 or S0
                    out1 = 1;
                    out2 = 1; // output (1, 1)
                end
            default: next_state = 10'b0000000001; // to S0 by default or reset
        endcase
    end
endmodule
