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

    // Set outputs based on current state
    if (state[0]) begin  // S
        S_next = (d == 1'b0);
        S1_next = (d == 1'b1);
    end
    else if (state[1]) begin  // S1
        S_next = (d == 1'b0);
        S1_next = (d == 1'b1);
    end
    else if (state[2]) begin  // S11
        // No outputs set for this state
    end
    else if (state[3]) begin  // S110
        S_next = (d == 1'b0);
    end
    else if (state[4]) begin  // B0
        shift_ena = 1'b1;
    end
    else if (state[5]) begin  // B1
        shift_ena = 1'b1;
    end
    else if (state[6]) begin  // B2
        shift_ena = 1'b1;
        B3_next = 1'b1;
    end
    else if (state[7]) begin  // B3
        shift_ena = 1'b1;
        Count_next = 1'b1;
    end
    else if (state[8]) begin  // Count
        counting = 1'b1;
        Count_next = (done_counting == 1'b0);
        Wait_next = (done_counting == 1'b1);
    end
    else if (state[9]) begin  // Wait
        done = 1'b1;
        Wait_next = (ack == 1'b0);
    end
end

endmodule
