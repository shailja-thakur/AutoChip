module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Initializing the next_state and outputs to default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;

        // State transition logic
        case (1'b1) // Synthesizing one-hot encoded states

            // State S0
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;

            // State S1
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;

            // State S2
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;

            // State S3
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;

            // State S4
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;

            // State S5
            state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000;

            // State S6
            state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000;

            // State S7
            state[7]: begin
                next_state = in ? 10'b0010000000 : 10'b0000000001;
                out2 = 1;
            end
            
            // State S8
            state[8]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 1;
            end

            // State S9
            state[9]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 1;
                out2 = 1;
            end

            // Default state
            default: next_state = 10'b0000000001; // should never happen
        endcase
    end

endmodule
