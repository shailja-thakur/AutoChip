module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default outputs
        out1 = 0;
        out2 = 0;
        next_state = 10'b0;

        // State transition logic
        case (1'b1) // synthesis parallel_case
            state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;
            state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;
            state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;
            state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;
            state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;
            state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000;
            state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000;
            state[7]: next_state = in ? 10'b0010000000 : 10'b0000000001;
            state[8]: next_state = in ? 10'b0000000010 : 10'b0000000001;
            state[9]: next_state = in ? 10'b0000000010 : 10'b0000000001;
            default: next_state = 10'b0000000001;
        endcase

        // Output logic
        case (1'b1) // synthesis parallel_case
            state[7]: begin
                out1 = 0;
                out2 = 1;
            end
            state[8]: begin
                out1 = 1;
                out2 = 0;
            end
            state[9]: begin
                out1 = 1;
                out2 = 1;
            end
        endcase
    end
endmodule
