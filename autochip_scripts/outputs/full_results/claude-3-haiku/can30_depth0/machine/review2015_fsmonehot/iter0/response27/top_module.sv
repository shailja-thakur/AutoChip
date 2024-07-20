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

    // Set outputs based on state
    if (state[9]) begin // State: Wait
        Wait_next = 1'b1;
        done = 1'b1;
    end
    else if (state[8]) begin // State: Count
        Count_next = 1'b1;
        counting = 1'b1;
    end
    else if (state[7]) begin // State: B3
        B3_next = 1'b1;
        shift_ena = 1'b1;
    end
    else if (state[6]) begin // State: B2
        B3_next = 1'b1;
        shift_ena = 1'b1;
    end
    else if (state[5]) begin // State: B1
        shift_ena = 1'b1;
    end
    else if (state[4]) begin // State: B0
        shift_ena = 1'b1;
    end
    else if (state[3]) begin // State: S110
        S_next = ~d;
    end
    else if (state[2]) begin // State: S1
        S1_next = d;
    end
    else if (state[1]) begin // State: S
        S_next = ~d;
    end
end

endmodule
