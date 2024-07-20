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
    // Initialize outputs to 0
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    // Combinational logic for outputs
    if (state[9]) begin // State: Wait
        done = 1'b1;
    end
    if (state[8]) begin // State: Count
        counting = 1'b1;
    end
    if (state[7] || state[6] || state[5] || state[4]) begin // States: B3, B2, B1, B0
        shift_ena = 1'b1;
    end
    if (state[2]) begin // State: B2
        B3_next = 1'b1;
    end
    if ((state[0] && !d) || (state[1] && !d) || (state[3] && !d) || (state[9] && ack)) begin // States: S, S1, S110, Wait
        S_next = 1'b1;
    end
    if (state[0] && d) begin // State: S
        S1_next = 1'b1;
    end
    if ((state[7] && !done_counting) || (state[8] && !done_counting)) begin // States: B3, Count
        Count_next = 1'b1;
    end
    if ((state[8] && done_counting) || (state[9] && !ack)) begin // States: Count, Wait
        Wait_next = 1'b1;
    end
end

endmodule
