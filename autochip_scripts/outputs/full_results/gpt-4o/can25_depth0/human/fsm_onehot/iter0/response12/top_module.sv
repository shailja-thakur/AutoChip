module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default all outputs to 0
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        case (1'b1) // Turn state encoding into one-hot
            state[0]: next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S0
            state[1]: next_state = (in) ? 10'b0000000100 : 10'b0000000001; // S1
            state[2]: next_state = (in) ? 10'b0000001000 : 10'b0000000001; // S2
            state[3]: next_state = (in) ? 10'b0000010000 : 10'b0000000001; // S3
            state[4]: next_state = (in) ? 10'b0000100000 : 10'b0000000001; // S4
            state[5]: next_state = (in) ? 10'b0001000000 : 10'b0010000000; // S5
            state[6]: next_state = (in) ? 10'b0100000000 : 10'b1000000000; // S6
            state[7]: begin
                next_state = (in) ? 10'b0000001000 : 10'b0000000001; // S7
                out1 = 0;
                out2 = 1;
            end
            state[8]: begin
                next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S8
                out1 = 1;
                out2 = 0;
            end
            state[9]: begin
                next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S9
                out1 = 1;
                out2 = 1;
            end
            default: next_state = 10'b0000000001; // Safe state, default to S0
        endcase
    end
endmodule
