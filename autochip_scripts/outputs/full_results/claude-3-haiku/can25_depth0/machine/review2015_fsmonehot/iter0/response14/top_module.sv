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
    if (state[9]) begin // state = Wait
        Wait_next = 1'b1;
        done = 1'b1;
    end
    else if (state[8]) begin // state = Count
        Count_next = 1'b1;
        counting = 1'b1;
    end
    else if (state[7]) begin // state = B3
        B3_next = 1'b1;
        shift_ena = 1'b1;
    end
    else if (state[6]) begin // state = B2
        B3_next = 1'b1;
        shift_ena = 1'b1;
    end
    else if (state[5]) begin // state = B1
        shift_ena = 1'b1;
    end
    else if (state[4]) begin // state = B0
        shift_ena = 1'b1;
    end
    else if (state[3]) begin // state = S110
        S_next = ~d;
    end
    else if (state[2]) begin // state = S1
        S1_next = d;
    end
    else if (state[1]) begin // state = S
        S_next = ~d;
    end

    // Additional logic
    if ((state[7] && done_counting) || (state[9] && !ack)) begin
        Wait_next = 1'b1;
    end
    if ((state[8] && !done_counting) || (state[7])) begin
        Count_next = 1'b1;
    end
end

endmodule
