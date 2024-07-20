module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg S110_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

    // Next-state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        S110_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        if (state[0] && ~d) begin
            S_next = 1'b1;
        end
        else if (state[0] && d) begin
            S1_next = 1'b1;
        end
        else if (state[1] && ~d) begin
            S_next = 1'b1;
        end
        else if (state[1] && d) begin
            S1_next = 1'b1;
        end
        else if (state[2] && ~d) begin
            S110_next = 1'b1;
        end
        else if (state[2] && d) begin
            S1_next = 1'b1;
        end
        else if (state[3] && ~d) begin
            S_next = 1'b1;
        end
        else if (state[3] && d) begin
            B3_next = 1'b1;
        end
        else if (state[8] && ~done_counting) begin
            Count_next = 1'b1;
        end
        else if (state[9] && ~ack) begin
            Wait_next = 1'b1;
        end
        else if (state[9] && ack) begin
            S_next = 1'b1;
        end
        else if (state[8] && done_counting) begin
            Wait_next = 1'b1;
        end
    end

    // Output logic
    always @(*) begin
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        if (state[9]) begin
            done = 1'b1;
        end
        if (state[8]) begin
            counting = 1'b1;
        end
        if (state[4] || state[5] || state[6] || state[7]) begin
            shift_ena = 1'b1;
        end
    end

endmodule
