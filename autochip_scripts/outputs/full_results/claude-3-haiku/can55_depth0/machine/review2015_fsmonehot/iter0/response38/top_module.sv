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
    // Initialize all outputs to 0
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    // Set outputs based on the current state
    if (state[0]) begin // State S
        if (d == 0) begin
            S_next = 1;
        end
    end
    else if (state[1]) begin // State S1
        if (d == 1) begin
            S1_next = 1;
        end
    end
    else if (state[2]) begin // State S11
        // No specific logic
    end
    else if (state[3]) begin // State S110
        if (d == 0) begin
            S_next = 1;
        end
    end
    else if (state[4]) begin // State B0
        shift_ena = 1;
    end
    else if (state[5]) begin // State B1
        shift_ena = 1;
    end
    else if (state[6]) begin // State B2
        shift_ena = 1;
        B3_next = 1;
    end
    else if (state[7]) begin // State B3
        shift_ena = 1;
        Count_next = 1;
    end
    else if (state[8]) begin // State Count
        counting = 1;
        if (!done_counting) begin
            Count_next = 1;
        end
    end
    else if (state[9]) begin // State Wait
        done = 1;
        if (ack == 0) begin
            Wait_next = 1;
        end
    end
end

endmodule
