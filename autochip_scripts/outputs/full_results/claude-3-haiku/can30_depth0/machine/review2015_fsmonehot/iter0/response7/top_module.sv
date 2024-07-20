module top_module (
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
    // Default assignments
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    // Assign outputs based on state
    if (state[9]) begin  // Wait state
        Wait_next = 1'b1;
        done = 1'b1;
    end
    else if (state[8]) begin  // Count state
        Count_next = 1'b1;
        counting = 1'b1;
    end
    else if (state[7]) begin  // B3 state
        B3_next = 1'b1;
        shift_ena = 1'b1;
    end
    else if (state[6]) begin  // B2 state
        shift_ena = 1'b1;
    end
    else if (state[5]) begin  // B1 state
        shift_ena = 1'b1;
    end
    else if (state[4]) begin  // B0 state
        shift_ena = 1'b1;
    end
    else if (state[3]) begin  // S110 state
        if (d == 1'b0)
            S_next = 1'b1;
    end
    else if (state[2]) begin  // S1 state
        if (d == 1'b1)
            S1_next = 1'b1;
    end
    else if (state[1]) begin  // S state
        if (d == 1'b0)
            S_next = 1'b1;
    end
end

endmodule
