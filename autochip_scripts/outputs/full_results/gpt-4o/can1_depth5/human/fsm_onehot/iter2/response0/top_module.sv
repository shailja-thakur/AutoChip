module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default values for outputs and next_state
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        if (state[0] == 1'b1) begin
            next_state[0] = ~in;
            next_state[1] = in;
        end
        else if (state[1] == 1'b1) begin
            next_state[0] = ~in;
            next_state[2] = in;
        end
        else if (state[2] == 1'b1) begin
            next_state[0] = ~in;
            next_state[3] = in;
        end
        else if (state[3] == 1'b1) begin
            next_state[0] = ~in;
            next_state[4] = in;
        end
        else if (state[4] == 1'b1) begin
            next_state[0] = ~in;
            next_state[5] = in;
        end
        else if (state[5] == 1'b1) begin
            next_state[8] = ~in;
            next_state[6] = in;
        end
        else if (state[6] == 1'b1) begin
            next_state[9] = ~in;
            next_state[7] = in;
        end
        else if (state[7] == 1'b1) begin
            next_state[0] = ~in;
            next_state[7] = in;
            out2 = 1;
        end
        else if (state[8] == 1'b1) begin
            next_state[0] = ~in;
            next_state[1] = in;
            out1 = 1;
        end
        else if (state[9] == 1'b1) begin
            next_state[0] = ~in;
            next_state[1] = in;
            out1 = 1;
            out2 = 1;
        end
    end
endmodule
