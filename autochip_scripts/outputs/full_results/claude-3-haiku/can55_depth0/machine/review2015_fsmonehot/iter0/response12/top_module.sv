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
    // Default values
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    // Combinational logic
    if (state[9]) begin // Wait state
        done = 1'b1;
    end
    else if (state[8]) begin // Count state
        counting = 1'b1;
        Count_next = !done_counting;
    end
    else if (state[7] || state[6] || state[5] || state[4]) begin // B3, B2, B1, B0 states
        shift_ena = 1'b1;
    end
    else if (state[3]) begin // B2 state
        B3_next = 1'b1;
    end
    else if (state[2] && d == 1'b0) begin // S110 state
        S_next = 1'b1;
    end
    else if (state[1] && d == 1'b0) begin // S1 state
        S_next = 1'b1;
    end
    else if (state[0] && d == 1'b0) begin // S state
        S_next = 1'b1;
    end
    else if (state[0] && d == 1'b1) begin // S state
        S1_next = 1'b1;
    end
    else if (state[8] && done_counting) begin // Count state
        Wait_next = 1'b1;
    end
    else if (state[9] && !ack) begin // Wait state
        Wait_next = 1'b1;
    end
end

endmodule
