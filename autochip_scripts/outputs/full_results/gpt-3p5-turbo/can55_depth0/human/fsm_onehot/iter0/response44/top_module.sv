module top_module (
        input in,
        input [9:0] state,
        output [9:0] next_state,
        output out1,
        output out2);

    assign out1 = (state[7] || state[9]);
    assign out2 = state[6];

    always @(*) begin
        case (state)
            10'b0000000001: next_state = 10'b0000000001; // S0 (0,0)
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1 (0,0)
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2 (0,0)
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3 (0,0)
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4 (0,0)
            10'b0000100000: next_state = in ? 10'b0010000000 : 10'b0000000010; // S5 (0,0)
            10'b0001000000: next_state = in ? 10'b0100000000 : 10'b0000000011; // S6 (0,0)
            10'b0010000000: next_state = in ? 10'b0111000000 : 10'b0000000001; // S7 (0,1)
            10'b0100000000: next_state = in ? 10'b0001000010 : 10'b0000000100; // S8 (1,0)
            10'b1000000000: next_state = in ? 10'b0001000100 : 10'b0000000100; // S9 (1,1)
            default: next_state = 10'b0000000001; // Default to S0 (0,0)
        endcase
    end

endmodule
