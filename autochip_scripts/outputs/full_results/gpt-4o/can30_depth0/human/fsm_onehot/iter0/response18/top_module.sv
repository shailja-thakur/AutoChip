module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (1'b1)
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0 to S1 or S0
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1 to S2 or S0
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2 to S3 or S0
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3 to S4 or S0
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4 to S5 or S0
            state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5 to S6 or S8
            state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6 to S7 or S9
            state[7]: begin
                next_state = in ? 10'b0010000000 : 10'b0000000001; // S7 to S7 or S0
                out2 = 1;
            end
            state[8]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001; // S8 to S1 or S0
                out1 = 1;
            end
            state[9]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001; // S9 to S1 or S0
                out1 = 1;
                out2 = 1;
            end
        endcase
    end
endmodule
