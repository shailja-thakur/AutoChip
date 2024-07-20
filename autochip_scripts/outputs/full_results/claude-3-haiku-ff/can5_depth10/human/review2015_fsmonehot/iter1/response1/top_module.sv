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

    if (state[8]) begin // B3
        B3_next = d;
    end
    else if (state[0]) begin // S
        S_next = ~d;
    end
    else if (state[1]) begin // S1
        S1_next = ~d | d;
    end
    else if (state[7]) begin // Count
        Count_next = ~done_counting;
    end
    else if (state[8]) begin // Wait
        Wait_next = ~ack;
    end

    // Output logic
    done = state[8];
    counting = state[7];
    shift_ena = state[4] | state[5] | state[6] | state[7];
end

endmodule
