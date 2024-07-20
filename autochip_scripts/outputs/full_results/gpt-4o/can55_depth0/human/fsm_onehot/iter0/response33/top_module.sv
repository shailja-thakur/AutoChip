module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values for next_state, out1, and out2
        next_state = 10'b0;
        out1 = 1'b0;
        out2 = 1'b0;

        // State transitions based on the current state and input
        case (state)
            10'b0000000001: // S0
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000000010; // S1

            10'b0000000010: // S1
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000000100; // S2

            10'b0000000100: // S2
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000001000; // S3

            10'b0000001000: // S3
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000010000; // S4

            10'b0000010000: // S4
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000100000; // S5

            10'b0000100000: // S5
                if (in == 1'b0)
                    next_state = 10'b1000000000; // S8
                else
                    next_state = 10'b0001000000; // S6

            10'b0001000000: // S6
                if (in == 1'b0)
                    next_state = 10'b1000000001; // S9
                else
                    next_state = 10'b0010000000; // S7

            10'b0010000000: // S7
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0010000000; // S7
                out2 = 1'b1; // S7 output

            10'b0100000000: // S8
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000000010; // S1
                out1 = 1'b1; // S8 output

            10'b1000000000: // S9
                if (in == 1'b0)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000000010; // S1
                out1 = 1'b1; // S9 output
                out2 = 1'b1; // S9 output

            default: // Default case in case of invalid state
                next_state = 10'b0000000001; // Assume reset to S0
        endcase
    end
endmodule
