module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

    assign out1 = (state[7] & ~state[6]) | state[8];
    assign out2 = state[6];
  
    always @(state or in) begin
        case (state)
            10'b0000000001: // S0
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            10'b0000000010: // S1
                if (in == 1)
                    next_state = 10'b0000000011; // S2
                else
                    next_state = 10'b0000000001; // S0
            10'b0000000011: // S2
                if (in == 1)
                    next_state = 10'b0000000100; // S3
                else
                    next_state = 10'b0000000001; // S0
            10'b0000000100: // S3
                if (in == 1)
                    next_state = 10'b0000000101; // S4
                else
                    next_state = 10'b0000000001; // S0
            10'b0000000101: // S4
                if (in == 1)
                    next_state = 10'b0000000110; // S5
                else
                    next_state = 10'b0000000001; // S0
            10'b0000000110: // S5
                if (in == 1)
                    next_state = 10'b0000010000; // S8
                else
                    next_state = 10'b0000000111; // S6
            10'b0000000111: // S6
                if (in == 1)
                    next_state = 10'b0000100001; // S7
                else
                    next_state = 10'b0000000001; // S0
            10'b0000100001: // S7
                if (in == 1)
                    next_state = 10'b0000000001; // S0
                else
                    next_state = 10'b0000100001; // S7
            10'b0000010000: // S8
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            10'b0000010000: // S9
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else
                    next_state = 10'b0000000001; // S0
            default:
                next_state = 10'b0000000000; // Undefined behavior
        endcase
    end
endmodule
