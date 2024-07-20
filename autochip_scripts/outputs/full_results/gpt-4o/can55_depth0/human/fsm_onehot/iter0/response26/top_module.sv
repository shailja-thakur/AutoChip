module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    always @(*) begin
        // Default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (1'b1) // S0 - S9 represented as 1-hot encoding
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
            state[5]: next_state = in ? 10'b0001000000 : 10'b0000001000; // S5
            state[6]: next_state = in ? 10'b0010000000 : 10'b0000100000; // S6
            state[7]: begin // S7
                next_state = in ? 10'b0100000000 : 10'b0000000001;
                out2 = 1;
            end
            state[8]: begin // S8
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 1;
            end
            state[9]: begin // S9
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 1;
                out2 = 1;
            end
        endcase
    end

endmodule
