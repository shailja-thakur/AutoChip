module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

always @(*) begin
    // Next-state logic
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;

    if (state[8] & d) begin
        B3_next = 1'b1;
    end
    else if (state[0] & ~d) begin
        S_next = 1'b1;
    end
    else if (state[1] & ~d) begin
        S1_next = 1'b1;
    end
    else if (state[2] & d) begin
        S1_next = 1'b1;
    end
    else if (state[7] & ~done_counting) begin
        Count_next = 1'b1;
    end
    else if (state[9] & ~ack) begin
        Wait_next = 1'b1;
    end
    else if (state[7] & done_counting) begin
        Wait_next = 1'b1;
    end
    else if (state[9] & ack) begin
        S_next = 1'b1;
    end

    // Output logic
    done = state[9];
    counting = state[7];
    shift_ena = state[4] | state[5] | state[6] | state[7];
end

endmodule
